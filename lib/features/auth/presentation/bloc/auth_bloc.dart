import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/core/error/failures.dart';
import 'package:stadium_eye/core/services/session_expired_notifier.dart';
import '../../domain/usecases/forgot_password_usecase.dart';
import '../../domain/usecases/get_cached_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/verify_email_usecase.dart';
import '../../domain/usecases/verify_reset_code_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final VerifyEmailUseCase verifyEmailUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCachedUserUseCase getCachedUserUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final VerifyResetCodeUseCase verifyResetCodeUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  StreamSubscription<void>? _sessionExpiredSubscription;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.verifyEmailUseCase,
    required this.logoutUseCase,
    required this.getCachedUserUseCase,
    required this.forgotPasswordUseCase,
    required this.verifyResetCodeUseCase,
    required this.resetPasswordUseCase,
  }) : super(const AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<VerifyEmailEvent>(_onVerifyEmail);
    on<LogoutEvent>(_onLogout);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<ForgotPasswordEvent>(_onForgotPassword);
    on<VerifyResetCodeEvent>(_onVerifyResetCode);
    on<ResetPasswordEvent>(_onResetPassword);
    on<SessionExpiredEvent>(_onSessionExpired);

    // Any API call across the app (via AuthInterceptor) can report a 401
    // through this stream. When that happens we log the user out exactly
    // once, so the *next* app launch goes straight to the login/landing
    // screen instead of repeatedly trying to load data with the same
    // expired token and showing the same error every time.
    _sessionExpiredSubscription = SessionExpiredNotifier
        .instance
        .onSessionExpired
        .listen((_) => add(const SessionExpiredEvent()));
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    final result = await loginUseCase(event.email, event.password);

    result.fold((failure) => emit(AuthError(_mapFailureToMessage(failure))), (
      user,
    ) {
      SessionExpiredNotifier.instance.reset();
      emit(AuthAuthenticated(user));
    });
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    final result = await registerUseCase(event.params);

    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (user) => emit(
        AuthRegistrationSuccess(
          user: user,
          message: 'Verification OTP is sent to your Email',
        ),
      ),
    );
  }

  Future<void> _onVerifyEmail(
    VerifyEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await verifyEmailUseCase(event.email, event.code);

    result.fold((failure) => emit(AuthError(_mapFailureToMessage(failure))), (
      user,
    ) {
      SessionExpiredNotifier.instance.reset();
      emit(
        AuthVerificationSuccess(
          user: user,
          message: 'The Account is verified successfully',
        ),
      );
    });
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    final result = await logoutUseCase();

    result.fold((failure) => emit(AuthError(_mapFailureToMessage(failure))), (
      _,
    ) {
      SessionExpiredNotifier.instance.reset();
      emit(const AuthUnauthenticated());
    });
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLodingForCheckAuthStatus());

    final result = await getCachedUserUseCase();

    result.fold((failure) => emit(const AuthUnauthenticated()), (user) {
      if (user != null && user.token != null) {
        SessionExpiredNotifier.instance.reset();
        emit(AuthAuthenticated(user));
      } else {
        emit(const AuthUnauthenticated());
      }
    });
  }

  Future<void> _onForgotPassword(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await forgotPasswordUseCase(event.email);

    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (message) => emit(AuthForgotPasswordSuccess(message)),
    );
  }

  Future<void> _onVerifyResetCode(
    VerifyResetCodeEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await verifyResetCodeUseCase(event.email, event.code);

    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (message) => emit(AuthResetCodeVerified(message)),
    );
  }

  Future<void> _onResetPassword(
    ResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await resetPasswordUseCase(event.email, event.newPassword);

    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (message) => emit(AuthPasswordResetSuccess(message)),
    );
  }

  /// Triggered whenever any request anywhere in the app comes back with a
  /// 401 (see [SessionExpiredNotifier]). Reuses the same [logoutUseCase]
  /// the manual "Logout" button uses, so the cached token/user are cleared
  /// the exact same way, then flips the app to the unauthenticated state.
  /// Every screen already listening for [AuthUnauthenticated] (Home,
  /// NavigatorPage, ...) will react and send the user to the login /
  /// landing screen automatically.
  Future<void> _onSessionExpired(
    SessionExpiredEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (state is AuthUnauthenticated) {
      // Already logged out - nothing to do, just re-arm the notifier.
      SessionExpiredNotifier.instance.reset();
      return;
    }

    await logoutUseCase();
    SessionExpiredNotifier.instance.reset();
    emit(const AuthUnauthenticated());
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message;
  }

  @override
  Future<void> close() {
    _sessionExpiredSubscription?.cancel();
    return super.close();
  }
}

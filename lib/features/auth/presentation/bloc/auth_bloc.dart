import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/core/error/failures.dart';
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
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    final result = await loginUseCase(event.email, event.password);

    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (user) => emit(AuthAuthenticated(user)),
    );
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

    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    final result = await logoutUseCase();

    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (_) => emit(const AuthUnauthenticated()),
    );
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLodingForCheckAuthStatus());

    final result = await getCachedUserUseCase();

    result.fold((failure) => emit(const AuthUnauthenticated()), (user) {
      if (user != null && user.token != null) {
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

  String _mapFailureToMessage(Failure failure) {
    return failure.message;
  }
}

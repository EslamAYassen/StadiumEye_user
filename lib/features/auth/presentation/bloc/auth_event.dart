import 'package:equatable/equatable.dart';
import '../../domain/usecases/register_usecase.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RegisterEvent extends AuthEvent {
  final RegisterParams params;

  const RegisterEvent(this.params);

  @override
  List<Object?> get props => [params];
}

class VerifyEmailEvent extends AuthEvent {
  final String email;
  final String code;

  const VerifyEmailEvent({required this.email, required this.code});

  @override
  List<Object?> get props => [email, code];
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}

/// Fired internally whenever [SessionExpiredNotifier] reports a 401 from
/// any API call across the app, so [AuthBloc] can log the user out exactly
/// once instead of repeatedly retrying with the same invalid token.
class SessionExpiredEvent extends AuthEvent {
  const SessionExpiredEvent();
}

class CheckAuthStatusEvent extends AuthEvent {
  const CheckAuthStatusEvent();
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  const ForgotPasswordEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class VerifyResetCodeEvent extends AuthEvent {
  final String email;
  final String code;

  const VerifyResetCodeEvent({required this.email, required this.code});

  @override
  List<Object?> get props => [email, code];
}

class ResetPasswordEvent extends AuthEvent {
  final String email;
  final String newPassword;

  const ResetPasswordEvent({required this.email, required this.newPassword});

  @override
  List<Object?> get props => [email, newPassword];
}

import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLodingForCheckAuthStatus extends AuthState {
  const AuthLodingForCheckAuthStatus();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  final UserEntity user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthRegistrationSuccess extends AuthState {
  final UserEntity user;
  final String message;

  const AuthRegistrationSuccess({required this.user, required this.message});

  @override
  List<Object?> get props => [user, message];
}

class AuthVerificationSuccess extends AuthState {
  final UserEntity user;
  final String message;

  const AuthVerificationSuccess({required this.user, required this.message});

  @override
  List<Object?> get props => [user, message];
}

class AuthForgotPasswordSuccess extends AuthState {
  final String message;

  const AuthForgotPasswordSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthResetCodeVerified extends AuthState {
  final String message;

  const AuthResetCodeVerified(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthPasswordResetSuccess extends AuthState {
  final String message;

  const AuthPasswordResetSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

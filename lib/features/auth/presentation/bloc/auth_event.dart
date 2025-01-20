part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String displayName;

  const SignUpEvent({
    required this.email,
    required this.password,
    required this.displayName,
  });

  @override
  List<Object?> get props => [email, password, displayName];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class ResetPasswordEvent extends AuthEvent {
  final String email;

  const ResetPasswordEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class DeleteAccountEvent extends AuthEvent {
  final String uid;

  const DeleteAccountEvent(this.uid);

  @override
  List<Object?> get props => [uid];
}

class GetUserEvent extends AuthEvent {
  const GetUserEvent();

  @override
  List<Object?> get props => [];
}

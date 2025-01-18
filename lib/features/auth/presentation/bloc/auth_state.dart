part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String? message;

  const AuthSuccess({this.message});

  @override
  List<Object?> get props => [message];
}

class SignInSuccess extends AuthState {
  final UserModel userModel;

  const SignInSuccess({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

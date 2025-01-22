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
  final String? token;

  const SignInSuccess({required this.token});

  @override
  List<Object?> get props => [token];
}

class UpdateUserSuccess extends AuthState {
  final String newToken;

  const UpdateUserSuccess({required this.newToken});

  @override
  List<Object?> get props => [newToken];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class GetUserSuccess extends AuthState {
  final UserModel userModel;

  const GetUserSuccess({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}

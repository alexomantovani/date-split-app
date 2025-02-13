import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:date_split_app/features/auth/data/models/user_model.dart';
import 'package:date_split_app/features/auth/domain/usecases/delete_account.dart';
import 'package:date_split_app/features/auth/domain/usecases/get_user.dart';
import 'package:date_split_app/features/auth/domain/usecases/reset_password.dart';
import 'package:date_split_app/features/auth/domain/usecases/signin.dart';
import 'package:date_split_app/features/auth/domain/usecases/signup.dart';
import 'package:date_split_app/features/auth/domain/usecases/update_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required Signup signup,
    required SignIn signIn,
    required ResetPassword resetPassword,
    required DeleteAccount deleteAccount,
    required GetUser getUser,
    required UpdateUser updateUser,
  })  : _signUp = signup,
        _signIn = signIn,
        _resetPassword = resetPassword,
        _deleteAccount = deleteAccount,
        _getUser = getUser,
        _updateUser = updateUser,
        super(AuthInitial()) {
    on<SignUpEvent>(_onSignUp);
    on<SignInEvent>(_onSignIn);
    on<ResetPasswordEvent>(_onResetPassword);
    on<DeleteAccountEvent>(_onDeleteAccount);
    on<GetUserEvent>(_onGetUser);
    on<UpdateUserEvent>(_onUpdateUser);
    on<RestartEvent>(_onRestartState);
  }

  final Signup _signUp;
  final SignIn _signIn;
  final ResetPassword _resetPassword;
  final DeleteAccount _deleteAccount;
  final GetUser _getUser;
  final UpdateUser _updateUser;

  Future<void> _onRestartState(
      RestartEvent event, Emitter<AuthState> emit) async {
    emit(AuthInitial());
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _signUp.call(SignUpParams(
      email: event.email,
      displayName: event.displayName,
      password: event.password,
    ));

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (message) => emit(AuthSuccess(message: message)),
    );
  }

  Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _signIn.call(SignInParams(
      email: event.email,
      password: event.password,
    ));
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (token) => emit(SignInSuccess(token: token)),
    );
  }

  Future<void> _onUpdateUser(
      UpdateUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _updateUser.call(UpdateUserParams(
      avatar: event.avatar,
      nickName: event.nickName,
    ));
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (newToken) => emit(
        UpdateUserSuccess(newToken: newToken),
      ),
    );
  }

  Future<void> _onResetPassword(
      ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _resetPassword.call(event.email);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (message) => emit(AuthSuccess(message: message)),
    );
  }

  Future<void> _onDeleteAccount(
      DeleteAccountEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _deleteAccount.call(event.uid);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (message) => emit(AuthSuccess(message: message)),
    );
  }

  Future<void> _onGetUser(GetUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _getUser.call();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (userModel) => emit(GetUserSuccess(userModel: userModel)),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:date_split_app/features/auth/domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignUpEvent>(_onSignUp);
    on<SignInEvent>(_onSignIn);
    on<ResetPasswordEvent>(_onResetPassword);
    on<DeleteAccountEvent>(_onDeleteAccount);
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authRepository.signUp(
      event.email,
      event.password,
      event.displayName,
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (uid) => emit(AuthSuccess(uid: uid)),
    );
  }

  Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authRepository.signIn(event.email, event.password);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const AuthSuccess(uid: null)),
    );
  }

  Future<void> _onResetPassword(
      ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authRepository.resetPassword(event.email);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const AuthSuccess(uid: null)),
    );
  }

  Future<void> _onDeleteAccount(
      DeleteAccountEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authRepository.deleteAccount(event.uid);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const AuthSuccess(uid: null)),
    );
  }
}

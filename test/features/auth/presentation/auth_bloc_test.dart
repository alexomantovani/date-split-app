import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:date_split_app/features/auth/data/models/user_model.dart';
import 'package:date_split_app/features/auth/domain/usecases/delete_account.dart';
import 'package:date_split_app/features/auth/domain/usecases/reset_password.dart';
import 'package:date_split_app/features/auth/domain/usecases/signin.dart';
import 'package:date_split_app/features/auth/domain/usecases/signup.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:date_split_app/core/errors/failure.dart';
import 'package:date_split_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:date_split_app/features/auth/domain/repositories/auth_repository.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateMocks([AuthRepository, Signup, SignIn, ResetPassword, DeleteAccount])
void main() {
  late AuthBloc authBloc;
  late Signup signUp;
  late SignIn signIn;
  late ResetPassword resetPassword;
  late DeleteAccount deleteAccount;

  setUp(() {
    signUp = MockSignup();
    signIn = MockSignIn();
    resetPassword = MockResetPassword();
    deleteAccount = MockDeleteAccount();
    authBloc = AuthBloc(
        signup: signUp,
        signIn: signIn,
        resetPassword: resetPassword,
        deleteAccount: deleteAccount);
  });

  tearDown(() {
    authBloc.close();
  });

  group('SignUp', () {
    const email = 'test@example.com';
    const password = 'password123';
    const displayName = 'Test User';
    const message = 'message';

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] on successful sign-up',
      build: () {
        when(signUp.call(const SignUpParams(
                email: email, displayName: displayName, password: password)))
            .thenAnswer((_) async => const Right(message));
        return authBloc;
      },
      act: (bloc) => bloc.add(const SignUpEvent(
        email: email,
        password: password,
        displayName: displayName,
      )),
      expect: () => [AuthLoading(), const AuthSuccess(message: message)],
      verify: (_) {
        verify(signUp.call(const SignUpParams(
                email: email, displayName: displayName, password: password)))
            .called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] on sign-up failure',
      build: () {
        when(signUp.call(const SignUpParams(
                email: email, displayName: displayName, password: password)))
            .thenAnswer((_) async => const Left(ServerFailure(
                  message: 'Server error',
                  statusCode: 500,
                )));
        return authBloc;
      },
      act: (bloc) => bloc.add(const SignUpEvent(
        email: email,
        password: password,
        displayName: displayName,
      )),
      expect: () => [AuthLoading(), const AuthError('Server error')],
      verify: (_) {
        verify(signUp.call(const SignUpParams(
                email: email, displayName: displayName, password: password)))
            .called(1);
      },
    );
  });

  group('SignIn', () {
    const email = 'test@example.com';
    const password = 'password123';
    const userModel = UserModel.empty();

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, SignInSuccess] on successful sign-in',
      build: () {
        when(signIn.call(const SignInParams(email: email, password: password)))
            .thenAnswer((_) async => const Right(userModel));
        return authBloc;
      },
      act: (bloc) => bloc.add(const SignInEvent(
        email: email,
        password: password,
      )),
      expect: () => [AuthLoading(), const SignInSuccess(userModel: userModel)],
      verify: (_) {
        verify(signIn
                .call(const SignInParams(email: email, password: password)))
            .called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] on sign-in failure',
      build: () {
        when(signIn.call(const SignInParams(email: email, password: password)))
            .thenAnswer((_) async => const Left(ServerFailure(
                  message: 'Invalid credentials',
                  statusCode: 401,
                )));
        return authBloc;
      },
      act: (bloc) => bloc.add(const SignInEvent(
        email: email,
        password: password,
      )),
      expect: () => [AuthLoading(), const AuthError('Invalid credentials')],
      verify: (_) {
        verify(signIn
                .call(const SignInParams(email: email, password: password)))
            .called(1);
      },
    );
  });

  group('ResetPassword', () {
    const email = 'test@example.com';
    const message = 'message';

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] on successful password reset',
      build: () {
        when(resetPassword.call(email))
            .thenAnswer((_) async => const Right(message));
        return authBloc;
      },
      act: (bloc) => bloc.add(const ResetPasswordEvent(email)),
      expect: () => [AuthLoading(), const AuthSuccess(message: message)],
      verify: (_) {
        verify(resetPassword.call(email)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] on reset password failure',
      build: () {
        when(resetPassword.call(email))
            .thenAnswer((_) async => const Left(ServerFailure(
                  message: 'Email not found',
                  statusCode: 404,
                )));
        return authBloc;
      },
      act: (bloc) => bloc.add(const ResetPasswordEvent(email)),
      expect: () => [AuthLoading(), const AuthError('Email not found')],
      verify: (_) {
        verify(resetPassword.call(email)).called(1);
      },
    );
  });

  group('DeleteAccount', () {
    const message = 'testmessage123';

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] on successful account deletion',
      build: () {
        when(deleteAccount.call(message))
            .thenAnswer((_) async => const Right(message));
        return authBloc;
      },
      act: (bloc) => bloc.add(const DeleteAccountEvent(message)),
      expect: () => [AuthLoading(), const AuthSuccess(message: message)],
      verify: (_) {
        verify(deleteAccount.call(message)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] on account deletion failure',
      build: () {
        when(deleteAccount.call(message))
            .thenAnswer((_) async => const Left(ServerFailure(
                  message: 'Account not found',
                  statusCode: 404,
                )));
        return authBloc;
      },
      act: (bloc) => bloc.add(const DeleteAccountEvent(message)),
      expect: () => [AuthLoading(), const AuthError('Account not found')],
      verify: (_) {
        verify(deleteAccount.call(message)).called(1);
      },
    );
  });
}

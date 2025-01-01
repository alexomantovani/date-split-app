import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:date_split_app/core/errors/failure.dart';
import 'package:date_split_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:date_split_app/features/auth/domain/repositories/auth_repository.dart';

import '../domain/usecases/usecases_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository mockAuthRepository;
  late AuthBloc authBloc;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authBloc = AuthBloc(authRepository: mockAuthRepository);
  });

  tearDown(() {
    authBloc.close();
  });

  group('SignUp', () {
    const email = 'test@example.com';
    const password = 'password123';
    const displayName = 'Test User';
    const uid = 'testUid123';

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] on successful sign-up',
      build: () {
        when(mockAuthRepository.signUp(email, password, displayName))
            .thenAnswer((_) async => const Right(uid));
        return authBloc;
      },
      act: (bloc) => bloc.add(const SignUpEvent(
        email: email,
        password: password,
        displayName: displayName,
      )),
      expect: () => [AuthLoading(), const AuthSuccess(uid: uid)],
      verify: (_) {
        verify(mockAuthRepository.signUp(email, password, displayName))
            .called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] on sign-up failure',
      build: () {
        when(mockAuthRepository.signUp(email, password, displayName))
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
        verify(mockAuthRepository.signUp(email, password, displayName))
            .called(1);
      },
    );
  });

  group('SignIn', () {
    const email = 'test@example.com';
    const password = 'password123';

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] on successful sign-in',
      build: () {
        when(mockAuthRepository.signIn(email, password))
            .thenAnswer((_) async => const Right(null));
        return authBloc;
      },
      act: (bloc) => bloc.add(const SignInEvent(
        email: email,
        password: password,
      )),
      expect: () => [AuthLoading(), const AuthSuccess(uid: null)],
      verify: (_) {
        verify(mockAuthRepository.signIn(email, password)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] on sign-in failure',
      build: () {
        when(mockAuthRepository.signIn(email, password))
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
        verify(mockAuthRepository.signIn(email, password)).called(1);
      },
    );
  });

  group('ResetPassword', () {
    const email = 'test@example.com';

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] on successful password reset',
      build: () {
        when(mockAuthRepository.resetPassword(email))
            .thenAnswer((_) async => const Right(null));
        return authBloc;
      },
      act: (bloc) => bloc.add(const ResetPasswordEvent(email)),
      expect: () => [AuthLoading(), const AuthSuccess(uid: null)],
      verify: (_) {
        verify(mockAuthRepository.resetPassword(email)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] on reset password failure',
      build: () {
        when(mockAuthRepository.resetPassword(email))
            .thenAnswer((_) async => const Left(ServerFailure(
                  message: 'Email not found',
                  statusCode: 404,
                )));
        return authBloc;
      },
      act: (bloc) => bloc.add(const ResetPasswordEvent(email)),
      expect: () => [AuthLoading(), const AuthError('Email not found')],
      verify: (_) {
        verify(mockAuthRepository.resetPassword(email)).called(1);
      },
    );
  });

  group('DeleteAccount', () {
    const uid = 'testUid123';

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] on successful account deletion',
      build: () {
        when(mockAuthRepository.deleteAccount(uid))
            .thenAnswer((_) async => const Right(null));
        return authBloc;
      },
      act: (bloc) => bloc.add(const DeleteAccountEvent(uid)),
      expect: () => [AuthLoading(), const AuthSuccess(uid: null)],
      verify: (_) {
        verify(mockAuthRepository.deleteAccount(uid)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] on account deletion failure',
      build: () {
        when(mockAuthRepository.deleteAccount(uid))
            .thenAnswer((_) async => const Left(ServerFailure(
                  message: 'Account not found',
                  statusCode: 404,
                )));
        return authBloc;
      },
      act: (bloc) => bloc.add(const DeleteAccountEvent(uid)),
      expect: () => [AuthLoading(), const AuthError('Account not found')],
      verify: (_) {
        verify(mockAuthRepository.deleteAccount(uid)).called(1);
      },
    );
  });
}

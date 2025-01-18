import 'package:dartz/dartz.dart';
import 'package:date_split_app/core/errors/failure.dart';
import 'package:date_split_app/features/auth/data/models/user_model.dart';
import 'package:date_split_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'usecases_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
  });

  group('AuthRepository', () {
    test('should sign up successfully', () async {
      // Arrange
      const email = 'test@example.com';
      const password = 'password123';
      const displayName = 'Test User';
      const message = 'message';

      // Certifique-se de que o mock foi configurado corretamente.
      when(mockAuthRepository.signUp(
              email: email, password: password, displayName: displayName))
          .thenAnswer((_) async => const Right(message));

      // Act
      final result = await mockAuthRepository.signUp(
          email: email, password: password, displayName: displayName);

      // Assert
      expect(result, equals(const Right(message)));
      verify(mockAuthRepository.signUp(
              email: email, password: password, displayName: displayName))
          .called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return Failure on sign up failure', () async {
      // Arrange
      const email = 'test@example.com';
      const password = '123';
      const displayName = 'Test User';
      const failure =
          ServerFailure(message: 'Password too short', statusCode: 400);

      when(mockAuthRepository.signUp(
              email: email, password: password, displayName: displayName))
          .thenAnswer((_) async => const Left(failure));

      // Act
      final result = await mockAuthRepository.signUp(
          email: email, password: password, displayName: displayName);

      // Assert
      expect(result, equals(const Left(failure)));
      verify(mockAuthRepository.signUp(
              email: email, password: password, displayName: displayName))
          .called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return UserModel on successful sign in', () async {
      // Arrange
      const email = 'test@example.com';
      const password = 'password123';
      const userModel = UserModel.empty();

      when(mockAuthRepository.signIn(email: email, password: password))
          .thenAnswer((_) async => const Right(userModel));

      // Act
      final result =
          await mockAuthRepository.signIn(email: email, password: password);

      // Assert
      expect(result, equals(const Right(userModel)));
      verify(mockAuthRepository.signIn(email: email, password: password))
          .called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return Failure on sign in failure', () async {
      // Arrange
      const email = 'test@example.com';
      const password = 'wrongpassword';
      const failure =
          ServerFailure(message: 'Invalid credentials', statusCode: 401);

      when(mockAuthRepository.signIn(email: email, password: password))
          .thenAnswer((_) async => const Left(failure));

      // Act
      final result =
          await mockAuthRepository.signIn(email: email, password: password);

      // Assert
      expect(result, equals(const Left(failure)));
      verify(mockAuthRepository.signIn(email: email, password: password))
          .called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return message on successful reset password', () async {
      // Arrange
      const email = 'test@example.com';
      const message = 'message';

      when(mockAuthRepository.resetPassword(email: email))
          .thenAnswer((_) async => const Right(message));

      // Act
      final result = await mockAuthRepository.resetPassword(email: email);

      // Assert
      expect(result, equals(const Right(message)));
      verify(mockAuthRepository.resetPassword(email: email)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return Failure on reset password failure', () async {
      // Arrange
      const email = 'test@example.com';
      const failure =
          ServerFailure(message: 'Email not found', statusCode: 404);

      when(mockAuthRepository.resetPassword(email: email))
          .thenAnswer((_) async => const Left(failure));

      // Act
      final result = await mockAuthRepository.resetPassword(email: email);

      // Assert
      expect(result, equals(const Left(failure)));
      verify(mockAuthRepository.resetPassword(email: email)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return message on successful account deletion', () async {
      // Arrange
      const uid = 'testUid123';
      const message = 'message';

      when(mockAuthRepository.deleteAccount(uid: uid))
          .thenAnswer((_) async => const Right(message));

      // Act
      final result = await mockAuthRepository.deleteAccount(uid: uid);

      // Assert
      expect(result, equals(const Right(message)));
      verify(mockAuthRepository.deleteAccount(uid: uid)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return Failure on account deletion failure', () async {
      // Arrange
      const uid = 'testUid123';
      const failure =
          ServerFailure(message: 'Account not found', statusCode: 404);

      when(mockAuthRepository.deleteAccount(uid: uid))
          .thenAnswer((_) async => const Left(failure));

      // Act
      final result = await mockAuthRepository.deleteAccount(uid: uid);

      // Assert
      expect(result, equals(const Left(failure)));
      verify(mockAuthRepository.deleteAccount(uid: uid)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}

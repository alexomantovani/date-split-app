import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:date_split_app/core/errors/failure.dart';
import 'package:date_split_app/features/auth/data/models/user_model.dart';
import 'package:date_split_app/features/auth/domain/repositories/auth_repository.dart';

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

    test('should return Token on successful sign in', () async {
      // Arrange
      const email = 'test@example.com';
      const password = 'password123';
      const token = 'token';

      when(mockAuthRepository.signIn(email: email, password: password))
          .thenAnswer((_) async => const Right(token));

      // Act
      final result =
          await mockAuthRepository.signIn(email: email, password: password);

      // Assert
      expect(result, equals(const Right(token)));
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
    test('should return newToken on successful update', () async {
      // Arrange
      const avatar = 'avatar';
      const nickName = 'nickName';
      const newToken = 'newToken';

      when(mockAuthRepository.updateUser(avatar: avatar, nickName: nickName))
          .thenAnswer((_) async => const Right(newToken));

      // Act
      final result = await mockAuthRepository.updateUser(
          avatar: avatar, nickName: nickName);

      // Assert
      expect(result, equals(const Right(newToken)));
      verify(mockAuthRepository.updateUser(avatar: avatar, nickName: nickName))
          .called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return Failure on updateUser failure', () async {
      // Arrange
      const avatar = 'avatar';
      const nickName = 'nickName';
      const failure = ServerFailure(message: 'Expired Token', statusCode: 401);

      when(mockAuthRepository.updateUser(avatar: avatar, nickName: nickName))
          .thenAnswer((_) async => const Left(failure));

      // Act
      final result = await mockAuthRepository.updateUser(
          avatar: avatar, nickName: nickName);

      // Assert
      expect(result, equals(const Left(failure)));
      verify(mockAuthRepository.updateUser(avatar: avatar, nickName: nickName))
          .called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
    test('should return UserModel on successful getUser', () async {
      // Arrange
      const userModel = UserModel.empty();

      when(mockAuthRepository.getUser())
          .thenAnswer((_) async => const Right(userModel));

      // Act
      final result = await mockAuthRepository.getUser();

      // Assert
      expect(result, equals(const Right(userModel)));
      verify(mockAuthRepository.getUser()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return Failure on getUser failure', () async {
      // Arrange
      const failure = ServerFailure(message: 'Invalid data', statusCode: 500);

      when(mockAuthRepository.getUser())
          .thenAnswer((_) async => const Left(failure));

      // Act
      final result = await mockAuthRepository.getUser();

      // Assert
      expect(result, equals(const Left(failure)));
      verify(mockAuthRepository.getUser()).called(1);
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

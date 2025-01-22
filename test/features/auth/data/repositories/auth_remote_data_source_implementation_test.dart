import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:date_split_app/core/errors/exception.dart';
import 'package:date_split_app/core/errors/failure.dart';
import 'package:date_split_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:date_split_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:date_split_app/features/auth/data/models/user_model.dart';
import 'package:date_split_app/features/auth/data/repositories/auth_repository_implementation.dart';

import 'auth_remote_data_source_implementation_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource, AuthLocalDataSource])
void main() {
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;
  late AuthRepositoryImplementation repository;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    repository =
        AuthRepositoryImplementation(mockRemoteDataSource, mockLocalDataSource);
  });

  group('signUp', () {
    const email = 'test@example.com';
    const password = 'password123';
    const displayName = 'Test User';
    const message = 'message';

    test('should return message on successful sign up', () async {
      // Arrange
      when(mockRemoteDataSource.signUp(
        email: email,
        password: password,
        displayName: displayName,
      )).thenAnswer((_) async => message);

      // Act
      final result = await repository.signUp(
          email: email, password: password, displayName: displayName);

      // Assert
      expect(result, equals(const Right(message)));
      verify(mockRemoteDataSource.signUp(
        email: email,
        password: password,
        displayName: displayName,
      )).called(1);
    });

    test('should return ServerFailure on server exception', () async {
      // Arrange
      when(mockRemoteDataSource.signUp(
        email: email,
        password: password,
        displayName: displayName,
      )).thenThrow(
          const ServerException(message: 'Server error', statusCode: 500));

      // Act
      final result = await repository.signUp(
          email: email, password: password, displayName: displayName);

      // Assert
      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect((failure as ServerFailure).message, 'Server error');
          expect(failure.statusCode, 500);
        },
        (_) => fail('Expected Left(ServerFailure), but got Right'),
      );
    });

    test('should return UnknownFailure on unexpected exception', () async {
      // Arrange
      when(mockRemoteDataSource.signUp(
        email: email,
        password: password,
        displayName: displayName,
      )).thenThrow(Exception('Unexpected error'));

      // Act
      final result = await repository.signUp(
          email: email, password: password, displayName: displayName);

      // Assert
      expect(result, isA<Left<Failure, void>>());
      verify(mockRemoteDataSource.signUp(
        email: email,
        password: password,
        displayName: displayName,
      )).called(1);
    });
  });

  group('signIn', () {
    const email = 'test@example.com';
    const password = 'password123';
    const token = 'token';

    test('should return Token on successful sign in', () async {
      // Arrange
      when(mockRemoteDataSource.signIn(email: email, password: password))
          .thenAnswer((_) async => token);

      // Act
      final result = await repository.signIn(
        email: email,
        password: password,
      );

      // Assert
      expect(result, equals(const Right(token)));
      verify(mockRemoteDataSource.signIn(email: email, password: password))
          .called(1);
    });

    test('should return ServerFailure on server exception', () async {
      // Arrange
      when(mockRemoteDataSource.signIn(email: email, password: password))
          .thenThrow(const ServerException(
              message: 'Invalid credentials', statusCode: 401));

      // Act
      final result = await repository.signIn(email: email, password: password);

      // Assert
      expect(
          result,
          equals(const Left(
              ServerFailure(message: 'Invalid credentials', statusCode: 401))));
      verify(mockRemoteDataSource.signIn(email: email, password: password))
          .called(1);
    });
  });

  group('updateUser', () {
    const token = 'token';
    const avatar = 'avatar';
    const nickName = 'password123';
    const newToken = 'newToken';

    test('should return newToken on successful update', () async {
      // Arrange
      when(mockRemoteDataSource.updateUser(
        token: token,
        avatar: avatar,
        nickName: nickName,
      )).thenAnswer((_) async => newToken);

      // Act
      final result = await repository.updateUser(
        token: token,
        avatar: avatar,
        nickName: nickName,
      );

      // Assert
      expect(result, equals(const Right(newToken)));
      verify(mockRemoteDataSource.updateUser(
        token: token,
        avatar: avatar,
        nickName: nickName,
      )).called(1);
    });

    test('should return ServerFailure on server exception', () async {
      // Arrange
      when(mockRemoteDataSource.updateUser(
        token: token,
        avatar: avatar,
        nickName: nickName,
      )).thenThrow(
          const ServerException(message: 'Token expired', statusCode: 401));

      // Act
      final result = await repository.updateUser(
        token: token,
        avatar: avatar,
        nickName: nickName,
      );

      // Assert
      expect(
        result,
        equals(
          const Left(
            ServerFailure(message: 'Token expired', statusCode: 401),
          ),
        ),
      );
      verify(mockRemoteDataSource.updateUser(
        token: token,
        avatar: avatar,
        nickName: nickName,
      )).called(1);
    });
  });

  group('resetPassword', () {
    const email = 'test@example.com';
    const message = 'message';

    test('should return message on successful reset password', () async {
      // Arrange
      when(mockRemoteDataSource.resetPassword(email))
          .thenAnswer((_) async => message);

      // Act
      final result = await repository.resetPassword(email: email);

      // Assert
      expect(result, equals(const Right(message)));
      verify(mockRemoteDataSource.resetPassword(email)).called(1);
    });

    test('should return ServerFailure on server exception', () async {
      // Arrange
      when(mockRemoteDataSource.resetPassword(email)).thenThrow(
          const ServerException(message: 'Email not found', statusCode: 404));

      // Act
      final result = await repository.resetPassword(email: email);

      // Assert
      expect(
          result,
          equals(const Left(
              ServerFailure(message: 'Email not found', statusCode: 404))));
      verify(mockRemoteDataSource.resetPassword(email)).called(1);
    });
  });

  group('deleteAccount', () {
    const uid = 'testUid123';
    const message = 'message';

    test('should return void on successful account deletion', () async {
      // Arrange
      when(mockRemoteDataSource.deleteAccount(uid))
          .thenAnswer((_) async => message);

      // Act
      final result = await repository.deleteAccount(uid: uid);

      // Assert
      expect(result, equals(const Right(message)));
      verify(mockRemoteDataSource.deleteAccount(uid)).called(1);
    });

    test('should return ServerFailure on server exception', () async {
      // Arrange
      when(mockRemoteDataSource.deleteAccount(uid)).thenThrow(
          const ServerException(message: 'Account not found', statusCode: 404));

      // Act
      final result = await repository.deleteAccount(uid: uid);

      // Assert
      expect(
          result,
          equals(const Left(
              ServerFailure(message: 'Account not found', statusCode: 404))));
      verify(mockRemoteDataSource.deleteAccount(uid)).called(1);
    });
  });

  group('getUser', () {
    const userModel = UserModel.empty();

    test('should return UserModel on successful sign in', () async {
      // Arrange
      when(mockLocalDataSource.getUser()).thenAnswer((_) async => userModel);

      // Act
      final result = await repository.getUser();

      // Assert
      expect(result, equals(const Right(userModel)));
      verify(mockLocalDataSource.getUser()).called(1);
    });

    test('should return ServerFailure on server exception', () async {
      // Arrange
      when(mockLocalDataSource.getUser()).thenThrow(
          const ServerException(message: 'Invalid data', statusCode: 500));

      // Act
      final result = await repository.getUser();

      // Assert
      expect(
          result,
          equals(const Left(
              ServerFailure(message: 'Invalid data', statusCode: 500))));
      verify(mockLocalDataSource.getUser()).called(1);
    });
  });
}

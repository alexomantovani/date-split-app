import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:date_split_app/core/errors/exception.dart';
import 'package:date_split_app/core/errors/failure.dart';
import 'package:date_split_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:date_split_app/features/auth/data/repositories/auth_repository_implementation.dart';

import 'auth_remote_data_source_implementation_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource])
void main() {
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late AuthRepositoryImplementation repository;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImplementation(mockRemoteDataSource);
  });

  group('signUp', () {
    const email = 'test@example.com';
    const password = 'password123';
    const displayName = 'Test User';
    const uid = 'testUid123';

    test('should return UID on successful sign up', () async {
      // Arrange
      when(mockRemoteDataSource.signUp(
        email: email,
        password: password,
        displayName: displayName,
      )).thenAnswer((_) async => uid);

      // Act
      final result = await repository.signUp(email, password, displayName);

      // Assert
      expect(result, equals(const Right(uid)));
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
      final result = await repository.signUp(email, password, displayName);

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
      final result = await repository.signUp(email, password, displayName);

      // Assert
      expect(result, isA<Left<Failure, String>>());
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

    test('should return void on successful sign in', () async {
      // Arrange
      when(mockRemoteDataSource.signIn(email: email, password: password))
          .thenAnswer((_) async {});

      // Act
      final result = await repository.signIn(email, password);

      // Assert
      expect(result, equals(const Right(null)));
      verify(mockRemoteDataSource.signIn(email: email, password: password))
          .called(1);
    });

    test('should return ServerFailure on server exception', () async {
      // Arrange
      when(mockRemoteDataSource.signIn(email: email, password: password))
          .thenThrow(const ServerException(
              message: 'Invalid credentials', statusCode: 401));

      // Act
      final result = await repository.signIn(email, password);

      // Assert
      expect(
          result,
          equals(const Left(
              ServerFailure(message: 'Invalid credentials', statusCode: 401))));
      verify(mockRemoteDataSource.signIn(email: email, password: password))
          .called(1);
    });
  });

  group('resetPassword', () {
    const email = 'test@example.com';

    test('should return void on successful reset password', () async {
      // Arrange
      when(mockRemoteDataSource.resetPassword(email)).thenAnswer((_) async {});

      // Act
      final result = await repository.resetPassword(email);

      // Assert
      expect(result, equals(const Right(null)));
      verify(mockRemoteDataSource.resetPassword(email)).called(1);
    });

    test('should return ServerFailure on server exception', () async {
      // Arrange
      when(mockRemoteDataSource.resetPassword(email)).thenThrow(
          const ServerException(message: 'Email not found', statusCode: 404));

      // Act
      final result = await repository.resetPassword(email);

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

    test('should return void on successful account deletion', () async {
      // Arrange
      when(mockRemoteDataSource.deleteAccount(uid)).thenAnswer((_) async {});

      // Act
      final result = await repository.deleteAccount(uid);

      // Assert
      expect(result, equals(const Right(null)));
      verify(mockRemoteDataSource.deleteAccount(uid)).called(1);
    });

    test('should return ServerFailure on server exception', () async {
      // Arrange
      when(mockRemoteDataSource.deleteAccount(uid)).thenThrow(
          const ServerException(message: 'Account not found', statusCode: 404));

      // Act
      final result = await repository.deleteAccount(uid);

      // Assert
      expect(
          result,
          equals(const Left(
              ServerFailure(message: 'Account not found', statusCode: 404))));
      verify(mockRemoteDataSource.deleteAccount(uid)).called(1);
    });
  });
}

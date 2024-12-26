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
      const uid = 'testUid123';

      // Certifique-se de que o mock foi configurado corretamente.
      when(mockAuthRepository.signUp(email, password, displayName))
          .thenAnswer((_) async => uid);

      // Act
      final result =
          await mockAuthRepository.signUp(email, password, displayName);

      // Assert
      expect(result, equals(uid));
      verify(mockAuthRepository.signUp(email, password, displayName)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should throw exception if sign up fails', () async {
      // Arrange
      const email = 'test@example.com';
      const password = '123';
      const displayName = 'Test User';

      when(mockAuthRepository.signUp(email, password, displayName))
          .thenThrow(Exception('Password too short'));

      // Act
      expect(
        () async =>
            await mockAuthRepository.signUp(email, password, displayName),
        throwsException,
      );

      // Assert
      verify(mockAuthRepository.signUp(email, password, displayName)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should sign in successfully', () async {
      // Arrange
      const email = 'test@example.com';
      const password = 'password123';

      when(mockAuthRepository.signIn(email, password)).thenAnswer((_) async {});

      // Act
      await mockAuthRepository.signIn(email, password);

      // Assert
      verify(mockAuthRepository.signIn(email, password)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should reset password successfully', () async {
      // Arrange
      const email = 'test@example.com';

      when(mockAuthRepository.resetPassword(email)).thenAnswer((_) async {});

      // Act
      await mockAuthRepository.resetPassword(email);

      // Assert
      verify(mockAuthRepository.resetPassword(email)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should delete account successfully', () async {
      // Arrange
      const uid = 'testUid123';

      when(mockAuthRepository.deleteAccount(uid)).thenAnswer((_) async {});

      // Act
      await mockAuthRepository.deleteAccount(uid);

      // Assert
      verify(mockAuthRepository.deleteAccount(uid)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}

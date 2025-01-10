import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:date_split_app/core/errors/failure.dart';
import 'package:date_split_app/features/notifications/domain/entities/notification.dart';
import 'package:date_split_app/features/notifications/domain/repositories/notification_repository.dart';

import 'usecases_test.mocks.dart';

@GenerateMocks([NotificationRepository])
void main() {
  late MockNotificationRepository mockNotificationRepository;

  final notification = Notification(
    id: '1',
    title: 'Test Title',
    body: 'Test Body',
    tokens: const ['token1', 'token2'],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  const String uid = 'user1';

  setUp(() {
    mockNotificationRepository = MockNotificationRepository();
  });

  group('Send Push Notification', () {
    test('should send push notification successfully', () async {
      // Simulação de sucesso
      when(mockNotificationRepository.sendPushNotification(
        notification.title,
        notification.body,
        notification.tokens,
      )).thenAnswer((_) async => const Right(null));

      final result = await mockNotificationRepository.sendPushNotification(
        notification.title,
        notification.body,
        notification.tokens,
      );

      // Verificações
      expect(result, const Right(null));
      verify(mockNotificationRepository.sendPushNotification(
        notification.title,
        notification.body,
        notification.tokens,
      )).called(1);
    });

    test('should return failure when sending push notification fails',
        () async {
      // Simulação de falha
      when(mockNotificationRepository.sendPushNotification(
        notification.title,
        notification.body,
        notification.tokens,
      )).thenAnswer(
        (_) async => const Left(ServerFailure(
            message: 'Failed to send notification', statusCode: 500)),
      );

      final result = await mockNotificationRepository.sendPushNotification(
        notification.title,
        notification.body,
        notification.tokens,
      );

      // Verificações
      expect(result, isA<Left>());
      verify(mockNotificationRepository.sendPushNotification(
        notification.title,
        notification.body,
        notification.tokens,
      )).called(1);
    });
  });

  group('Get Push Tokens', () {
    test('should fetch push tokens successfully', () async {
      final tokensList = ['token1', 'token2'];
      when(mockNotificationRepository.getPushTokens([uid]))
          .thenAnswer((_) async => Right(tokensList));

      final result = await mockNotificationRepository.getPushTokens([uid]);

      expect(result, Right(tokensList));
      verify(mockNotificationRepository.getPushTokens([uid])).called(1);
    });

    test('should return failure when fetching push tokens fails', () async {
      when(mockNotificationRepository.getPushTokens([uid])).thenAnswer(
        (_) async => const Left(
            ServerFailure(message: 'Failed to fetch tokens', statusCode: 500)),
      );

      final result = await mockNotificationRepository.getPushTokens([uid]);

      expect(result, isA<Left>());
      verify(mockNotificationRepository.getPushTokens([uid])).called(1);
    });
  });

  group('Save Push Token To Firestore', () {
    test('should save push token successfully', () async {
      // Simulação de sucesso
      when(mockNotificationRepository.savePushTokenToFirestore(
              uid, 'pushToken'))
          .thenAnswer((_) async => const Right(null));

      final result = await mockNotificationRepository.savePushTokenToFirestore(
          uid, 'pushToken');

      // Verificações
      expect(result, const Right(null));
      verify(mockNotificationRepository.savePushTokenToFirestore(
              uid, 'pushToken'))
          .called(1);
    });

    test('should return failure when saving push token fails', () async {
      // Simulação de falha
      when(mockNotificationRepository.savePushTokenToFirestore(
              uid, 'pushToken'))
          .thenAnswer(
        (_) async => const Left(
            ServerFailure(message: 'Failed to save token', statusCode: 500)),
      );

      final result = await mockNotificationRepository.savePushTokenToFirestore(
          uid, 'pushToken');

      // Verificações
      expect(result, isA<Left>());
      verify(mockNotificationRepository.savePushTokenToFirestore(
              uid, 'pushToken'))
          .called(1);
    });
  });
}

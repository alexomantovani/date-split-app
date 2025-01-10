import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:date_split_app/core/errors/failure.dart';
import 'package:date_split_app/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:date_split_app/features/notifications/domain/repositories/notification_repository.dart';

import 'notification_bloc_test.mocks.dart';

@GenerateMocks([NotificationRepository])
void main() {
  late MockNotificationRepository mockNotificationRepository;
  late NotificationBloc notificationBloc;

  setUp(() {
    mockNotificationRepository = MockNotificationRepository();
    notificationBloc =
        NotificationBloc(notificationRepository: mockNotificationRepository);
  });

  tearDown(() {
    notificationBloc.close();
  });

  const testTitle = "Test Notification";
  const testBody = "This is a test notification.";
  const testToken = "test_push_token";
  const testUid = "user123";
  final testTokens = [testToken];
  final testUids = ["user123", "user456"];

  group('SendPushNotificationEvent', () {
    blocTest<NotificationBloc, NotificationState>(
      'should emit [NotificationLoading, NotificationSentSuccess] on successful notification sending',
      build: () {
        when(mockNotificationRepository.sendPushNotification(
                testTitle, testBody, testTokens))
            .thenAnswer((_) async => const Right(null));
        return notificationBloc;
      },
      act: (bloc) => bloc.add(SendPushNotificationEvent(
        title: testTitle,
        body: testBody,
        tokens: testTokens,
      )),
      expect: () => [
        NotificationLoading(),
        NotificationSentSuccess(),
      ],
      verify: (_) {
        verify(mockNotificationRepository.sendPushNotification(
                testTitle, testBody, testTokens))
            .called(1);
      },
    );

    blocTest<NotificationBloc, NotificationState>(
      'should emit [NotificationLoading, NotificationError] on failure',
      build: () {
        when(mockNotificationRepository.sendPushNotification(
                testTitle, testBody, testTokens))
            .thenAnswer((_) async => const Left(ServerFailure(
                  message: 'Failed to send notification',
                  statusCode: 500,
                )));
        return notificationBloc;
      },
      act: (bloc) => bloc.add(SendPushNotificationEvent(
        title: testTitle,
        body: testBody,
        tokens: testTokens,
      )),
      expect: () => [
        NotificationLoading(),
        NotificationError('Failed to send notification'),
      ],
      verify: (_) {
        verify(mockNotificationRepository.sendPushNotification(
                testTitle, testBody, testTokens))
            .called(1);
      },
    );
  });

  group('GetPushTokensEvent', () {
    blocTest<NotificationBloc, NotificationState>(
      'should emit [NotificationLoading, PushTokensLoadedSuccess] on successful retrieval',
      build: () {
        when(mockNotificationRepository.getPushTokens(testUids))
            .thenAnswer((_) async => Right(testTokens));
        return notificationBloc;
      },
      act: (bloc) => bloc.add(GetPushTokensEvent(uids: testUids)),
      expect: () => [
        NotificationLoading(),
        PushTokensLoadedSuccess(testTokens),
      ],
      verify: (_) {
        verify(mockNotificationRepository.getPushTokens(testUids)).called(1);
      },
    );

    blocTest<NotificationBloc, NotificationState>(
      'should emit [NotificationLoading, NotificationError] on failure',
      build: () {
        when(mockNotificationRepository.getPushTokens(testUids))
            .thenAnswer((_) async => const Left(ServerFailure(
                  message: 'Failed to load tokens',
                  statusCode: 500,
                )));
        return notificationBloc;
      },
      act: (bloc) => bloc.add(GetPushTokensEvent(uids: testUids)),
      expect: () => [
        NotificationLoading(),
        NotificationError('Failed to load tokens'),
      ],
      verify: (_) {
        verify(mockNotificationRepository.getPushTokens(testUids)).called(1);
      },
    );
  });

  group('SavePushTokenEvent', () {
    blocTest<NotificationBloc, NotificationState>(
      'should emit [NotificationLoading, PushTokenSavedSuccess] on successful saving',
      build: () {
        when(mockNotificationRepository.savePushTokenToFirestore(
                testUid, testToken))
            .thenAnswer((_) async => const Right(null));
        return notificationBloc;
      },
      act: (bloc) =>
          bloc.add(SavePushTokenEvent(uid: testUid, pushToken: testToken)),
      expect: () => [
        NotificationLoading(),
        PushTokenSavedSuccess(),
      ],
      verify: (_) {
        verify(mockNotificationRepository.savePushTokenToFirestore(
                testUid, testToken))
            .called(1);
      },
    );

    blocTest<NotificationBloc, NotificationState>(
      'should emit [NotificationLoading, NotificationError] on failure',
      build: () {
        when(mockNotificationRepository.savePushTokenToFirestore(
                testUid, testToken))
            .thenAnswer((_) async => const Left(ServerFailure(
                  message: 'Failed to save token',
                  statusCode: 500,
                )));
        return notificationBloc;
      },
      act: (bloc) =>
          bloc.add(SavePushTokenEvent(uid: testUid, pushToken: testToken)),
      expect: () => [
        NotificationLoading(),
        NotificationError('Failed to save token'),
      ],
      verify: (_) {
        verify(mockNotificationRepository.savePushTokenToFirestore(
                testUid, testToken))
            .called(1);
      },
    );
  });
}

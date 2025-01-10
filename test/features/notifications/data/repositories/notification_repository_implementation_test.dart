import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'package:date_split_app/core/errors/exception.dart';
import 'package:date_split_app/features/notifications/data/datasources/notification_remote_data_source.dart';

import 'notification_repository_implementation_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockHttpClient;
  late NotificationRemoteDataSourceImplementation dataSource;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = NotificationRemoteDataSourceImplementation(mockHttpClient);
  });

  const String baseUrl = "https://your-firebase-functions-url.com";

  group('sendPushNotification', () {
    const String title = "Test Title";
    const String body = "Test Body";
    final List<String> tokens = ["token1", "token2"];
    final String requestBody = jsonEncode({
      "title": title,
      "body": body,
      "tokens": tokens,
    });

    test('should send push notification successfully', () async {
      // Arrange
      final url = Uri.parse("$baseUrl/notifications/send");
      when(mockHttpClient.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: requestBody,
      )).thenAnswer((_) async => http.Response('', 200));

      // Act
      await dataSource.sendPushNotification(title, body, tokens);

      // Assert
      verify(mockHttpClient.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: requestBody,
      )).called(1);
    });

    test('should throw ServerException on failure', () async {
      // Arrange
      final url = Uri.parse("$baseUrl/notifications/send");
      when(mockHttpClient.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: requestBody,
      )).thenAnswer(
          (_) async => http.Response('{"error": "Bad Request"}', 400));

      // Act
      final call = dataSource.sendPushNotification;

      // Assert
      expect(
        () async => await call(title, body, tokens),
        throwsA(isA<ServerException>()
            .having(
              (e) => e.message,
              'message',
              contains('Bad Request'),
            )
            .having(
              (e) => e.statusCode,
              'statusCode',
              400,
            )),
      );
    });
  });

  group('getPushTokens', () {
    final List<String> uids = ["uid1", "uid2"];
    final String requestBody = jsonEncode({"uids": uids});
    final List<String> tokens = ["token1", "token2"];
    final String responseBody = jsonEncode(tokens);

    test('should return push tokens on success', () async {
      // Arrange
      final url = Uri.parse("$baseUrl/notifications/tokens");
      when(mockHttpClient.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: requestBody,
      )).thenAnswer((_) async => http.Response(responseBody, 200));

      // Act
      final result = await dataSource.getPushTokens(uids);

      // Assert
      expect(result, tokens);
      verify(mockHttpClient.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: requestBody,
      )).called(1);
    });

    test('should throw ServerException on failure', () async {
      // Arrange
      final url = Uri.parse("$baseUrl/notifications/tokens");
      when(mockHttpClient.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: requestBody,
      )).thenAnswer(
          (_) async => http.Response('{"error": "Unauthorized"}', 401));

      // Act
      final call = dataSource.getPushTokens;

      // Assert
      expect(
        () async => await call(uids),
        throwsA(isA<ServerException>()
            .having(
              (e) => e.message,
              'message',
              contains('Unauthorized'),
            )
            .having(
              (e) => e.statusCode,
              'statusCode',
              401,
            )),
      );
    });
  });

  group('savePushTokenToFirestore', () {
    const String uid = "user123";
    const String pushToken = "token123";
    final String requestBody = jsonEncode({
      "uid": uid,
      "pushToken": pushToken,
    });

    test('should save push token successfully', () async {
      // Arrange
      final url = Uri.parse("$baseUrl/notifications/tokens/save");
      when(mockHttpClient.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: requestBody,
      )).thenAnswer((_) async => http.Response('', 200));

      // Act
      await dataSource.savePushTokenToFirestore(uid, pushToken);

      // Assert
      verify(mockHttpClient.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: requestBody,
      )).called(1);
    });

    test('should throw ServerException on failure', () async {
      // Arrange
      final url = Uri.parse("$baseUrl/notifications/tokens/save");
      when(mockHttpClient.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: requestBody,
      )).thenAnswer((_) async => http.Response('{"error": "Conflict"}', 409));

      // Act
      final call = dataSource.savePushTokenToFirestore;

      // Assert
      expect(
        () async => await call(uid, pushToken),
        throwsA(isA<ServerException>()
            .having(
              (e) => e.message,
              'message',
              contains('Conflict'),
            )
            .having(
              (e) => e.statusCode,
              'statusCode',
              409,
            )),
      );
    });
  });
}

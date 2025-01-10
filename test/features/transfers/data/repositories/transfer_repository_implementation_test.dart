import 'dart:convert';

import 'package:date_split_app/features/transfers/data/models/transfer_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'package:date_split_app/core/errors/exception.dart';
import 'package:date_split_app/features/transfers/data/datasources/transfer_remote_data_source.dart';

import 'transfer_repository_implementation_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockHttpClient;
  late TransfersRemoteDataSourceImplementation dataSource;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = TransfersRemoteDataSourceImplementation(mockHttpClient);
  });

  const String baseUrl = "https://your-firebase-functions-url.com";

  final transfer = TransferModel(
    id: "1",
    value: 150.0,
    date: DateTime.parse("2025-01-01"),
    transferredBy: "Account A",
    transferredTo: "Account B",
  );

  String body = jsonEncode({
    "id": transfer.id,
    "value": transfer.value,
    "date": transfer.date.toIso8601String(),
    "transferredBy": transfer.transferredBy,
    "transferredTo": transfer.transferredTo,
  });

  group('createTransfer', () {
    test('should create transfer successfully', () async {
      // Arrange
      final url = Uri.parse("$baseUrl/transfers");
      when(mockHttpClient.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      )).thenAnswer((_) async => http.Response('', 201));

      // Act
      await dataSource.createTransfer(transfer);

      // Assert
      verify(mockHttpClient.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      )).called(1);
    });

    test('should throw ServerException on failure', () async {
      // Arrange
      final url = Uri.parse("$baseUrl/transfers");
      when(mockHttpClient.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      )).thenAnswer(
          (_) async => http.Response('{"error": "Bad Request"}', 400));

      // Act
      final call = dataSource.createTransfer;

      // Assert
      expect(
        () async => await call(transfer),
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

  group('getTransferById', () {
    test('should return transfer on success', () async {
      // Arrange
      final url = Uri.parse("$baseUrl/transfers/1");
      when(mockHttpClient.get(url))
          .thenAnswer((_) async => http.Response(body, 200));

      // Act
      final result = await dataSource.getTransferById("1");

      // Assert
      expect(result, transfer);
      verify(mockHttpClient.get(url)).called(1);
    });

    test('should throw ServerException on failure', () async {
      // Arrange
      final url = Uri.parse("$baseUrl/transfers/1");
      when(mockHttpClient.get(url)).thenAnswer(
          (_) async => http.Response('{"error": "Not Found"}', 404));

      // Act
      final call = dataSource.getTransferById;

      // Assert
      expect(
        () async => await call("1"),
        throwsA(isA<ServerException>()
            .having(
              (e) => e.message,
              'message',
              contains('Not Found'),
            )
            .having(
              (e) => e.statusCode,
              'statusCode',
              404,
            )),
      );
    });
  });

  group('getAllTransfers', () {
    test('should return list of transfers on success', () async {
      // Arrange
      final url = Uri.parse("$baseUrl/transfers?userId=user123");
      when(mockHttpClient.get(url)).thenAnswer((_) async => http.Response(
          jsonEncode([
            {
              "id": transfer.id,
              "value": transfer.value,
              "date": transfer.date.toIso8601String(),
              "transferredBy": transfer.transferredBy,
              "transferredTo": transfer.transferredTo,
            }
          ]),
          200));

      // Act
      final result = await dataSource.getAllTransfers("user123");

      // Assert
      expect(result, [transfer]);
      verify(mockHttpClient.get(url)).called(1);
    });

    test('should throw ServerException on failure', () async {
      // Arrange
      final url = Uri.parse("$baseUrl/transfers?userId=user123");
      when(mockHttpClient.get(url)).thenAnswer(
          (_) async => http.Response('{"error": "Unauthorized"}', 401));

      // Act
      final call = dataSource.getAllTransfers;

      // Assert
      expect(
        () async => await call("user123"),
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
}

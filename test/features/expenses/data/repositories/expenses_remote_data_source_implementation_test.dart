import 'dart:convert';

import 'package:date_split_app/features/expenses/data/models/expese_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'package:date_split_app/core/errors/exception.dart';
import 'package:date_split_app/features/expenses/data/datasources/expenses_remote_data_source.dart';

import 'expenses_remote_data_source_implementation_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockHttpClient;
  late ExpensesRemoteDataSourceImplementation dataSource;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = ExpensesRemoteDataSourceImplementation(mockHttpClient);
  });

  const String baseUrl = "https://your-firebase-functions-url.com";

  final expense = ExpenseModel(
    id: "1",
    name: "Groceries",
    value: 100.0,
    date: DateTime.parse("2025-01-01"),
    paidBy: "John",
    sharedWith: const ["Jane", "Doe"],
  );

  group('createExpense', () {
    test('should create expense successfully', () async {
      // Arrange
      final url = Uri.parse("$baseUrl/expenses");
      when(mockHttpClient.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": expense.name,
          "value": expense.value,
          "date": expense.date.toIso8601String(),
          "paidBy": expense.paidBy,
          "sharedWith": expense.sharedWith,
        }),
      )).thenAnswer((_) async => http.Response('', 201));

      // Act
      await dataSource.createExpense(expense);

      // Assert
      verify(mockHttpClient.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": expense.name,
          "value": expense.value,
          "date": expense.date.toIso8601String(),
          "paidBy": expense.paidBy,
          "sharedWith": expense.sharedWith,
        }),
      )).called(1);
    });

    test('should throw ServerException on failure', () async {
      // Arrange
      final url = Uri.parse("$baseUrl/expenses");
      when(mockHttpClient.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": expense.name,
          "value": expense.value,
          "date": expense.date.toIso8601String(),
          "paidBy": expense.paidBy,
          "sharedWith": expense.sharedWith,
        }),
      )).thenAnswer(
          (_) async => http.Response('{"error": "Bad Request"}', 400));

      // Act
      final call = dataSource.createExpense;

      // Assert
      expect(
        () async => await call(expense),
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

  group('getExpenseById', () {
    test('should return expense on success', () async {
      // Arrange
      final url = Uri.parse("$baseUrl/expenses/1");
      when(mockHttpClient.get(url)).thenAnswer((_) async => http.Response(
          jsonEncode({
            "id": expense.id,
            "name": expense.name,
            "value": expense.value,
            "date": expense.date.toIso8601String(),
            "paidBy": expense.paidBy,
            "sharedWith": expense.sharedWith,
          }),
          200));

      // Act
      final result = await dataSource.getExpenseById("1");

      // Assert
      expect(result, expense);
      verify(mockHttpClient.get(url)).called(1);
    });

    test('should throw ServerException on failure', () async {
      // Arrange
      final url = Uri.parse("$baseUrl/expenses/1");
      when(mockHttpClient.get(url)).thenAnswer(
          (_) async => http.Response('{"error": "Not Found"}', 404));

      // Act
      final call = dataSource.getExpenseById;

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

  group('getAllExpenses', () {
    test('should return list of expenses on success', () async {
      // Arrange
      final url = Uri.parse("$baseUrl/expenses?userId=user123");
      when(mockHttpClient.get(url)).thenAnswer((_) async => http.Response(
          jsonEncode([
            {
              "id": expense.id,
              "name": expense.name,
              "value": expense.value,
              "date": expense.date.toIso8601String(),
              "paidBy": expense.paidBy,
              "sharedWith": expense.sharedWith,
            }
          ]),
          200));

      // Act
      final result = await dataSource.getAllExpenses("user123");

      // Assert
      expect(result, [expense]);
      verify(mockHttpClient.get(url)).called(1);
    });

    test('should throw ServerException on failure', () async {
      // Arrange
      final url = Uri.parse("$baseUrl/expenses?userId=user123");
      when(mockHttpClient.get(url)).thenAnswer(
          (_) async => http.Response('{"error": "Unauthorized"}', 401));

      // Act
      final call = dataSource.getAllExpenses;

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

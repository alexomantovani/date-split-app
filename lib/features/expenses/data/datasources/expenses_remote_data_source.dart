import 'dart:convert';
import 'package:date_split_app/features/expenses/data/models/expese_model.dart';
import 'package:http/http.dart' as http;
import 'package:date_split_app/core/errors/exception.dart';
import 'package:date_split_app/features/expenses/domain/entities/expense.dart';

abstract class ExpensesRemoteDataSource {
  Future<void> createExpense(Expense expense);
  Future<ExpenseModel> getExpenseById(String id);
  Future<List<ExpenseModel>> getAllExpenses(String userId);
  Future<void> updateExpense(String id, Expense expense);
  Future<void> deleteExpense(String id);
}

class ExpensesRemoteDataSourceImplementation
    implements ExpensesRemoteDataSource {
  final http.Client client;

  const ExpensesRemoteDataSourceImplementation(this.client);

  final String baseUrl =
      "https://your-firebase-functions-url.com"; // Substitua pela URL da sua API

  @override
  Future<void> createExpense(Expense expense) async {
    final url = Uri.parse("$baseUrl/expenses");
    final response = await client.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": expense.name,
        "value": expense.value,
        "date": expense.date.toIso8601String(),
        "paidBy": expense.paidBy,
        "sharedWith": expense.sharedWith,
      }),
    );

    if (response.statusCode != 201) {
      throw ServerException(
        message: _parseErrorMessage(response),
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<ExpenseModel> getExpenseById(String id) async {
    final url = Uri.parse("$baseUrl/expenses/$id");
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ExpenseModel.fromJson(data);
    } else {
      throw ServerException(
        message: _parseErrorMessage(response),
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<List<ExpenseModel>> getAllExpenses(String userId) async {
    final url = Uri.parse("$baseUrl/expenses?userId=$userId");
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((e) => ExpenseModel.fromJson(e)).toList();
    } else {
      throw ServerException(
        message: _parseErrorMessage(response),
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<void> updateExpense(String id, Expense expense) async {
    final url = Uri.parse("$baseUrl/expenses/$id");
    final response = await client.patch(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": expense.name,
        "value": expense.value,
        "date": expense.date.toIso8601String(),
        "paidBy": expense.paidBy,
        "sharedWith": expense.sharedWith,
      }),
    );

    if (response.statusCode != 200) {
      throw ServerException(
        message: _parseErrorMessage(response),
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<void> deleteExpense(String id) async {
    final url = Uri.parse("$baseUrl/expenses/$id");
    final response = await client.delete(url);

    if (response.statusCode != 200) {
      throw ServerException(
        message: _parseErrorMessage(response),
        statusCode: response.statusCode,
      );
    }
  }

  String _parseErrorMessage(http.Response response) {
    try {
      final data = jsonDecode(response.body);
      return data['error'] ?? 'Erro desconhecido';
    } catch (_) {
      return 'Erro ao processar a resposta do servidor';
    }
  }
}

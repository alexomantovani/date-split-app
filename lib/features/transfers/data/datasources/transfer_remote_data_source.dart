import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:date_split_app/core/errors/exception.dart';
import 'package:date_split_app/features/transfers/data/models/transfer_model.dart';
import 'package:date_split_app/features/transfers/domain/entities/transfer.dart';

abstract class TransfersRemoteDataSource {
  Future<void> createTransfer(Transfer transfer);
  Future<TransferModel> getTransferById(String id);
  Future<List<TransferModel>> getAllTransfers(String userId);
  Future<void> updateTransfer(String id, Transfer transfer);
  Future<void> deleteTransfer(String id);
}

class TransfersRemoteDataSourceImplementation
    implements TransfersRemoteDataSource {
  final http.Client client;

  const TransfersRemoteDataSourceImplementation(this.client);

  final String baseUrl =
      "https://your-firebase-functions-url.com"; // Substitua pela URL da sua API

  @override
  Future<void> createTransfer(Transfer transfer) async {
    final url = Uri.parse("$baseUrl/transfers");
    final response = await client.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id": transfer.id,
        "value": transfer.value,
        "date": transfer.date.toIso8601String(),
        "transferredBy": transfer.transferredBy,
        "transferredTo": transfer.transferredTo,
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
  Future<TransferModel> getTransferById(String id) async {
    final url = Uri.parse("$baseUrl/transfers/$id");
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return TransferModel.fromJson(data);
    } else {
      throw ServerException(
        message: _parseErrorMessage(response),
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<List<TransferModel>> getAllTransfers(String userId) async {
    final url = Uri.parse("$baseUrl/transfers?userId=$userId");
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((e) => TransferModel.fromJson(e)).toList();
    } else {
      throw ServerException(
        message: _parseErrorMessage(response),
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<void> updateTransfer(String id, Transfer transfer) async {
    final url = Uri.parse("$baseUrl/transfers/$id");
    final response = await client.patch(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id": transfer.id,
        "value": transfer.value,
        "date": transfer.date.toIso8601String(),
        "transferredBy": transfer.transferredBy,
        "transferredTo": transfer.transferredTo,
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
  Future<void> deleteTransfer(String id) async {
    final url = Uri.parse("$baseUrl/transfers/$id");
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

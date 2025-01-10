import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:date_split_app/core/errors/exception.dart';

abstract class NotificationRemoteDataSource {
  Future<void> sendPushNotification(
      String title, String body, List<String> tokens);
  Future<List<String>> getPushTokens(List<String> uids);
  Future<void> savePushTokenToFirestore(String uid, String pushToken);
}

class NotificationRemoteDataSourceImplementation
    implements NotificationRemoteDataSource {
  final http.Client client;

  const NotificationRemoteDataSourceImplementation(this.client);

  final String baseUrl =
      "https://your-firebase-functions-url.com"; // Substitua pela URL da sua API

  @override
  Future<void> sendPushNotification(
      String title, String body, List<String> tokens) async {
    final url = Uri.parse("$baseUrl/notifications/send");
    final response = await client.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "title": title,
        "body": body,
        "tokens": tokens,
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
  Future<List<String>> getPushTokens(List<String> uids) async {
    final url = Uri.parse("$baseUrl/notifications/tokens");
    final response = await client.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"uids": uids}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((e) => e.toString()).toList();
    } else {
      throw ServerException(
        message: _parseErrorMessage(response),
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<void> savePushTokenToFirestore(String uid, String pushToken) async {
    final url = Uri.parse("$baseUrl/notifications/tokens/save");
    final response = await client.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "uid": uid,
        "pushToken": pushToken,
      }),
    );

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

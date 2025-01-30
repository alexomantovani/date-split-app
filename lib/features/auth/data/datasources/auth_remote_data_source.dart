import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:date_split_app/core/errors/exception.dart';
import 'package:date_split_app/core/services/local_preferences.dart';
import 'package:date_split_app/core/utils/typedefs.dart';

abstract class AuthRemoteDataSource {
  Future<String> signUp({
    required String email,
    required String password,
    required String displayName,
  });

  Future<String> signIn({
    required String email,
    required String password,
  });

  Future<String> updateUser({
    required String? avatar,
    required String? nickName,
  });

  Future<String> resetPassword(String email);

  Future<String> deleteAccount(String uid);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  AuthRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });

  @override
  Future<String> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final url = Uri.parse('$baseUrl/auth/signup');
    final body = jsonEncode({
      'email': email,
      'password': password,
      'displayName': displayName,
    });

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      return responseData['message'];
    } else {
      final errorData = jsonDecode(response.body);
      throw ServerException(
        message: errorData['message'] ?? 'Erro ao registrar usuário.',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/auth/signin');
    final body = jsonEncode({'email': email, 'password': password});

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final String token = responseData['token'];
      if (token != '') {
        LocalPreferences.setToken(token: token);
      }
      return token;
    } else {
      final errorData = jsonDecode(response.body);
      throw ServerException(
        message: errorData['message'] ?? 'Erro ao fazer login.',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<String> updateUser({
    required String? avatar,
    required String? nickName,
  }) async {
    final url = Uri.parse('$baseUrl/auth/update');
    final body = jsonEncode({'avatar': avatar, 'nickName': nickName});
    final response = await client.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await LocalPreferences.getToken()}',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final String newToken = responseData['token'];

      LocalPreferences.updateToken(newToken: newToken);

      return newToken;
    } else {
      final errorData = jsonDecode(response.body);
      throw ServerException(
        message: errorData['message'] ?? 'Erro ao fazer login.',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<String> resetPassword(String email) async {
    final url = Uri.parse('$baseUrl/auth/reset-password');
    final body = jsonEncode({'email': email});

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final DataMap responseData = jsonDecode(response.body);
      return responseData['message'];
    } else {
      final errorData = jsonDecode(response.body);
      throw ServerException(
        message: errorData['message'] ?? 'Erro ao redefinir senha.',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<String> deleteAccount(String uid) async {
    final url = Uri.parse('$baseUrl/auth/delete-account/$uid');

    final response = await client.delete(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final DataMap responseData = jsonDecode(response.body);
      return responseData['message'];
    } else {
      final errorData = jsonDecode(response.body);
      throw ServerException(
        message: errorData['message'] ?? 'Erro ao excluir conta.',
        statusCode: response.statusCode,
      );
    }
  }
}

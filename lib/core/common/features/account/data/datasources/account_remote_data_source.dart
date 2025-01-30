import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:date_split_app/core/common/features/account/data/models/party_user_model.dart';
import 'package:date_split_app/core/common/features/account/domain/entities/party_user.dart';
import 'package:date_split_app/core/errors/exception.dart';
import 'package:date_split_app/core/utils/core_utils.dart';

abstract class AccountRemoteDataSource {
  Future<List<PartyUser>> getPartyUsers({
    required String? uid,
    required String? nickName,
    required String? displayName,
  });

  Future<String> addPartyUsers({required List<String> partyUserList});
}

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  AccountRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });

  @override
  Future<List<PartyUserModel>> getPartyUsers({
    required String? uid,
    required String? nickName,
    required String? displayName,
  }) async {
    final url = Uri.parse('$baseUrl/users/getUsers?nickName=$nickName');

    final response = await client.get(
      url,
      headers: await CoreUtils.tokenHeaders(),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body) as List<dynamic>;
      final partyUserList =
          responseData.map((e) => PartyUserModel.fromJson(e)).toList();
      return partyUserList;
    } else {
      final errorData = jsonDecode(response.body);
      throw ServerException(
        message: errorData['message'] ?? 'Erro ao registrar usuário.',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<String> addPartyUsers({
    required List<String> partyUserList,
  }) async {
    final url = Uri.parse('$baseUrl/users/addAndOrRemoveUsers');

    final body = jsonEncode({"usersIds": partyUserList});

    final response = await client.post(
      url,
      headers: await CoreUtils.tokenHeaders(),
      body: body,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      return responseData['token'];
    } else {
      final errorData = jsonDecode(response.body);
      throw ServerException(
        message: errorData['message'] ?? 'Erro ao adicionar amigo.',
        statusCode: response.statusCode,
      );
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:date_split_app/core/common/features/account/data/datasources/account_remote_data_source.dart';
import 'package:date_split_app/core/common/features/account/data/models/party_user_model.dart';
import 'package:date_split_app/core/common/features/account/data/repositories/account_repository_impl.dart';
import 'package:date_split_app/core/errors/exception.dart';
import 'package:date_split_app/core/errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'account_remote_datasource_implementation_test.mocks.dart';

@GenerateMocks([AccountRemoteDataSource])
void main() {
  late MockAccountRemoteDataSource mockAccountRemoteDataSource;
  late AccountRepositoryImpl repository;

  setUp(() {
    mockAccountRemoteDataSource = MockAccountRemoteDataSource();
    repository = AccountRepositoryImpl(mockAccountRemoteDataSource);
  });

  group('getPartyUsers', () {
    const displayName = 'displayName';
    const nickName = 'nickName';
    const uid = 'uid';
    const partyUserList = [PartyUserModel.empty()];
    test('should return a list of [PartyUserModel] on successful API call',
        () async {
      // Arrange
      when(mockAccountRemoteDataSource.getPartyUsers(
        uid: uid,
        nickName: nickName,
        displayName: displayName,
      )).thenAnswer((_) async => partyUserList);

      // Act
      final result = await repository.getPartyUsers(
        uid: uid,
        nickName: nickName,
        displayName: displayName,
      );

      // Assert
      expect(result, equals(const Right(partyUserList)));
      verify(mockAccountRemoteDataSource.getPartyUsers(
        uid: uid,
        nickName: nickName,
        displayName: displayName,
      )).called(1);
    });

    test('should return ServerFailure on server exception', () async {
      // Arrange
      when(mockAccountRemoteDataSource.getPartyUsers(
        uid: uid,
        nickName: nickName,
        displayName: displayName,
      )).thenThrow(const ServerException(
          message: 'Invalid credentials', statusCode: 401));

      // Act
      final result = await repository.getPartyUsers(
        uid: uid,
        nickName: nickName,
        displayName: displayName,
      );

      // Assert
      expect(
          result,
          equals(const Left(
              ServerFailure(message: 'Invalid credentials', statusCode: 401))));
      verify(mockAccountRemoteDataSource.getPartyUsers(
        uid: uid,
        nickName: nickName,
        displayName: displayName,
      )).called(1);
    });
  });
}

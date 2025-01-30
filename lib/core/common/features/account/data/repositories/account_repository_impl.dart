import 'package:dartz/dartz.dart';
import 'package:date_split_app/core/common/features/account/data/datasources/account_remote_data_source.dart';
import 'package:date_split_app/core/common/features/account/domain/entities/party_user.dart';
import 'package:date_split_app/core/common/features/account/domain/repositories/account_repository.dart';
import 'package:date_split_app/core/errors/exception.dart';
import 'package:date_split_app/core/errors/failure.dart';
import 'package:date_split_app/core/utils/typedefs.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource _remoteDataSource;

  const AccountRepositoryImpl(this._remoteDataSource);

  @override
  EitherFuture<List<PartyUser>> getPartyUsers({
    required String? uid,
    required String? nickName,
    required String? displayName,
  }) async {
    try {
      final result = await _remoteDataSource.getPartyUsers(
        uid: uid,
        nickName: nickName,
        displayName: displayName,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(
          message: e.toString(), cause: 'Unexpected error', statusCode: -1));
    }
  }

  @override
  EitherFuture<String> addPartyUsers({
    required List<String> partyUserList,
  }) async {
    try {
      final result = await _remoteDataSource.addPartyUsers(
        partyUserList: partyUserList,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(
          message: e.toString(), cause: 'Unexpected error', statusCode: -1));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:date_split_app/core/errors/exception.dart';
import 'package:date_split_app/core/errors/failure.dart';
import 'package:date_split_app/features/notifications/data/datasources/notification_remote_data_source.dart';
import 'package:date_split_app/features/notifications/domain/repositories/notification_repository.dart';

class NotificationRepositoryImplementation implements NotificationRepository {
  final NotificationRemoteDataSource _remoteDataSource;

  const NotificationRepositoryImplementation(this._remoteDataSource);

  @override
  Future<Either<Failure, void>> sendPushNotification(
      String title, String body, List<String> tokens) async {
    try {
      await _remoteDataSource.sendPushNotification(title, body, tokens);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString(), statusCode: null));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPushTokens(List<String> uids) async {
    try {
      final tokens = await _remoteDataSource.getPushTokens(uids);
      return Right(tokens);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString(), statusCode: null));
    }
  }

  @override
  Future<Either<Failure, void>> savePushTokenToFirestore(
      String uid, String pushToken) async {
    try {
      await _remoteDataSource.savePushTokenToFirestore(uid, pushToken);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString(), statusCode: null));
    }
  }
}

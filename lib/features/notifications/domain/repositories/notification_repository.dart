import 'package:dartz/dartz.dart';
import 'package:date_split_app/core/errors/failure.dart';

abstract class NotificationRepository {
  Future<Either<Failure, void>> sendPushNotification(
    String title,
    String body,
    List<String> tokens,
  );

  Future<Either<Failure, List<String>>> getPushTokens(List<String> uids);

  Future<Either<Failure, void>> savePushTokenToFirestore(
      String uid, String pushToken);
}

part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendPushNotificationEvent extends NotificationEvent {
  final String title;
  final String body;
  final List<String> tokens;

  SendPushNotificationEvent({
    required this.title,
    required this.body,
    required this.tokens,
  });

  @override
  List<Object?> get props => [title, body, tokens];
}

class GetPushTokensEvent extends NotificationEvent {
  final List<String> uids;

  GetPushTokensEvent({required this.uids});

  @override
  List<Object?> get props => [uids];
}

class SavePushTokenEvent extends NotificationEvent {
  final String uid;
  final String pushToken;

  SavePushTokenEvent({required this.uid, required this.pushToken});

  @override
  List<Object?> get props => [uid, pushToken];
}

part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationError extends NotificationState {
  final String message;

  NotificationError(this.message);

  @override
  List<Object?> get props => [message];
}

class NotificationSentSuccess extends NotificationState {}

class PushTokensLoadedSuccess extends NotificationState {
  final List<String> tokens;

  PushTokensLoadedSuccess(this.tokens);

  @override
  List<Object?> get props => [tokens];
}

class PushTokenSavedSuccess extends NotificationState {}

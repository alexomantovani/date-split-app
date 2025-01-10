import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:date_split_app/features/notifications/domain/repositories/notification_repository.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository notificationRepository;

  NotificationBloc({required this.notificationRepository})
      : super(NotificationInitial()) {
    on<SendPushNotificationEvent>(_onSendPushNotification);
    on<GetPushTokensEvent>(_onGetPushTokens);
    on<SavePushTokenEvent>(_onSavePushToken);
  }

  Future<void> _onSendPushNotification(
      SendPushNotificationEvent event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    final result = await notificationRepository.sendPushNotification(
      event.title,
      event.body,
      event.tokens,
    );
    result.fold(
      (failure) => emit(NotificationError(failure.message)),
      (_) => emit(NotificationSentSuccess()),
    );
  }

  Future<void> _onGetPushTokens(
      GetPushTokensEvent event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    final result = await notificationRepository.getPushTokens(event.uids);
    result.fold(
      (failure) => emit(NotificationError(failure.message)),
      (tokens) => emit(PushTokensLoadedSuccess(tokens)),
    );
  }

  Future<void> _onSavePushToken(
      SavePushTokenEvent event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    final result = await notificationRepository.savePushTokenToFirestore(
      event.uid,
      event.pushToken,
    );
    result.fold(
      (failure) => emit(NotificationError(failure.message)),
      (_) => emit(PushTokenSavedSuccess()),
    );
  }
}

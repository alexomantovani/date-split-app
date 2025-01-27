part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

class GetPartyUsersEvent extends AccountEvent {
  final String? uid;
  final String? nickName;
  final String? displayName;

  const GetPartyUsersEvent({
    required this.uid,
    required this.nickName,
    required this.displayName,
  });

  @override
  List<Object?> get props => [uid, nickName, displayName];
}

class ClearPartyUserEvent extends AccountEvent {
  const ClearPartyUserEvent();
}

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

class SelectPartyUserEvent extends AccountEvent {
  final String uid;

  const SelectPartyUserEvent({required this.uid});

  @override
  List<Object?> get props => [uid];
}

class AddPartyUserEvent extends AccountEvent {
  final List<String> partyUserList;

  const AddPartyUserEvent({required this.partyUserList});

  @override
  List<Object?> get props => [partyUserList];
}

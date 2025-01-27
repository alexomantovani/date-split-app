part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object?> get props => [];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class GetPartyUsersSuccess extends AccountState {
  final List<PartyUser>? partyUserList;

  const GetPartyUsersSuccess({required this.partyUserList});

  @override
  List<Object?> get props => [partyUserList];
}

class AccountError extends AccountState {
  final String message;

  const AccountError(this.message);

  @override
  List<Object?> get props => [message];
}

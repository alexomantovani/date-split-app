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

class SelectPartyUserSuccess extends AccountState {
  final List<String> partyUserUids;

  const SelectPartyUserSuccess({required this.partyUserUids});

  @override
  List<Object?> get props => [partyUserUids];
}

class AddPartyUserSuccess extends AccountState {
  final String token;

  const AddPartyUserSuccess({required this.token});

  @override
  List<Object?> get props => [token];
}

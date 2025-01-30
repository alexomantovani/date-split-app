import 'package:bloc/bloc.dart';
import 'package:date_split_app/core/common/features/account/domain/usecases/add_party_user.dart';
import 'package:equatable/equatable.dart';

import 'package:date_split_app/core/common/features/account/domain/entities/party_user.dart';
import 'package:date_split_app/core/common/features/account/domain/usecases/get_party_user.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({
    required GetPartyUsers getPartyUsers,
    required AddPartyUsers addPartyUsers,
  })  : _getPartyUsers = getPartyUsers,
        _addPartyUsers = addPartyUsers,
        super(AccountInitial()) {
    on<GetPartyUsersEvent>(_onGetPartyUsers);
    on<ClearPartyUserEvent>(_onClearPartyUsers);
    on<AddPartyUserEvent>(_onAddPartyUsers);
  }

  final GetPartyUsers _getPartyUsers;
  final AddPartyUsers _addPartyUsers;

  Future<void> _onGetPartyUsers(
    GetPartyUsersEvent event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    final result = await _getPartyUsers.call(GetPartyUserParams(
      uid: event.uid,
      nickName: event.nickName,
      displayName: event.displayName,
    ));
    result.fold(
      (failure) => emit(AccountError(failure.message)),
      (partyUserList) => emit(
        GetPartyUsersSuccess(partyUserList: partyUserList),
      ),
    );
  }

  Future<void> _onClearPartyUsers(
    ClearPartyUserEvent event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    emit(AccountInitial());
  }

  Future<void> _onAddPartyUsers(
    AddPartyUserEvent event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    final result = await _addPartyUsers
        .call(AddPartyUserParams(partyUserList: event.partyUserList));
    result.fold(
      (failure) => emit(AccountError(failure.message)),
      (token) => emit(AddPartyUserSuccess(token: token)),
    );
  }
}

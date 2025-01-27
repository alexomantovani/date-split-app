import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:date_split_app/core/common/features/account/domain/entities/party_user.dart';
import 'package:date_split_app/core/common/features/account/domain/usecases/get_party_user.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({
    required GetPartyUsers getPartyUsers,
  })  : _getPartyUsers = getPartyUsers,
        super(AccountInitial()) {
    on<GetPartyUsersEvent>(_onGetPartyUsers);
    on<ClearPartyUserEvent>(_onClearPartyUsers);
  }

  final GetPartyUsers _getPartyUsers;

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
}

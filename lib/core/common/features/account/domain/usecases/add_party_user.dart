import 'package:equatable/equatable.dart';

import 'package:date_split_app/core/common/features/account/domain/repositories/account_repository.dart';
import 'package:date_split_app/core/usecases/usecase.dart';
import 'package:date_split_app/core/utils/typedefs.dart';

class AddPartyUsers extends UsecaseWithParams<String, AddPartyUserParams> {
  const AddPartyUsers(this._repository);

  final AccountRepository _repository;

  @override
  EitherFuture<String> call(AddPartyUserParams params) =>
      _repository.addPartyUsers(
        partyUserList: params.partyUserList,
      );
}

class AddPartyUserParams extends Equatable {
  const AddPartyUserParams({required this.partyUserList});

  AddPartyUserParams.empty()
      : this(
          partyUserList: [''],
        );

  final List<String> partyUserList;

  @override
  List<Object?> get props => [partyUserList];
}

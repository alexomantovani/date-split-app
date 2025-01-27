import 'package:date_split_app/core/common/features/account/domain/entities/party_user.dart';
import 'package:date_split_app/core/common/features/account/domain/repositories/account_repository.dart';
import 'package:date_split_app/core/usecases/usecase.dart';
import 'package:date_split_app/core/utils/typedefs.dart';
import 'package:equatable/equatable.dart';

class GetPartyUsers
    extends UsecaseWithParams<List<PartyUser>, GetPartyUserParams> {
  const GetPartyUsers(this._repository);

  final AccountRepository _repository;

  @override
  EitherFuture<List<PartyUser>> call(GetPartyUserParams params) =>
      _repository.getPartyUsers(
        uid: params.uid,
        nickName: params.nickName,
        displayName: params.displayName,
      );
}

class GetPartyUserParams extends Equatable {
  const GetPartyUserParams({
    required this.uid,
    required this.nickName,
    required this.displayName,
  });

  const GetPartyUserParams.empty()
      : this(
          uid: '',
          nickName: '',
          displayName: '',
        );

  final String? uid;
  final String? nickName;
  final String? displayName;

  @override
  List<Object?> get props => [uid, nickName, displayName];
}

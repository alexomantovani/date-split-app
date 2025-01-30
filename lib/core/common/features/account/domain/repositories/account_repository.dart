import 'package:date_split_app/core/common/features/account/domain/entities/party_user.dart';
import 'package:date_split_app/core/utils/typedefs.dart';

abstract class AccountRepository {
  const AccountRepository();

  EitherFuture<List<PartyUser>> getPartyUsers({
    required String? uid,
    required String? nickName,
    required String? displayName,
  });

  EitherFuture<String> addPartyUsers({required List<String> partyUserList});
}

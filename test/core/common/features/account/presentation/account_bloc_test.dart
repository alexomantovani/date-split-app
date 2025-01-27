import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:date_split_app/core/common/features/account/data/models/party_user_model.dart';
import 'package:date_split_app/core/common/features/account/domain/usecases/get_party_user.dart';
import 'package:date_split_app/core/common/features/account/presentation/bloc/account/account_bloc.dart';
import 'package:date_split_app/core/errors/failure.dart';

import '../domain/usecases/get_party_users_test.mocks.dart';

@GenerateMocks([GetPartyUsers])
void main() {
  late AccountBloc accountBloc;
  late GetPartyUsers getPartyUsers;

  setUp(() {
    getPartyUsers = MockGetPartyUsers();
    accountBloc = AccountBloc(getPartyUsers: getPartyUsers);
  });

  group('GetPartyUsers', () {
    const uid = 'uid';
    const nickName = 'nickName';
    const displayName = 'displayName';
    const partyUserList = [PartyUserModel.empty()];

    blocTest<AccountBloc, AccountState>(
      'emits [AuccountLoading, GetPartyUsersSuccess] on successful API call',
      build: () {
        when(getPartyUsers.call(
          const GetPartyUserParams(
            uid: uid,
            nickName: nickName,
            displayName: displayName,
          ),
        )).thenAnswer((_) async => const Right(partyUserList));
        return accountBloc;
      },
      act: (bloc) => bloc.add(
        const GetPartyUsersEvent(
          uid: uid,
          nickName: nickName,
          displayName: displayName,
        ),
      ),
      expect: () => [
        AccountLoading(),
        const GetPartyUsersSuccess(partyUserList: partyUserList)
      ],
      verify: (_) {
        verify(
          getPartyUsers.call(
            const GetPartyUserParams(
              uid: uid,
              nickName: nickName,
              displayName: displayName,
            ),
          ),
        ).called(1);
      },
    );

    blocTest<AccountBloc, AccountState>(
      'emits [AuthLoading, AuthFailure] on sign-in failure',
      build: () {
        when(
          getPartyUsers.call(
            const GetPartyUserParams(
              uid: uid,
              nickName: nickName,
              displayName: displayName,
            ),
          ),
        ).thenAnswer((_) async => const Left(ServerFailure(
              message: 'Invalid credentials',
              statusCode: 401,
            )));
        return accountBloc;
      },
      act: (bloc) => bloc.add(
        const GetPartyUsersEvent(
          uid: uid,
          nickName: nickName,
          displayName: displayName,
        ),
      ),
      expect: () =>
          [AccountLoading(), const AccountError('Invalid credentials')],
      verify: (_) {
        verify(
          getPartyUsers.call(
            const GetPartyUserParams(
              uid: uid,
              nickName: nickName,
              displayName: displayName,
            ),
          ),
        ).called(1);
      },
    );
  });
}

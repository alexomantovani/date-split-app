import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:date_split_app/core/common/features/account/domain/entities/party_user.dart';
import 'package:date_split_app/core/common/features/account/domain/repositories/account_repository.dart';
import 'package:date_split_app/core/common/features/account/domain/usecases/get_party_user.dart';
import 'package:date_split_app/core/errors/failure.dart';

import 'get_party_users_test.mocks.dart';

@GenerateMocks([AccountRepository, GetPartyUsers])
void main() {
  late MockAccountRepository mockAccountRepository;
  late MockGetPartyUsers getPartyUsers;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    getPartyUsers = MockGetPartyUsers();
  });

  group(
    'Get List<PartyUser>',
    () {
      const displayName = 'test@example.com';
      const nickName = 'password123';
      const uid = 'token';
      const partyUsers = [
        PartyUser(
          uid: '',
          nickName: '',
          parties: [],
          avatar: '',
          email: '',
        ),
      ];

      test('should get a list of [PartyUser] when call to API is successful',
          () async {
        when(getPartyUsers.call(const GetPartyUserParams(
          uid: uid,
          nickName: nickName,
          displayName: displayName,
        ))).thenAnswer((_) async => const Right(partyUsers));

        // Act
        final result = await getPartyUsers.call(const GetPartyUserParams(
          uid: uid,
          nickName: nickName,
          displayName: displayName,
        ));

        // Assert
        expect(result, equals(const Right(partyUsers)));
        verify(getPartyUsers.call(const GetPartyUserParams(
          uid: uid,
          nickName: nickName,
          displayName: displayName,
        ))).called(1);
        verifyNoMoreInteractions(mockAccountRepository);
      });

      test('should ruturn Failure when call to API is fails', () async {
        const failure =
            ServerFailure(message: 'Invalid credentials', statusCode: 401);

        when(getPartyUsers.call(const GetPartyUserParams(
          uid: uid,
          nickName: nickName,
          displayName: displayName,
        ))).thenAnswer((_) async => const Left(failure));

        // Act
        final result = await getPartyUsers.call(const GetPartyUserParams(
          uid: uid,
          nickName: nickName,
          displayName: displayName,
        ));

        // Assert
        expect(result, equals(const Left(failure)));
        verify(getPartyUsers.call(const GetPartyUserParams(
          uid: uid,
          nickName: nickName,
          displayName: displayName,
        ))).called(1);
        verifyNoMoreInteractions(mockAccountRepository);
      });
    },
  );
}

// Mocks generated by Mockito 5.4.5 from annotations
// in date_split_app/test/core/common/features/account/domain/usecases/get_party_users_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:date_split_app/core/common/features/account/domain/entities/party_user.dart'
    as _i6;
import 'package:date_split_app/core/common/features/account/domain/repositories/account_repository.dart'
    as _i3;
import 'package:date_split_app/core/common/features/account/domain/usecases/get_party_user.dart'
    as _i7;
import 'package:date_split_app/core/errors/failure.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [AccountRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAccountRepository extends _i1.Mock implements _i3.AccountRepository {
  MockAccountRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.PartyUser>>> getPartyUsers({
    required String? uid,
    required String? nickName,
    required String? displayName,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#getPartyUsers, [], {
              #uid: uid,
              #nickName: nickName,
              #displayName: displayName,
            }),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, List<_i6.PartyUser>>>.value(
                  _FakeEither_0<_i5.Failure, List<_i6.PartyUser>>(
                    this,
                    Invocation.method(#getPartyUsers, [], {
                      #uid: uid,
                      #nickName: nickName,
                      #displayName: displayName,
                    }),
                  ),
                ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, List<_i6.PartyUser>>>);
}

/// A class which mocks [GetPartyUsers].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPartyUsers extends _i1.Mock implements _i7.GetPartyUsers {
  MockGetPartyUsers() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.PartyUser>>> call(
    _i7.GetPartyUserParams? params,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#call, [params]),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, List<_i6.PartyUser>>>.value(
                  _FakeEither_0<_i5.Failure, List<_i6.PartyUser>>(
                    this,
                    Invocation.method(#call, [params]),
                  ),
                ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, List<_i6.PartyUser>>>);
}

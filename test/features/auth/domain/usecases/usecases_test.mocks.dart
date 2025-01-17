// Mocks generated by Mockito 5.4.5 from annotations
// in date_split_app/test/features/auth/domain/usecases/usecases_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:date_split_app/core/errors/failure.dart' as _i5;
import 'package:date_split_app/features/auth/domain/repositories/auth_repository.dart'
    as _i3;
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

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i3.AuthRepository {
  MockAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> signUp({
    required String? email,
    required String? password,
    required String? displayName,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#signUp, [], {
              #email: email,
              #password: password,
              #displayName: displayName,
            }),
            returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
              _FakeEither_0<_i5.Failure, String>(
                this,
                Invocation.method(#signUp, [], {
                  #email: email,
                  #password: password,
                  #displayName: displayName,
                }),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, String>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> signIn({
    required String? email,
    required String? password,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#signIn, [], {
              #email: email,
              #password: password,
            }),
            returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
              _FakeEither_0<_i5.Failure, String>(
                this,
                Invocation.method(#signIn, [], {
                  #email: email,
                  #password: password,
                }),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, String>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> resetPassword({
    required String? email,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#resetPassword, [], {#email: email}),
            returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
              _FakeEither_0<_i5.Failure, void>(
                this,
                Invocation.method(#resetPassword, [], {#email: email}),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, void>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> deleteAccount({
    required String? uid,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#deleteAccount, [], {#uid: uid}),
            returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
              _FakeEither_0<_i5.Failure, void>(
                this,
                Invocation.method(#deleteAccount, [], {#uid: uid}),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, void>>);
}

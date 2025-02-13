// Mocks generated by Mockito 5.4.5 from annotations
// in date_split_app/test/features/expenses/presentation/expenses_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:date_split_app/core/errors/failure.dart' as _i5;
import 'package:date_split_app/features/expenses/domain/entities/expense.dart'
    as _i6;
import 'package:date_split_app/features/expenses/domain/repositories/expenses_repository.dart'
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

/// A class which mocks [ExpensesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockExpensesRepository extends _i1.Mock
    implements _i3.ExpensesRepository {
  MockExpensesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> createExpense(
    _i6.Expense? expense,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#createExpense, [expense]),
            returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
              _FakeEither_0<_i5.Failure, void>(
                this,
                Invocation.method(#createExpense, [expense]),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, void>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Expense>> getExpenseById(String? id) =>
      (super.noSuchMethod(
            Invocation.method(#getExpenseById, [id]),
            returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Expense>>.value(
              _FakeEither_0<_i5.Failure, _i6.Expense>(
                this,
                Invocation.method(#getExpenseById, [id]),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, _i6.Expense>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Expense>>> getAllExpenses(
    String? id,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#getAllExpenses, [id]),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, List<_i6.Expense>>>.value(
                  _FakeEither_0<_i5.Failure, List<_i6.Expense>>(
                    this,
                    Invocation.method(#getAllExpenses, [id]),
                  ),
                ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Expense>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> updateExpense(
    String? id,
    _i6.Expense? expense,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#updateExpense, [id, expense]),
            returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
              _FakeEither_0<_i5.Failure, void>(
                this,
                Invocation.method(#updateExpense, [id, expense]),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, void>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> deleteExpense(String? id) =>
      (super.noSuchMethod(
            Invocation.method(#deleteExpense, [id]),
            returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
              _FakeEither_0<_i5.Failure, void>(
                this,
                Invocation.method(#deleteExpense, [id]),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, void>>);
}

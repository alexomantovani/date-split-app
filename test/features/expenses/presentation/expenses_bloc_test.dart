import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:date_split_app/core/errors/failure.dart';
import 'package:date_split_app/features/expenses/domain/entities/expense.dart';
import 'package:date_split_app/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:date_split_app/features/expenses/presentation/bloc/expenses_bloc.dart';

import 'expenses_bloc_test.mocks.dart';

@GenerateMocks([ExpensesRepository])
void main() {
  late MockExpensesRepository mockExpensesRepository;
  late ExpensesBloc expensesBloc;

  setUp(() {
    mockExpensesRepository = MockExpensesRepository();
    expensesBloc = ExpensesBloc(expensesRepository: mockExpensesRepository);
  });

  tearDown(() {
    expensesBloc.close();
  });

  const testUserId = 'user123';
  const testExpenseId = 'expense123';
  final testExpense = Expense(
    id: testExpenseId,
    name: 'Test Expense',
    value: 100.0,
    date: DateTime(2023, 12, 25),
    paidBy: testUserId,
    sharedWith: const ['user456', 'user789'],
  );
  final testExpensesList = [testExpense];

  group('CreateExpenseEvent', () {
    blocTest<ExpensesBloc, ExpensesState>(
      'should emit [ExpensesLoading, ExpenseCreatedSuccess] on successful creation',
      build: () {
        when(mockExpensesRepository.createExpense(testExpense))
            .thenAnswer((_) async => const Right(null));
        return expensesBloc;
      },
      act: (bloc) => bloc.add(CreateExpenseEvent(testExpense)),
      expect: () => [
        ExpensesLoading(),
        ExpenseCreatedSuccess(),
      ],
      verify: (_) {
        verify(mockExpensesRepository.createExpense(testExpense)).called(1);
      },
    );

    blocTest<ExpensesBloc, ExpensesState>(
      'should emit [ExpensesLoading, ExpensesError] on failure',
      build: () {
        when(mockExpensesRepository.createExpense(testExpense))
            .thenAnswer((_) async => const Left(
                  ServerFailure(
                    message: 'Creation failed',
                    statusCode: 500,
                  ),
                ));
        return expensesBloc;
      },
      act: (bloc) => bloc.add(CreateExpenseEvent(testExpense)),
      expect: () => [
        ExpensesLoading(),
        const ExpensesError('Creation failed'),
      ],
      verify: (_) {
        verify(mockExpensesRepository.createExpense(testExpense)).called(1);
      },
    );
  });

  group('GetExpenseByIdEvent', () {
    blocTest<ExpensesBloc, ExpensesState>(
      'should emit [ExpensesLoading, ExpenseLoadedSuccess] on successful retrieval',
      build: () {
        when(mockExpensesRepository.getExpenseById(testExpenseId))
            .thenAnswer((_) async => Right(testExpense));
        return expensesBloc;
      },
      act: (bloc) => bloc.add(const GetExpenseByIdEvent(testExpenseId)),
      expect: () => [
        ExpensesLoading(),
        ExpenseLoadedSuccess(testExpense),
      ],
      verify: (_) {
        verify(mockExpensesRepository.getExpenseById(testExpenseId)).called(1);
      },
    );

    blocTest<ExpensesBloc, ExpensesState>(
      'should emit [ExpensesLoading, ExpensesError] on failure',
      build: () {
        when(mockExpensesRepository.getExpenseById(testExpenseId))
            .thenAnswer((_) async => const Left(
                  ServerFailure(
                    message: 'Expense not found',
                    statusCode: 404,
                  ),
                ));
        return expensesBloc;
      },
      act: (bloc) => bloc.add(const GetExpenseByIdEvent(testExpenseId)),
      expect: () => [
        ExpensesLoading(),
        const ExpensesError('Expense not found'),
      ],
      verify: (_) {
        verify(mockExpensesRepository.getExpenseById(testExpenseId)).called(1);
      },
    );
  });

  group('GetAllExpensesEvent', () {
    blocTest<ExpensesBloc, ExpensesState>(
      'should emit [ExpensesLoading, ExpensesListLoadedSuccess] on successful retrieval',
      build: () {
        when(mockExpensesRepository.getAllExpenses(testUserId))
            .thenAnswer((_) async => Right(testExpensesList));
        return expensesBloc;
      },
      act: (bloc) => bloc.add(const GetAllExpensesEvent(testUserId)),
      expect: () => [
        ExpensesLoading(),
        ExpensesListLoadedSuccess(testExpensesList),
      ],
      verify: (_) {
        verify(mockExpensesRepository.getAllExpenses(testUserId)).called(1);
      },
    );

    blocTest<ExpensesBloc, ExpensesState>(
      'should emit [ExpensesLoading, ExpensesError] on failure',
      build: () {
        when(mockExpensesRepository.getAllExpenses(testUserId))
            .thenAnswer((_) async => const Left(
                  ServerFailure(
                    message: 'Failed to load expenses',
                    statusCode: 500,
                  ),
                ));
        return expensesBloc;
      },
      act: (bloc) => bloc.add(const GetAllExpensesEvent(testUserId)),
      expect: () => [
        ExpensesLoading(),
        const ExpensesError('Failed to load expenses'),
      ],
      verify: (_) {
        verify(mockExpensesRepository.getAllExpenses(testUserId)).called(1);
      },
    );
  });
}

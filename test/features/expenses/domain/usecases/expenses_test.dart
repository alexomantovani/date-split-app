import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:date_split_app/core/errors/failure.dart';
import 'package:date_split_app/features/expenses/domain/entities/expense.dart';
import 'package:date_split_app/features/expenses/domain/repositories/expenses_repository.dart';

import 'expenses_test.mocks.dart';

@GenerateMocks([ExpensesRepository])
void main() {
  late MockExpensesRepository mockExpensesRepository;

  final expense = Expense(
    id: '1',
    name: 'Test Expense',
    value: 100.0,
    date: DateTime.now(),
    paidBy: 'User1',
    sharedWith: const ['User2', 'User3'],
  );

  const String id = '';

  setUp(() {
    mockExpensesRepository = MockExpensesRepository();
  });

  group('Create Expense', () {
    test('should save expense successfully', () async {
      // Simulação de sucesso
      when(mockExpensesRepository.createExpense(expense))
          .thenAnswer((_) async => const Right(null));

      final result = await mockExpensesRepository.createExpense(expense);

      // Verificações
      expect(result, const Right(null));
      verify(mockExpensesRepository.createExpense(expense)).called(1);
    });

    test('should return failure when saving expense fails', () async {
      // Simulação de falha
      when(mockExpensesRepository.createExpense(expense)).thenAnswer(
        (_) async => const Left(
            ServerFailure(message: 'Failed to save expense', statusCode: 500)),
      );

      final result = await mockExpensesRepository.createExpense(expense);

      // Verificações
      expect(result, isA<Left>());
      verify(mockExpensesRepository.createExpense(expense)).called(1);
    });
  });

  group('Read Expense', () {
    test('should fetch expense by ID successfully', () async {
      when(mockExpensesRepository.getExpenseById('1'))
          .thenAnswer((_) async => Right(expense));

      final result = await mockExpensesRepository.getExpenseById('1');

      expect(result, Right(expense));
      verify(mockExpensesRepository.getExpenseById('1')).called(1);
    });

    test('should return failure when expense is not found', () async {
      when(mockExpensesRepository.getExpenseById('1')).thenAnswer((_) async =>
          const Left(
              ServerFailure(message: 'Expense not found', statusCode: 404)));

      final result = await mockExpensesRepository.getExpenseById('1');

      expect(result, isA<Left>());
      verify(mockExpensesRepository.getExpenseById('1')).called(1);
    });
  });

  group('Get All Expenses', () {
    test('should fetch all expenses successfully', () async {
      final expensesList = [expense];
      when(mockExpensesRepository.getAllExpenses(id))
          .thenAnswer((_) async => Right(expensesList));

      final result = await mockExpensesRepository.getAllExpenses(id);

      expect(result, Right(expensesList));
      verify(mockExpensesRepository.getAllExpenses(id)).called(1);
    });

    test('should return failure when fetching expenses fails', () async {
      when(mockExpensesRepository.getAllExpenses(id)).thenAnswer((_) async =>
          const Left(ServerFailure(
              message: 'Failed to fetch expenses', statusCode: 500)));

      final result = await mockExpensesRepository.getAllExpenses(id);

      expect(result, isA<Left>());
      verify(mockExpensesRepository.getAllExpenses(id)).called(1);
    });
  });

  group('Update Expense', () {
    final updatedExpense = Expense(
      id: '1',
      name: 'Updated Test Expense',
      value: 150.0,
      date: DateTime.now(),
      paidBy: 'User1',
      sharedWith: const ['User2', 'User3'],
    );

    test('should update expense successfully', () async {
      // Simulação de sucesso
      when(mockExpensesRepository.updateExpense(id, updatedExpense))
          .thenAnswer((_) async => const Right(null));

      final result =
          await mockExpensesRepository.updateExpense(id, updatedExpense);

      // Verificações
      expect(result, const Right(null));
      verify(mockExpensesRepository.updateExpense(id, updatedExpense))
          .called(1);
    });

    test('should return failure when updating expense fails', () async {
      // Simulação de falha
      when(mockExpensesRepository.updateExpense(id, updatedExpense)).thenAnswer(
        (_) async => const Left(ServerFailure(
            message: 'Failed to update expense', statusCode: 500)),
      );

      final result =
          await mockExpensesRepository.updateExpense(id, updatedExpense);

      // Verificações
      expect(result, isA<Left>());
      verify(mockExpensesRepository.updateExpense(id, updatedExpense))
          .called(1);
    });
  });

  group('Delete Expense', () {
    test('should delete expense successfully', () async {
      // Simulação de sucesso
      when(mockExpensesRepository.deleteExpense('1'))
          .thenAnswer((_) async => const Right(null));

      final result = await mockExpensesRepository.deleteExpense('1');

      // Verificações
      expect(result, const Right(null));
      verify(mockExpensesRepository.deleteExpense('1')).called(1);
    });

    test('should return failure when deleting expense fails', () async {
      // Simulação de falha
      when(mockExpensesRepository.deleteExpense('1')).thenAnswer(
        (_) async => const Left(ServerFailure(
            message: 'Failed to delete expense', statusCode: 500)),
      );

      final result = await mockExpensesRepository.deleteExpense('1');

      // Verificações
      expect(result, isA<Left>());
      verify(mockExpensesRepository.deleteExpense('1')).called(1);
    });
  });
}

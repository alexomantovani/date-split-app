import 'package:dartz/dartz.dart';
import 'package:date_split_app/core/errors/failure.dart';
import 'package:date_split_app/features/expenses/domain/entities/expense.dart';

abstract class ExpensesRepository {
  Future<Either<Failure, void>> createExpense(Expense expense);
  Future<Either<Failure, Expense>> getExpenseById(String id);
  Future<Either<Failure, List<Expense>>> getAllExpenses(String id);
  Future<Either<Failure, void>> updateExpense(String id, Expense expense);
  Future<Either<Failure, void>> deleteExpense(String id);
}

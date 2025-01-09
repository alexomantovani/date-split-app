import 'package:dartz/dartz.dart';
import 'package:date_split_app/core/errors/exception.dart';
import 'package:date_split_app/core/errors/failure.dart';
import 'package:date_split_app/features/expenses/data/datasources/expenses_remote_data_source.dart';
import 'package:date_split_app/features/expenses/domain/entities/expense.dart';
import 'package:date_split_app/features/expenses/domain/repositories/expenses_repository.dart';

class ExpensesRepositoryImplementation implements ExpensesRepository {
  final ExpensesRemoteDataSource _remoteDataSource;

  const ExpensesRepositoryImplementation(this._remoteDataSource);

  @override
  Future<Either<Failure, void>> createExpense(Expense expense) async {
    try {
      await _remoteDataSource.createExpense(expense);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString(), statusCode: null));
    }
  }

  @override
  Future<Either<Failure, Expense>> getExpenseById(String id) async {
    try {
      final expense = await _remoteDataSource.getExpenseById(id);
      return Right(expense);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString(), statusCode: null));
    }
  }

  @override
  Future<Either<Failure, List<Expense>>> getAllExpenses(String id) async {
    try {
      final expenses = await _remoteDataSource.getAllExpenses(id);
      return Right(expenses);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString(), statusCode: null));
    }
  }

  @override
  Future<Either<Failure, void>> updateExpense(
      String id, Expense expense) async {
    try {
      await _remoteDataSource.updateExpense(id, expense);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString(), statusCode: null));
    }
  }

  @override
  Future<Either<Failure, void>> deleteExpense(String id) async {
    try {
      await _remoteDataSource.deleteExpense(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString(), statusCode: null));
    }
  }
}

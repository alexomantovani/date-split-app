import 'package:dartz/dartz.dart';
import 'package:date_split_app/core/errors/exception.dart';
import 'package:date_split_app/core/errors/failure.dart';
import 'package:date_split_app/features/transfers/data/datasources/transfer_remote_data_source.dart';
import 'package:date_split_app/features/transfers/domain/entities/transfer.dart';
import 'package:date_split_app/features/transfers/domain/repositories/transfer_repository.dart';

class TransferRepositoryImplementation implements TransferRepository {
  final TransfersRemoteDataSource _remoteDataSource;

  const TransferRepositoryImplementation(this._remoteDataSource);

  @override
  Future<Either<Failure, void>> createTransfer(Transfer transfer) async {
    try {
      await _remoteDataSource.createTransfer(transfer);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString(), statusCode: null));
    }
  }

  @override
  Future<Either<Failure, Transfer>> getTransferById(String id) async {
    try {
      final transfer = await _remoteDataSource.getTransferById(id);
      return Right(transfer);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString(), statusCode: null));
    }
  }

  @override
  Future<Either<Failure, List<Transfer>>> getAllTransfers(String id) async {
    try {
      final transfers = await _remoteDataSource.getAllTransfers(id);
      return Right(transfers);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString(), statusCode: null));
    }
  }

  @override
  Future<Either<Failure, void>> updateTransfer(
      String id, Transfer transfer) async {
    try {
      await _remoteDataSource.updateTransfer(id, transfer);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString(), statusCode: null));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTransfer(String id) async {
    try {
      await _remoteDataSource.deleteTransfer(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString(), statusCode: null));
    }
  }
}

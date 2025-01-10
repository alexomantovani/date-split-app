import 'package:dartz/dartz.dart';
import 'package:date_split_app/core/errors/failure.dart';
import 'package:date_split_app/features/transfers/domain/entities/transfer.dart';

abstract class TransferRepository {
  Future<Either<Failure, void>> createTransfer(Transfer transfer);
  Future<Either<Failure, Transfer>> getTransferById(String id);
  Future<Either<Failure, List<Transfer>>> getAllTransfers(String userId);
  Future<Either<Failure, void>> updateTransfer(String id, Transfer transfer);
  Future<Either<Failure, void>> deleteTransfer(String id);
}

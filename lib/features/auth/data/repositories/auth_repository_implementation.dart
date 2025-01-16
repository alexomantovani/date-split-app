import 'package:dartz/dartz.dart';
import 'package:date_split_app/core/errors/exception.dart';
import 'package:date_split_app/core/errors/failure.dart';
import 'package:date_split_app/core/utils/typedefs.dart';
import 'package:date_split_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:date_split_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  const AuthRepositoryImplementation(this._remoteDataSource);

  @override
  EitherFuture<void> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      await _remoteDataSource.signUp(
        email: email,
        password: password,
        displayName: displayName,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(
          message: e.toString(), cause: 'Unexpected error', statusCode: -1));
    }
  }

  @override
  EitherFuture<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _remoteDataSource.signIn(email: email, password: password);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString(), statusCode: null));
    }
  }

  @override
  EitherFuture<void> resetPassword({required String email}) async {
    try {
      await _remoteDataSource.resetPassword(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString(), statusCode: null));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount({required String uid}) async {
    try {
      await _remoteDataSource.deleteAccount(uid);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString(), statusCode: null));
    }
  }
}

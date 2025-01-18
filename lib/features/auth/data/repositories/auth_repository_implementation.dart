import 'package:dartz/dartz.dart';
import 'package:date_split_app/core/errors/exception.dart';
import 'package:date_split_app/core/errors/failure.dart';
import 'package:date_split_app/core/utils/typedefs.dart';
import 'package:date_split_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:date_split_app/features/auth/data/models/user_model.dart';
import 'package:date_split_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  const AuthRepositoryImplementation(this._remoteDataSource);

  @override
  EitherFuture<String> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      final result = await _remoteDataSource.signUp(
        email: email,
        password: password,
        displayName: displayName,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(
          message: e.toString(), cause: 'Unexpected error', statusCode: -1));
    }
  }

  @override
  EitherFuture<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result =
          await _remoteDataSource.signIn(email: email, password: password);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString(), statusCode: null));
    }
  }

  @override
  EitherFuture<String> resetPassword({required String email}) async {
    try {
      final result = await _remoteDataSource.resetPassword(email);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString(), statusCode: null));
    }
  }

  @override
  EitherFuture<String> deleteAccount({required String uid}) async {
    try {
      final result = await _remoteDataSource.deleteAccount(uid);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString(), statusCode: null));
    }
  }
}

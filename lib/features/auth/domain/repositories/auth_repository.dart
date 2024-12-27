import 'package:dartz/dartz.dart';
import 'package:date_split_app/core/errors/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> signUp(
      String email, String password, String displayName);
  Future<Either<Failure, void>> signIn(String email, String password);
  Future<Either<Failure, void>> resetPassword(String email);
  Future<Either<Failure, void>> deleteAccount(String uid);
}

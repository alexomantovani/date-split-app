import 'package:date_split_app/core/utils/typedefs.dart';

abstract class AuthRepository {
  const AuthRepository();

  EitherFuture<void> signUp({
    required String email,
    required String password,
    required String displayName,
  });
  EitherFuture<void> signIn({required String email, required String password});
  EitherFuture<void> resetPassword({required String email});
  EitherFuture<void> deleteAccount({required String uid});
}

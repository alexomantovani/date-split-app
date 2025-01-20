import 'package:date_split_app/core/utils/typedefs.dart';
import 'package:date_split_app/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  const AuthRepository();

  EitherFuture<String> signUp({
    required String email,
    required String password,
    required String displayName,
  });
  EitherFuture<String> signIn(
      {required String email, required String password});
  EitherFuture<String> resetPassword({required String email});
  EitherFuture<String> deleteAccount({required String uid});
  EitherFuture<UserModel> getUser();
}

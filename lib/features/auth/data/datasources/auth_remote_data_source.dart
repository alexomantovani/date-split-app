abstract class AuthRemoteDataSource {
  Future<String> signUp({
    required String email,
    required String password,
    required String displayName,
  });

  Future<void> signIn({
    required String email,
    required String password,
  });

  Future<void> resetPassword(String email);

  Future<void> deleteAccount(String uid);
}

abstract class AuthRepository {
  Future<String> signUp(String email, String password, String displayName);
  Future<void> signIn(String email, String password);
  Future<void> resetPassword(String email);
  Future<void> deleteAccount(String uid);
}

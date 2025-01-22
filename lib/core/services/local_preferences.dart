import 'package:shared_preferences/shared_preferences.dart';

class LocalPreferences {
  const LocalPreferences._();

  static Future<void> setToken({required String token}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token;
  }

  static Future<void> clearToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  static Future<void> updateToken({required String newToken}) async {
    await clearToken();
    await setToken(token: newToken);
  }
}

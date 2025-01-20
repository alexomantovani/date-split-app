import 'package:date_split_app/core/services/local_preferences.dart';
import 'package:date_split_app/core/utils/typedefs.dart';
import 'package:date_split_app/features/auth/data/models/user_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

abstract class AuthLocalDataSource {
  Future<UserModel> getUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl();

  @override
  Future<UserModel> getUser() async {
    final String? token = await LocalPreferences.getToken();
    late UserModel userModel;
    if (token != null && !JwtDecoder.isExpired(token)) {
      final DataMap user = JwtDecoder.decode(token);
      userModel = UserModel.fromJson(user);
    }
    return userModel;
  }
}

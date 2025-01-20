import 'package:date_split_app/core/common/views/home_page.dart';
import 'package:date_split_app/core/services/local_preferences.dart';
import 'package:date_split_app/features/auth/presentation/views/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AppService {
  const AppService._();

  static Future<Widget> getInitialPage() async {
    String? token = await LocalPreferences.getToken();
    await Future.delayed(const Duration(milliseconds: 1000));
    if (token != null && !JwtDecoder.isExpired(token)) {
      return const MyHomePage();
    } else {
      await LocalPreferences.clearToken();
    }
    return const AuthPage();
  }
}

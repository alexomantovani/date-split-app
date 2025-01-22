import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:date_split_app/core/common/views/home_page.dart';
import 'package:date_split_app/core/services/local_preferences.dart';
import 'package:date_split_app/features/auth/presentation/views/auth_page.dart';

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

  static Widget homeBuilder() {
    return FutureBuilder<Widget>(
      future: AppService.getInitialPage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material(
            child: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasData) {
          return snapshot.data!;
        } else {
          return const AuthPage();
        }
      },
    );
  }

  static Future<void> showAccountConfigurationModal(
      {required BuildContext context, required Widget child}) async {
    return await showModalBottomSheet(
      context: context,
      builder: (context) => child,
    );
  }
}

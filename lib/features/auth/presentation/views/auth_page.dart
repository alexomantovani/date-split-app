import 'package:flutter/material.dart';

import 'package:date_split_app/core/utils/constants.dart';
import 'package:date_split_app/core/utils/core_utils.dart';
import 'package:date_split_app/core/utils/styles.dart';
import 'package:date_split_app/features/auth/presentation/views/signin_page.dart';
import 'package:date_split_app/features/auth/presentation/views/signup_page.dart';
import 'package:date_split_app/features/auth/presentation/widgets/auth_background.dart';
import 'package:date_split_app/features/auth/presentation/widgets/confirm_action_button.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset(kAuthHouseImage),
          ConfirmActionButton(
            backGroundColor: Styles.kPrimaryYellow,
            label: 'Cadastrar',
            onPressed: () => CoreUtils.unNamedRouteNavigation(
              page: const SignupPage(),
              context: context,
            ),
          ),
          const SizedBox(height: 15.0),
          ConfirmActionButton(
            backGroundColor: const Color(0xFFFFFFFF),
            label: 'Entrar',
            onPressed: () => CoreUtils.unNamedRouteNavigation(
                page: const SigninPage(), context: context),
          ),
        ],
      ),
    );
  }
}

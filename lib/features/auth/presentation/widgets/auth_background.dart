import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:date_split_app/core/utils/assets.dart';
import 'package:date_split_app/core/utils/styles.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Styles.kPrimaryBlue,
        toolbarHeight: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Styles.kPrimaryBlue),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.kAuthBackgroundImage),
            fit: BoxFit.fill,
          ),
        ),
        child: body,
      ),
    );
  }
}

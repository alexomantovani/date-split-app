import 'package:date_split_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryBlue,
        toolbarHeight: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: kPrimaryBlue),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(kAuthBackgroundImage),
            fit: BoxFit.fill,
          ),
        ),
        child: body,
      ),
    );
  }
}

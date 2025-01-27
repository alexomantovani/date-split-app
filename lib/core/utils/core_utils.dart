import 'package:date_split_app/core/services/local_preferences.dart';
import 'package:date_split_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CoreUtils {
  const CoreUtils._();

  static void unNamedRouteNavigation({
    required Widget page,
    required BuildContext context,
    bool? customRoute = false,
  }) {
    Navigator.of(context).push(
      customRoute!
          ? PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => page,
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) =>
                  SlideTransition(
                position: animation.drive(
                  Tween(
                    begin: const Offset(0.0, 1.0),
                    end: Offset.zero,
                  ).chain(
                    CurveTween(
                      curve: Curves.easeInOut,
                    ),
                  ),
                ),
                child: child,
              ),
            )
          : MaterialPageRoute(
              builder: (context) => page,
            ),
    );
  }

  static void showSnackBar({
    required BuildContext context,
    required String message,
    bool isFailure = false,
  }) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStyle(
              color: isFailure ? Styles.kStandardWhite : Styles.kPrimaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor:
              isFailure ? Styles.kStandardDelete : Styles.kPrimaryYellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
        ),
      );
  }

  static Future<Map<String, String>> tokenHeaders() async {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await LocalPreferences.getToken()}',
    };
  }
}

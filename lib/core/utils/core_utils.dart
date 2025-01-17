import 'package:date_split_app/core/utils/constants.dart';
import 'package:flutter/material.dart';

class CoreUtils {
  const CoreUtils._();

  static void unNamedRouteNavigation({
    required Widget page,
    required BuildContext context,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
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
              color: isFailure ? kStandardWhite : kPrimaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: isFailure ? kStandardDelete : kPrimaryYellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
        ),
      );
  }
}

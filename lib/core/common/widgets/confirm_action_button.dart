import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:date_split_app/core/utils/assets.dart';
import 'package:date_split_app/core/utils/styles.dart';

class ConfirmActionButton extends StatelessWidget {
  const ConfirmActionButton({
    super.key,
    required this.backGroundColor,
    required this.label,
    required this.onPressed,
    this.padding,
    this.labelColor,
    this.fixedSize = false,
    this.isLoading = false,
    this.type = ButtonType.confirm,
  });

  final Color backGroundColor;
  final String label;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  final Color? labelColor;
  final bool? fixedSize;
  final bool isLoading;
  final ButtonType type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 40.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backGroundColor,
          fixedSize: fixedSize == true
              ? const Size.fromWidth(160.0)
              : const Size.fromHeight(0),
          shape: type == ButtonType.add
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                )
              : null,
        ),
        onPressed: onPressed,
        child: isLoading
            ? const SizedBox(
                height: 24.0,
                width: 24.0,
                child: CircularProgressIndicator(color: Styles.kPrimaryText),
              )
            : type == ButtonType.add
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.kIcAddWhite),
                      const SizedBox(width: 8.0),
                      Text(
                        label,
                        style: Styles.titleLarge.copyWith(
                          color: labelColor ?? Styles.kPrimaryText,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                : Text(
                    label,
                    style: Styles.titleLarge.copyWith(
                      color: labelColor ?? Styles.kPrimaryText,
                      fontSize: 18,
                    ),
                  ),
      ),
    );
  }
}

enum ButtonType {
  confirm,
  add;

  const ButtonType();
}

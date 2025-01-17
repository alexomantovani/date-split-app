import 'package:date_split_app/core/utils/constants.dart';
import 'package:flutter/material.dart';

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
  });

  final Color backGroundColor;
  final String label;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  final Color? labelColor;
  final bool? fixedSize;
  final bool isLoading;

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
        ),
        onPressed: onPressed,
        child: isLoading
            ? const SizedBox(
                height: 24.0,
                width: 24.0,
                child: CircularProgressIndicator(color: kPrimaryText),
              )
            : Text(
                label,
                style: TextStyle(
                  color: labelColor ?? kPrimaryText,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}

import 'package:date_split_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    required this.controller,
    this.filled = false,
    this.obscureText = false,
    this.readOnly = false,
    this.validator,
    this.fillColour,
    this.suffixIcon,
    this.prefixIcon,
    this.enabledBorderColor,
    this.backgroundColor,
    this.hintText,
    this.keyboardType,
    this.hintStyle,
    this.mainStyle,
    this.overrideValidator = false,
    this.defaultBorder = true,
    this.onFieldSubmitted,
  });

  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool filled;
  final Color? fillColour;
  final Color? backgroundColor;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final Color? enabledBorderColor;
  final Widget? prefixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool overrideValidator;
  final bool defaultBorder;
  final TextStyle? hintStyle;
  final TextStyle? mainStyle;
  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: overrideValidator
          ? validator
          : (value) {
              if (value == null || value.isEmpty) {
                return 'Campo obrigatório';
              }
              return validator?.call(value);
            },
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      onTap: () => FocusScope.of(context).requestFocus(),
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      style: mainStyle,
      decoration: InputDecoration(
        border: defaultBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(90),
              )
            : null,
        enabledBorder: defaultBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(90),
                borderSide:
                    BorderSide(color: enabledBorderColor ?? Colors.grey),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: enabledBorderColor ?? Styles.kDescriptionText,
                  width: 0.5,
                ),
              ),
        focusedBorder: defaultBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(90),
                borderSide: const BorderSide(
                  color: Styles.kPrimaryText,
                ),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: enabledBorderColor ?? Styles.kDescriptionText,
                ),
              ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        filled: filled,
        fillColor: fillColour,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        prefixIconColor: Styles.kDescriptionText,
        hintText: hintText,
        hintStyle: hintStyle ??
            Styles.bodyMedium.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
      ),
    );
  }
}

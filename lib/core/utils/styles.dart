import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  const Styles._();

  static const Color kPrimaryBlue = Color(0xFF8FD9F7);
  static const Color kPrimaryBlueDark = Color(0xFF25A2D3);
  static const Color kPrimaryYellow = Color(0xFFFBE790);
  static const Color kPrimaryText = Color(0xFF5E5E5E);
  static const Color kPrimaryPeach = Color(0xFFFFF0DA);
  static const Color kDescriptionText = Color(0xFFB8B8B8);
  static const Color kStandardWhite = Color(0xFFFFFFFF);
  static const Color kStandardBlack = Color(0xFF000000);
  static const Color kStandardDelete = Color(0xFFCE735F);
  static const Color kStandardLightGrey = Color(0xFFEEEEEE);

  static TextStyle bodyLarge = GoogleFonts.notoSansTc(
    color: kPrimaryText,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static TextStyle bodyMedium = GoogleFonts.notoSansTc(
    color: kDescriptionText,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextStyle bodySmall = GoogleFonts.notoSansTc(
    color: kDescriptionText,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );
}

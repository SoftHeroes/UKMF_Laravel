import 'package:flutter/material.dart';

class AppTheme {
  final double appTextFontSize, appTextWordSpacing, appTextLetterSpacing;
  final bool isLink;

  Color appTextLink = Color(0xFF01579B);
  Color appTextColor = Colors.black;

  MaterialColor myPrimaryMaterialColor = const MaterialColor(0xFFB0CA0A, const {
    50: const Color(0xFFDFE99D),
    100: const Color(0xFFCFDF6C),
    200: const Color(0xFFC7D953),
    300: const Color(0xFFBFD43B),
    400: const Color(0xFFB7CF22),
    500: const Color(0xFFB0CA0A),
    600: const Color(0xFF9EB509),
    700: const Color(0xFF7B8D07),
    800: const Color(0xFF697906),
    900: const Color(0xFF586505)
  });

  TextStyle appTextStyle;

  AppTheme(
      {this.appTextFontSize = 18,
      this.appTextWordSpacing = 2,
      this.appTextLetterSpacing = 0,
      this.appTextColor,
      this.isLink = false}) {
    if (isLink) {
      appTextColor = appTextLink;
    }

    appTextStyle = TextStyle(
        fontSize: appTextFontSize,
        wordSpacing: appTextWordSpacing,
        letterSpacing: appTextLetterSpacing,
        color: appTextColor);
  }
}

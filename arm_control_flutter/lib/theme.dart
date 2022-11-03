import 'package:flutter/material.dart';

/*
 Here is where we will constants relating to the theme of our app, such as
 color scheme, font settings, and other UI objects as necessary
 */

class AppColors {
  // Flutter colors are RGB color codes prefixed with an opacity value.
  // The FF represents full opacity
  static const darkBlue = Color(0xFF022B3A);
  static const lightBlue = Color(0xFFB2BEC1);
  static const pink = Color(0xFFC75E61);
}

ColorScheme colorScheme = const ColorScheme.dark(
  primary: AppColors.pink,
  primaryVariant: AppColors.pink,
  secondary: AppColors.lightBlue,
  secondaryVariant: AppColors.lightBlue,
  surface: AppColors.darkBlue,
  background: AppColors.darkBlue,
);
final appTheme = ThemeData.from(
    colorScheme: colorScheme
);
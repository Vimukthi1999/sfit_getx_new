import 'package:flutter/material.dart';


import 'app_colors.dart';
import 'app_textstyles.dart';

class AppTheme {
  static final AppTextStyle _textStyle = AppTextStyle.instance;

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: AppColor.primarySwatch,
    primaryColor: AppColor.primarycolor,
    // primarySwatch: AppColor.primarySwatch,
    textTheme: TextTheme(
      // displayLarge: _textStyle.displayLarge,
      // displayMedium: _textStyle.displayMedium,
      displaySmall: _textStyle.displaySmall,
      // headlineLarge: _textStyle.headlineLarge,
      // headlineMedium: _textStyle.headlineMedium,
      // headlineSmall: _textStyle.headlineSmall,
      // titleLarge: _textStyle.titleLarge,
      // titleSmall: _textStyle.titleSmall,
      // titleMedium: _textStyle.titleMedium,
      // labelLarge: _textStyle.labelLarge,
      // labelMedium: _textStyle.labelMedium,
      // labelSmall: _textStyle.labelSmall,
      // bodyLarge: _textStyle.bodyLarge,
      bodyMedium: _textStyle.bodyMedium,
      // bodySmall: _textStyle.bodySmall,
      // caption: _textStyle.hintStyle,

    ),
  );
}

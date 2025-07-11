import 'package:devprompt/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.lightThemeBackgroundColor,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkThemeBackgroundColor,
      elevation: 0,
    ),
    textTheme: Typography.material2021().black,
    useMaterial3: true,
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.darkThemeBackgroundColor,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightThemeBackgroundColor,
      elevation: 0,
    ),
    textTheme: Typography.material2021().white,
    useMaterial3: true,
  );
}

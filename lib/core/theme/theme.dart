import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF1A73E8);
  static const white = Colors.white;
  static const dark = Color(0xFF1F2937);
}

final appTheme = ThemeData(
  useMaterial3: true,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.white,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: AppColors.primary,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: AppColors.dark,
    ),
  ),
);

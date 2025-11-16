import 'package:flutter/material.dart';

// 1. Define all your custom colors
class AppColors {
  static const Color background = Color(0xFFF5F8FF);
  static const Color primary = Color(0xFF6C63FF);
  static const Color lightBlue = Color(0xFFD4E1FF);
  static const Color error = Color(0xFFF78E8E);
}

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,


);

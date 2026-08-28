import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';

/// Base text theme for the app. Font sizes here are the "reference"
/// sizes for a standard phone; MaterialApp applies a clamped text
/// scaler (see AppTheme / main.dart) so these stay legible across
/// device sizes and OS accessibility text-size settings without
/// every widget needing to compute its own font size.
class AppTextStyle {
  AppTextStyle._();

  static const String fontFamily = 'Roboto';

  static const TextTheme textTheme = TextTheme(
    headlineSmall: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondary,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondary,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: AppColors.textHint,
    ),
  );
}

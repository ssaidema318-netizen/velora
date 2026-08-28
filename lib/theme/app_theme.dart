import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_radius.dart';
import 'package:velora/typography/app_text_style.dart';

/// Central Material theme for Velora, built from the brand colors in
/// [AppColors] and the type scale in [AppTextStyle]. Wiring this into
/// MaterialApp means every `Theme.of(context)` call across the app
/// (used throughout for text styles) now resolves to the intended
/// brand look instead of Flutter's generic default theme.
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      textTheme: AppTextStyle.textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.surface,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.primary),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.divider),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),
    );
  }
}

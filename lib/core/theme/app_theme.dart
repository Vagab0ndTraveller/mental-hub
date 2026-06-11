import 'package:flutter/material.dart';

import 'app_colors.dart';

final class AppTheme {
  static final ColorScheme _lightScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.surface,
    secondary: AppColors.secondary,
    onSecondary: AppColors.textPrimary,
    error: AppColors.error,
    onError: AppColors.surface,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
  ).copyWith(
    surfaceContainerHighest: AppColors.primaryLight,
  );

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: _lightScheme,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
    ),
    textTheme: const TextTheme().apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    ),
    dividerColor: AppColors.primaryLight,
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.textPrimary,
      ),
    ),
  );

  static final ThemeData dark = light;
}

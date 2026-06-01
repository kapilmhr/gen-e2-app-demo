import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Les Mills design system — typography scale.
///
/// Font family: Untitled Sans (Material-3 style scale). Regular = 400,
/// Medium = 500. These constants define the type scale used to assemble the
/// [TextTheme] in `AppTheme`. In widgets, read styles via
/// `Theme.of(context).textTheme.*` and override colour only with
/// `.copyWith(color: …)` — never change size, weight, letterSpacing, or height.
abstract final class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily = 'Untitled Sans';

  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 57,
    fontWeight: FontWeight.w500,
    height: 64 / 57,
    letterSpacing: 2,
    color: AppColors.black,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 45,
    fontWeight: FontWeight.w500,
    height: 52 / 45,
    letterSpacing: 2,
    color: AppColors.black,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w500,
    height: 44 / 36,
    letterSpacing: 1,
    color: AppColors.black,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w400,
    height: 40 / 32,
    letterSpacing: 1,
    color: AppColors.black,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w400,
    height: 36 / 28,
    letterSpacing: 0.5,
    color: AppColors.black,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 32 / 24,
    letterSpacing: 0.5,
    color: AppColors.black,
  );

  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 28 / 22,
    letterSpacing: 0.5,
    color: AppColors.black,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    letterSpacing: 0.5,
    color: AppColors.black,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    letterSpacing: 0.5,
    color: AppColors.black,
  );

  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 24 / 16,
    letterSpacing: 0.5,
    color: AppColors.black,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
    letterSpacing: 0.25,
    color: AppColors.black,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
    letterSpacing: 0.4,
    color: AppColors.black,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    letterSpacing: 0,
    color: AppColors.black,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    letterSpacing: 0,
    color: AppColors.black,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    letterSpacing: 0,
    color: AppColors.black,
  );
}

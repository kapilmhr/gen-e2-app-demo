import 'package:flutter/material.dart';

/// Les Mills design system — colour palette.
///
/// This is the ONLY file allowed to contain `Color(0xFF…)` literals.
/// Every value maps to a named token in the design system token reference
/// (`.github/skills/les-mills-design-system/references/tokens.md`).
///
/// These constants define the palette and are used to assemble [ThemeData].
/// In widget code, read colours through `Theme.of(context).colorScheme.*`
/// for any token that has a ColorScheme slot. Use these constants directly
/// only for tokens with no ColorScheme slot (status, Sunset accents/gradients,
/// beiges, tinted neutral blues, darkestBlue).
abstract final class AppColors {
  AppColors._();

  // Neutrals — surfaces, text, borders
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color offWhite = Color(0xFFF8F9F9);
  static const Color darkGrey = Color(0xFF505151);
  static const Color grey = Color(0xFFDEDEDE);
  static const Color lightGrey = Color(0xFFE7E6EC);
  static const Color neutralLightBlue = Color(0xFFF5F9FE);
  static const Color neutralBlue = Color(0xFFE8F3FA);
  static const Color lightBeige = Color(0xFFF3F0E6);
  static const Color beige = Color(0xFFEBE5D5);
  static const Color darkBeige = Color(0xFFD1C9B8);

  // Sunset — accents & gradients only, used sparingly
  static const Color darkestBlue = Color(0xFF002B4D);
  static const Color secondaryBlue = Color(0xFF4D90D7);
  static const Color blue = Color(0xFF8EB4CB);
  static const Color lightBlue = Color(0xFF9ECCEE);
  static const Color lightestBlue = Color(0xFFBED0DA);
  static const Color darkOrange = Color(0xFFFF804A);
  static const Color lightOrange = Color(0xFFFCA53B);
  static const Color darkestBrown = Color(0xFF4E3834);
  static const Color darkBrown = Color(0xFFA9542F);
  static const Color brown = Color(0xFFD0A47D);
  static const Color lightBrown = Color(0xFFF1D39F);
  static const Color lightestBrown = Color(0xFFF4EAD0);

  // Status — feedback
  static const Color error = Color(0xFFFC4F60);
  static const Color success = Color(0xFF6BC163);

  // Scrims — dark overlays placed over imagery so foreground text/controls
  // keep sufficient contrast. No ColorScheme slot, so used directly.
  static const Color scrimLight = Color(0x1A000000); // ~10% black
  static const Color scrimMedium = Color(0x33000000); // ~20% black
}

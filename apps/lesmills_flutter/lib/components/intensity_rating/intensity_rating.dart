import 'package:flutter/material.dart';

import '../../l10n/app_strings.dart';
import '../../theme/app_spacing.dart';

/// Displays a workout's intensity as a row of filled / outlined droplet icons.
///
/// Pure-display atom: renders [level] filled droplets out of [max]. The whole
/// row is exposed to assistive tech as a single labelled value; the individual
/// icons are decorative.
class IntensityRating extends StatelessWidget {
  const IntensityRating({
    super.key,
    required this.level,
    this.max = 5,
    this.color,
  }) : assert(level >= 0 && level <= max, 'level must be between 0 and max');

  /// Number of filled droplets.
  final int level;

  /// Total number of droplets in the scale.
  final int max;

  /// Droplet colour. Defaults to the theme's on-surface colour; pass a light
  /// colour when rendered over a dark image (e.g. on a class card).
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dropletColor = color ?? Theme.of(context).colorScheme.onSurface;

    return Semantics(
      label: AppStrings.a11yIntensity,
      value: AppStrings.a11yIntensityValue(level, max),
      child: ExcludeSemantics(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.s2,
          children: [
            for (var i = 0; i < max; i++)
              Icon(
                i < level ? Icons.water_drop : Icons.water_drop_outlined,
                size: 16,
                color: dropletColor,
              ),
          ],
        ),
      ),
    );
  }
}

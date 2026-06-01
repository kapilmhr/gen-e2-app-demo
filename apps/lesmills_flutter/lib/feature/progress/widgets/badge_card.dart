import 'package:flutter/material.dart';

import '../../../l10n/app_strings.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../progress_model.dart';
import 'achievement_badge.dart';

/// An earned badge presented as an emblem with a caption beneath it.
///
/// Composes [AchievementBadge]; reports taps via [onTap].
class BadgeCard extends StatelessWidget {
  const BadgeCard({super.key, required this.model, this.onTap});

  final AchievementBadgeModel model;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      button: onTap != null,
      label: AppStrings.a11yBadgeEarned(model.label),
      child: ExcludeSemantics(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.s2),
          child: SizedBox(
            width: 110,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s1,
                vertical: AppSpacing.s2,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AchievementBadge(
                    emblem: model.emblem,
                    colour: model.colour,
                  ),
                  const SizedBox(height: AppSpacing.s2),
                  Text(
                    model.label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: AppColors.darkGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

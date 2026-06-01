import 'package:flutter/material.dart';

import '../../../l10n/app_strings.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../progress_model.dart';
import 'achievement_badge.dart';

/// A white card showing the next badge the member can unlock, with a progress
/// bar and a "current/total" caption.
///
/// Composes a muted [AchievementBadge]; pure-display.
class NextToUnlockCard extends StatelessWidget {
  const NextToUnlockCard({super.key, required this.badge});

  final NextBadge badge;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      container: true,
      label: AppStrings.a11yNextToUnlock(
        badge.label,
        badge.current,
        badge.total,
      ),
      child: ExcludeSemantics(
        child: Material(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSpacing.s4),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s5,
              vertical: AppSpacing.s4,
            ),
            child: Row(
              children: [
                Opacity(
                  opacity: 0.4,
                  child: AchievementBadge(
                    emblem: badge.emblem,
                    colour: BadgeColour.locked,
                    size: const Size(64, 73),
                    emblemStyle: theme.textTheme.labelSmall?.copyWith(
                      color: AppColors.white,
                      fontSize: 8,
                      height: 1.1,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.s5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppStrings.progressNextToUnlock.toUpperCase(),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: AppColors.darkGrey,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s2),
                      Text(
                        badge.label.toUpperCase(),
                        style: theme.textTheme.labelLarge,
                      ),
                      const SizedBox(height: AppSpacing.s2),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppSpacing.s4),
                        child: LinearProgressIndicator(
                          value: badge.fraction,
                          minHeight: 4,
                          backgroundColor: AppColors.lightGrey,
                          color: AppColors.secondaryBlue,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s2),
                      Text(
                        AppStrings.progressClubVisits(
                          badge.current,
                          badge.total,
                        ),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

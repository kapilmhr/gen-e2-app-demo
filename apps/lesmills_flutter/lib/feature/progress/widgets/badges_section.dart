import 'package:flutter/material.dart';

import '../../../l10n/app_strings.dart';
import '../../../theme/app_spacing.dart';
import '../progress_model.dart';
import 'badge_card.dart';
import 'next_to_unlock_card.dart';

/// The "Badges earned" section: a heading with a "View all" action, a
/// horizontally scrollable row of earned [BadgeCard]s, and a
/// [NextToUnlockCard].
class BadgesSection extends StatelessWidget {
  const BadgesSection({
    super.key,
    required this.badges,
    required this.nextToUnlock,
    this.onViewAll,
    this.onBadgeTap,
  });

  final List<AchievementBadgeModel> badges;
  final NextBadge nextToUnlock;
  final VoidCallback? onViewAll;
  final ValueChanged<AchievementBadgeModel>? onBadgeTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Semantics(
                  header: true,
                  child: Text(
                    AppStrings.progressBadgesTitle.toUpperCase(),
                    style: theme.textTheme.titleLarge,
                  ),
                ),
              ),
              TextButton(
                onPressed: onViewAll,
                style: TextButton.styleFrom(
                  textStyle: theme.textTheme.labelMedium,
                ),
                child: Text(AppStrings.progressViewAll),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s4),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
            itemCount: badges.length,
            separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.s2),
            itemBuilder: (context, index) {
              final badge = badges[index];
              return BadgeCard(
                model: badge,
                onTap:
                    onBadgeTap == null ? null : () => onBadgeTap!(badge),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.s4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
          child: NextToUnlockCard(badge: nextToUnlock),
        ),
      ],
    );
  }
}

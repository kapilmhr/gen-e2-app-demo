import 'package:flutter/material.dart';

import '../../../components/content_card/content_card.dart';
import '../../../components/content_card/content_card_model.dart';
import '../../../components/section_header/section_header.dart';
import '../../../l10n/app_strings.dart';
import '../../../theme/app_spacing.dart';

/// The "Workout tips" section: a heading and a horizontally scrolling carousel
/// of [ContentCard]s.
class WorkoutTipsSection extends StatelessWidget {
  const WorkoutTipsSection({
    super.key,
    required this.tips,
    this.onTipTap,
  });

  final List<ContentCardModel> tips;
  final ValueChanged<ContentCardModel>? onTipTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.s5),
          child: SectionHeader(title: AppStrings.progressTipsTitle),
        ),
        const SizedBox(height: AppSpacing.s5),
        SizedBox(
          height: 260,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
            itemCount: tips.length,
            separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.s4),
            itemBuilder: (context, index) {
              final tip = tips[index];
              return ContentCard(
                model: tip,
                onTap: onTipTap == null ? null : () => onTipTap!(tip),
              );
            },
          ),
        ),
      ],
    );
  }
}

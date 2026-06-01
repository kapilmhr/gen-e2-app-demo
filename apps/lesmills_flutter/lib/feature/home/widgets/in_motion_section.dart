import 'package:flutter/material.dart';

import '../../../components/content_card/content_card.dart';
import '../../../components/content_card/content_card_model.dart';
import '../../../components/section_header/section_header.dart';
import '../../../l10n/app_strings.dart';
import '../../../theme/app_spacing.dart';

/// "In Motion" editorial section: a header followed by a horizontally
/// scrolling carousel of [ContentCard]s.
class InMotionSection extends StatelessWidget {
  const InMotionSection({
    super.key,
    required this.items,
    this.onCardTap,
    this.cardHeight = 260,
  });

  final List<ContentCardModel> items;
  final ValueChanged<ContentCardModel>? onCardTap;
  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.s5),
          child: SectionHeader(title: AppStrings.inMotionTitle),
        ),
        const SizedBox(height: AppSpacing.s4),
        SizedBox(
          height: cardHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding:
                const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.s4),
            itemBuilder: (context, index) {
              final item = items[index];
              return ContentCard(
                model: item,
                onTap: onCardTap == null ? null : () => onCardTap!(item),
              );
            },
          ),
        ),
      ],
    );
  }
}

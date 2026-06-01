import 'package:flutter/material.dart';

import '../../../components/content_card/content_card.dart';
import '../../../components/content_card/content_card_model.dart';
import '../../../l10n/app_strings.dart';
import '../../../theme/app_spacing.dart';

/// A labelled, horizontally scrollable row of [ContentCard]s used by the
/// "Les Mills At Home" section (New In / Classes / Collections).
///
/// Degrades independently: when [hasError] is true (or [items] is empty) the
/// carousel renders an inline placeholder instead of cards, so one failed
/// section never blanks the rest of the page.
class DiscoveryCarouselView extends StatelessWidget {
  const DiscoveryCarouselView({
    super.key,
    required this.label,
    required this.items,
    this.onItemTap,
    this.hasError = false,
    this.height = 248,
  });

  final String label;
  final List<ContentCardModel> items;
  final ValueChanged<ContentCardModel>? onItemTap;

  /// When true the carousel shows an inline error placeholder.
  final bool hasError;

  /// Fixed carousel height; sized so the tallest card (image + two text lines)
  /// lays out without overflow.
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
          child: Semantics(
            header: true,
            child: Text(
              label.toUpperCase(),
              style: theme.textTheme.titleMedium,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.s4),
        if (hasError || items.isEmpty)
          _CarouselPlaceholder(
            message: hasError
                ? AppStrings.exploreCarouselError
                : AppStrings.exploreCarouselEmpty,
          )
        else
          SizedBox(
            height: height,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.s4),
              itemBuilder: (context, index) {
                final item = items[index];
                return ContentCard(
                  model: item,
                  onTap: onItemTap == null ? null : () => onItemTap!(item),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _CarouselPlaceholder extends StatelessWidget {
  const _CarouselPlaceholder({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s5,
        vertical: AppSpacing.s4,
      ),
      child: Text(
        message,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

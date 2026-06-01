import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';

/// Displays an uppercase section title with an optional supporting description.
///
/// Pure-display atom used to introduce each home section (Activity summary,
/// In Motion, Explore Group Fitness).
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.description,
  });

  /// Section title. Rendered in uppercase per the brand type treatment.
  final String title;

  /// Optional supporting copy shown beneath the title.
  final String? description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.s2,
      children: [
        Semantics(
          header: true,
          child: Text(
            title.toUpperCase(),
            style: theme.textTheme.titleLarge,
          ),
        ),
        if (description != null)
          Text(
            description!,
            style: theme.textTheme.bodyLarge,
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../components/class_card/class_card.dart';
import '../../../components/class_card/class_card_model.dart';
import '../../../components/section_header/section_header.dart';
import '../../../l10n/app_strings.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';

/// Explore's "Group fitness" section: a header with description, a horizontally
/// scrolling carousel of [ClassCard]s, and a trailing centred tile that links
/// to the full timetable.
class ExploreGroupFitnessSection extends StatelessWidget {
  const ExploreGroupFitnessSection({
    super.key,
    required this.classes,
    this.onClassTap,
    this.onTimetable,
    this.cardHeight = 300,
  });

  final List<ClassCardModel> classes;
  final ValueChanged<ClassCardModel>? onClassTap;
  final VoidCallback? onTimetable;
  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
          child: SectionHeader(
            title: AppStrings.exploreGroupFitnessTitle,
            description: AppStrings.exploreGroupFitnessDescription,
          ),
        ),
        const SizedBox(height: AppSpacing.s4),
        SizedBox(
          height: cardHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
            itemCount: classes.length + 1,
            separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.s4),
            itemBuilder: (context, index) {
              if (index == classes.length) {
                return _TimetableTile(onPressed: onTimetable);
              }
              final item = classes[index];
              return ClassCard(
                model: item,
                onTap: onClassTap == null ? null : () => onClassTap!(item),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TimetableTile extends StatelessWidget {
  const _TimetableTile({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      button: onPressed != null,
      label: AppStrings.exploreTimetableCta,
      child: ExcludeSemantics(
        child: SizedBox(
          width: 240,
          child: Material(
            color: AppColors.neutralBlue,
            borderRadius: BorderRadius.circular(AppSpacing.s2),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onPressed,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.s5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.exploreTimetableCta.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.s4),
                    Icon(
                      Directionality.of(context) == TextDirection.rtl
                          ? Icons.arrow_back
                          : Icons.arrow_forward,
                      color: theme.colorScheme.onSurface,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

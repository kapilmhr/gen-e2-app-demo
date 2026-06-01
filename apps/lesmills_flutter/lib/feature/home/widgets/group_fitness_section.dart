import 'package:flutter/material.dart';

import '../../../components/class_card/class_card.dart';
import '../../../components/class_card/class_card_model.dart';
import '../../../components/section_header/section_header.dart';
import '../../../l10n/app_strings.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';

/// "Explore Group Fitness" section: a header with description, a horizontally
/// scrolling carousel of [ClassCard]s, and a trailing tile that links to the
/// full timetable.
class GroupFitnessSection extends StatelessWidget {
  const GroupFitnessSection({
    super.key,
    required this.description,
    required this.classes,
    this.onClassTap,
    this.onTimetable,
    this.cardHeight = 300,
  });

  final String description;
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
            title: AppStrings.groupFitnessTitle,
            description: description,
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
                return _TimetableTile(
                  width: 200,
                  onPressed: onTimetable,
                );
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
  const _TimetableTile({required this.width, this.onPressed});

  final double width;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      button: onPressed != null,
      label: AppStrings.groupFitnessTimetableCta,
      child: ExcludeSemantics(
        child: SizedBox(
          width: width,
          child: Material(
            color: AppColors.neutralBlue,
            borderRadius: BorderRadius.circular(AppSpacing.s2),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onPressed,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.s4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      AppStrings.groupFitnessTimetableCta,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.s3),
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

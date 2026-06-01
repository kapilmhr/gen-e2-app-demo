import 'package:flutter/material.dart';

import '../../../l10n/app_strings.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../timetable_model.dart';

/// Horizontal time-of-day filter — a row of pill chips with one selected.
class DayPartFilter extends StatelessWidget {
  const DayPartFilter({
    super.key,
    required this.selected,
    this.onSelected,
  });

  final DayPart selected;
  final ValueChanged<DayPart>? onSelected;

  static const Map<DayPart, String> _labels = {
    DayPart.morning: AppStrings.timetableMorning,
    DayPart.lunch: AppStrings.timetableLunch,
    DayPart.afternoon: AppStrings.timetableAfternoon,
    DayPart.night: AppStrings.timetableNight,
  };

  @override
  Widget build(BuildContext context) {
    // Keep the 32px chip row at the default text size, but let it grow with
    // Dynamic Type so the chip labels never clip at large text scales.
    final height = MediaQuery.textScalerOf(context).scale(32).clamp(32.0, 80.0);
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4),
        itemCount: DayPart.values.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.s2),
        itemBuilder: (context, index) {
          final part = DayPart.values[index];
          return _Chip(
            label: _labels[part]!,
            isSelected: part == selected,
            onTap: onSelected == null ? null : () => onSelected!(part),
          );
        },
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final background = isSelected ? AppColors.darkOrange : AppColors.white;
    final foreground = isSelected ? AppColors.white : AppColors.darkGrey;

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: Material(
        color: background,
        shape: const StadiumBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s4,
              vertical: AppSpacing.s2,
            ),
            child: Center(
              widthFactor: 1,
              child: ExcludeSemantics(
                child: Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: foreground,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

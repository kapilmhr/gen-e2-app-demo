import 'package:flutter/material.dart';

import '../../../l10n/app_strings.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../timetable_model.dart';

/// Horizontal strip of selectable day pills shown on the gradient header.
///
/// The selected day is solid white; the rest use a translucent white fill so
/// they read against the gradient.
class DateSelector extends StatelessWidget {
  const DateSelector({
    super.key,
    required this.days,
    this.onDaySelected,
  });

  final List<TimetableDay> days;
  final ValueChanged<TimetableDay>? onDaySelected;

  @override
  Widget build(BuildContext context) {
    // Grow the date rail with Dynamic Type so the weekday/number text scales up
    // (instead of being shrunk by the FittedBox) at large text sizes.
    final scale = MediaQuery.textScalerOf(context).scale(1).clamp(1.0, 1.6);
    return SizedBox(
      height: 84 * scale,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: days.length,
        separatorBuilder: (_, _) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final day = days[index];
          return _DayPill(
            day: day,
            onTap: onDaySelected == null ? null : () => onDaySelected!(day),
          );
        },
      ),
    );
  }
}

class _DayPill extends StatelessWidget {
  const _DayPill({required this.day, this.onTap});

  final TimetableDay day;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selected = day.isSelected;
    final weekdayColor = selected ? AppColors.darkGrey : AppColors.white;
    final numberColor = selected ? AppColors.black : AppColors.white;
    final scale = MediaQuery.textScalerOf(context).scale(1).clamp(1.0, 1.6);

    return Semantics(
      button: true,
      selected: selected,
      label: AppStrings.a11yDateOption(day.weekday, day.dayNumber, selected),
      child: Material(
        color: selected
            ? AppColors.white
            : AppColors.white.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: 56 * scale,
            child: Center(
              child: ExcludeSemantics(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        day.weekday,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: weekdayColor,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s1),
                      Text(
                        '${day.dayNumber}',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: numberColor,
                        ),
                      ),
                    ],
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

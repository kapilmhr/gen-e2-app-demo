import 'package:flutter/material.dart';

import '../../../l10n/app_strings.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../progress_model.dart';

/// The "4 week summary" streak calendar: a date range, weekday header, four
/// week-rows (each with workout discs, an optional streak highlight and an
/// attendance marker) and a footer summarising last week and the current
/// streak.
///
/// The grid is decorative for assistive tech — a per-week text summary is
/// exposed instead so screen-reader users get meaning without reading every
/// empty cell.
class StreakCalendarCard extends StatelessWidget {
  const StreakCalendarCard({
    super.key,
    required this.dateRange,
    required this.weeks,
    required this.lastWeekValue,
    required this.currentStreakValue,
  });

  final String dateRange;
  final List<StreakWeek> weeks;
  final String lastWeekValue;
  final String currentStreakValue;

  static const List<String> _weekdayLabels = ['M', 'Tu', 'W', 'Th', 'F', 'Sa', 'Su'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Calendar block.
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          padding: const EdgeInsets.all(AppSpacing.s4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dateRange,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.darkGrey,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: AppSpacing.s4),
              _WeekdayHeader(labels: _weekdayLabels),
              const SizedBox(height: AppSpacing.s2),
              for (final week in weeks)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.s2),
                  child: _WeekRow(week: week),
                ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        // Footer block.
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          padding: const EdgeInsets.all(AppSpacing.s4),
          child: Row(
            children: [
              Expanded(
                child: _FooterStat(
                  label: AppStrings.progressLastWeek,
                  value: lastWeekValue,
                ),
              ),
              Expanded(
                child: _FooterStat(
                  label: AppStrings.progressCurrentStreak,
                  value: currentStreakValue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WeekdayHeader extends StatelessWidget {
  const _WeekdayHeader({required this.labels});

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ExcludeSemantics(
      child: Row(
        children: [
          for (final label in labels)
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.darkGrey,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _WeekRow extends StatelessWidget {
  const _WeekRow({required this.week});

  final StreakWeek week;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: AppStrings.a11yWeekStreak(week.rangeLabel, week.workoutCount),
      child: ExcludeSemantics(
        child: SizedBox(
          height: 32,
          child: Row(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (week.hasStreak)
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors.neutralBlue,
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                    Row(
                      children: [
                        for (final day in week.days)
                          Expanded(child: _DayCell(day: day)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.s2),
              _StatusIcon(status: week.status),
            ],
          ),
        ),
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({required this.day});

  final CalendarDay day;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final base = theme.textTheme.titleMedium;

    return switch (day.state) {
      CalendarDayState.workout => _Disc(
          fill: AppColors.secondaryBlue,
          child: Text(
            '${day.day}',
            style: base?.copyWith(color: AppColors.white),
          ),
        ),
      CalendarDayState.today => _Disc(
          border: AppColors.secondaryBlue,
          child: Text(
            '${day.day}',
            style: theme.textTheme.labelMedium?.copyWith(
              color: AppColors.darkGrey,
            ),
          ),
        ),
      CalendarDayState.past => _PlainDay(
          '${day.day}',
          color: AppColors.darkGrey,
        ),
      CalendarDayState.future => _PlainDay(
          '${day.day}',
          color: AppColors.grey,
        ),
    };
  }
}

class _Disc extends StatelessWidget {
  const _Disc({required this.child, this.fill, this.border});

  final Widget child;
  final Color? fill;
  final Color? border;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: fill,
          shape: BoxShape.circle,
          border: border == null ? null : Border.all(color: border!, width: 1.5),
        ),
        child: child,
      ),
    );
  }
}

class _PlainDay extends StatelessWidget {
  const _PlainDay(this.text, {required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color),
      ),
    );
  }
}

class _StatusIcon extends StatelessWidget {
  const _StatusIcon({required this.status});

  final WeekStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case WeekStatus.attended:
        return Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.secondaryBlue,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, size: 16, color: AppColors.white),
        );
      case WeekStatus.upcoming:
        return Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.grey, width: 1.5),
          ),
        );
    }
  }
}

class _FooterStat extends StatelessWidget {
  const _FooterStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.darkGrey,
          ),
        ),
        const SizedBox(height: AppSpacing.s1),
        Text(
          value.toUpperCase(),
          style: theme.textTheme.bodyMedium?.copyWith(letterSpacing: 0.5),
        ),
      ],
    );
  }
}

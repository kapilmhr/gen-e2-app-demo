import 'package:flutter/material.dart';

import '../../../components/section_header/section_header.dart';
import '../../../l10n/app_strings.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../home_model.dart';

/// The weekly activity summary: a section header and a card. This week is
/// shown as a calendar strip (weekday labels + day markers with a streak
/// band); last week is summarised as a workout count only. A call-to-action
/// links to class bookings.
class ActivitySummaryCard extends StatelessWidget {
  const ActivitySummaryCard({
    super.key,
    required this.message,
    required this.thisWeek,
    required this.lastWeek,
    this.onViewBookings,
  });

  final String message;
  final WeeklyActivity thisWeek;
  final WeeklyActivity lastWeek;
  final VoidCallback? onViewBookings;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: AppStrings.activitySummaryTitle,
          description: message,
        ),
        const SizedBox(height: AppSpacing.s4),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.s4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ThisWeekCalendar(week: thisWeek),
                const SizedBox(height: AppSpacing.s4),
                const Divider(height: 1),
                const SizedBox(height: AppSpacing.s4),
                _LastWeekSummary(week: lastWeek),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.s4),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: onViewBookings,
            child: Text(
              AppStrings.viewClassBookings.toUpperCase(),
            ),
          ),
        ),
      ],
    );
  }
}

class _ThisWeekCalendar extends StatelessWidget {
  const _ThisWeekCalendar({required this.week});

  final WeeklyActivity week;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // The streak band runs from the first day up to (and including) today.
    // If there is no "today" in the data, fall back to the last elapsed day.
    final todayIndex =
        week.days.indexWhere((day) => day.state == DayState.today);
    final streakEnd = todayIndex >= 0
        ? todayIndex
        : week.days.lastIndexWhere((day) => day.state != DayState.future);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                week.label.toUpperCase(),
                style: theme.textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: AppSpacing.s3),
            Text(
              AppStrings.a11yWeeklyWorkouts(week.workoutCount).toUpperCase(),
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s3),
        Row(
          children: [
            for (final day in week.days)
              Expanded(
                child: Text(
                  day.weekdayLabel,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: day.state == DayState.today
                        ? colorScheme.onSurface
                        : colorScheme.onSurfaceVariant,
                    fontWeight:
                        day.state == DayState.today ? FontWeight.w700 : null,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.s2),
        Row(
          children: [
            for (var i = 0; i < week.days.length; i++)
              Expanded(
                child: _DayCell(
                  day: week.days[i],
                  inStreak: streakEnd >= 0 && i <= streakEnd,
                  isStreakStart: i == 0 && streakEnd >= 0,
                  isStreakEnd: i == streakEnd,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

/// Last week is summarised as a label and a workout count only — no calendar.
class _LastWeekSummary extends StatelessWidget {
  const _LastWeekSummary({required this.week});

  final WeeklyActivity week;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          week.label,
          style: theme.textTheme.titleSmall
              ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppSpacing.s1),
        Text(
          AppStrings.a11yWeeklyWorkouts(week.workoutCount).toUpperCase(),
          style: theme.textTheme.titleMedium,
        ),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.inStreak,
    required this.isStreakStart,
    required this.isStreakEnd,
  });

  final DayActivity day;
  final bool inStreak;
  final bool isStreakStart;
  final bool isStreakEnd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isToday = day.state == DayState.today;
    final isWorkout = day.state == DayState.workout;
    final isFuture = day.state == DayState.future;

    // Workout days get a filled accent circle; today is an outlined circle;
    // other days show a bare number.
    final Widget marker;
    if (isWorkout) {
      marker = _marker(
        color: AppColors.secondaryBlue,
        child: Text(
          '${day.dayNumber}',
          style: theme.textTheme.labelMedium
              ?.copyWith(color: colorScheme.onPrimary),
        ),
      );
    } else if (isToday) {
      marker = _marker(
        color: colorScheme.surface,
        border: Border.all(color: AppColors.secondaryBlue, width: 2),
        child: Text(
          '${day.dayNumber}',
          style: theme.textTheme.labelMedium?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    } else {
      marker = Text(
        '${day.dayNumber}',
        style: theme.textTheme.labelMedium?.copyWith(
          color: isFuture ? colorScheme.onSurfaceVariant : colorScheme.onSurface,
        ),
      );
    }

    return Semantics(
      label: '${day.weekdayLabel} ${day.dayNumber}',
      value: switch (day.state) {
        DayState.workout => 'Workout completed',
        DayState.today => 'Today',
        DayState.future => 'Upcoming',
        DayState.past => 'No workout',
      },
      child: ExcludeSemantics(
        child: Container(
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: inStreak ? AppColors.neutralBlue : Colors.transparent,
            borderRadius: BorderRadius.horizontal(
              left: isStreakStart ? const Radius.circular(16) : Radius.zero,
              right: isStreakEnd ? const Radius.circular(16) : Radius.zero,
            ),
          ),
          child: marker,
        ),
      ),
    );
  }

  Widget _marker({
    required Color color,
    Border? border,
    required Widget child,
  }) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: border,
      ),
      child: child,
    );
  }
}

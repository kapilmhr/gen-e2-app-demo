import 'package:flutter/foundation.dart';

import '../../components/content_card/content_card_model.dart';

/// Visual state of a single day cell in the streak calendar.
///
/// * [workout] — a completed workout: a filled accent disc with a white number.
/// * [today] — the current day: an outlined disc with an emphasised number.
/// * [past] — an ordinary elapsed day with no workout.
/// * [future] — an upcoming day, rendered muted.
enum CalendarDayState { workout, today, past, future }

/// Whether a week's streak goal was met.
///
/// * [attended] — the streak goal was reached (shows a tick).
/// * [upcoming] — the goal was not (yet) reached (shows an empty marker).
enum WeekStatus { attended, upcoming }

/// Colour treatment for an [AchievementBadge]. Mapped to concrete palette
/// tokens in the widget so model/stub data stays free of raw colours.
enum BadgeColour { dark, blue, brown, orange, locked }

/// A single day in the streak calendar.
@immutable
class CalendarDay {
  const CalendarDay({required this.day, required this.state});

  /// Day of month.
  final int day;

  final CalendarDayState state;

  @override
  bool operator ==(Object other) =>
      other is CalendarDay && other.day == day && other.state == state;

  @override
  int get hashCode => Object.hash(day, state);
}

/// One week-row in the streak calendar: seven days, an optional streak
/// highlight, and the week's attendance status.
@immutable
class StreakWeek {
  const StreakWeek({
    required this.rangeLabel,
    required this.days,
    required this.workoutCount,
    required this.hasStreak,
    required this.status,
  });

  /// Human-readable range used for the accessibility summary (e.g. "5 – 11").
  final String rangeLabel;

  /// Exactly seven day cells, Monday-first.
  final List<CalendarDay> days;

  /// Number of completed workouts in the week.
  final int workoutCount;

  /// Whether the streak highlight pill is shown behind the row.
  final bool hasStreak;

  final WeekStatus status;

  @override
  bool operator ==(Object other) =>
      other is StreakWeek &&
      other.rangeLabel == rangeLabel &&
      listEquals(other.days, days) &&
      other.workoutCount == workoutCount &&
      other.hasStreak == hasStreak &&
      other.status == status;

  @override
  int get hashCode => Object.hash(
        rangeLabel,
        Object.hashAll(days),
        workoutCount,
        hasStreak,
        status,
      );
}

/// An earned achievement badge.
@immutable
class AchievementBadgeModel {
  const AchievementBadgeModel({
    required this.id,
    required this.label,
    required this.emblem,
    required this.colour,
  });

  /// Stable identifier for keys and analytics.
  final String id;

  /// Caption shown beneath the badge (e.g. "Class Explorer").
  final String label;

  /// Short text rendered inside the emblem (e.g. "CLASS\nEXPLORER").
  final String emblem;

  final BadgeColour colour;

  @override
  bool operator ==(Object other) =>
      other is AchievementBadgeModel &&
      other.id == id &&
      other.label == label &&
      other.emblem == emblem &&
      other.colour == colour;

  @override
  int get hashCode => Object.hash(id, label, emblem, colour);
}

/// The next badge the member can unlock, with progress toward it.
@immutable
class NextBadge {
  const NextBadge({
    required this.label,
    required this.emblem,
    required this.current,
    required this.total,
  });

  /// Badge name (e.g. "Half Century").
  final String label;

  /// Short text rendered inside the locked emblem.
  final String emblem;

  /// Visits completed so far.
  final int current;

  /// Visits required to unlock.
  final int total;

  /// Progress in the 0.0–1.0 range, clamped for safety.
  double get fraction => total == 0 ? 0 : (current / total).clamp(0.0, 1.0);

  @override
  bool operator ==(Object other) =>
      other is NextBadge &&
      other.label == label &&
      other.emblem == emblem &&
      other.current == current &&
      other.total == total;

  @override
  int get hashCode => Object.hash(label, emblem, current, total);
}

/// All data required to render the loaded Progress screen.
@immutable
class ProgressData {
  const ProgressData({
    required this.dateRange,
    required this.weeks,
    required this.lastWeekValue,
    required this.currentStreakValue,
    required this.badges,
    required this.nextToUnlock,
    required this.tips,
    this.headerImageAsset,
    this.headerImageUrl,
  });

  /// Calendar range label (e.g. "29 JUL - 25 AUG").
  final String dateRange;

  /// Four week-rows, oldest first.
  final List<StreakWeek> weeks;

  /// Last week's workout count, e.g. "3 workouts".
  final String lastWeekValue;

  /// Current streak length, e.g. "2 weeks".
  final String currentStreakValue;

  /// Earned badges, in display order.
  final List<AchievementBadgeModel> badges;

  final NextBadge nextToUnlock;

  /// Workout-tip carousel cards.
  final List<ContentCardModel> tips;

  final String? headerImageAsset;
  final String? headerImageUrl;

  @override
  bool operator ==(Object other) =>
      other is ProgressData &&
      other.dateRange == dateRange &&
      listEquals(other.weeks, weeks) &&
      other.lastWeekValue == lastWeekValue &&
      other.currentStreakValue == currentStreakValue &&
      listEquals(other.badges, badges) &&
      other.nextToUnlock == nextToUnlock &&
      listEquals(other.tips, tips) &&
      other.headerImageAsset == headerImageAsset &&
      other.headerImageUrl == headerImageUrl;

  @override
  int get hashCode => Object.hash(
        dateRange,
        Object.hashAll(weeks),
        lastWeekValue,
        currentStreakValue,
        Object.hashAll(badges),
        nextToUnlock,
        Object.hashAll(tips),
        headerImageAsset,
        headerImageUrl,
      );
}

/// Exhaustive state for the Progress screen.
sealed class ProgressState {
  const ProgressState();
}

/// Before any load has been requested.
class ProgressIdle extends ProgressState {
  const ProgressIdle();
}

/// A load is in flight.
class ProgressLoading extends ProgressState {
  const ProgressLoading();
}

/// Loaded with data to display.
class ProgressLoaded extends ProgressState {
  const ProgressLoaded(this.data);

  final ProgressData data;
}

/// Loaded successfully but the member has no progress yet.
class ProgressEmpty extends ProgressState {
  const ProgressEmpty();
}

/// The load failed.
class ProgressError extends ProgressState {
  const ProgressError(this.message);

  final String message;
}

import 'package:flutter/foundation.dart';

import '../../components/class_card/class_card_model.dart';
import '../../components/content_card/content_card_model.dart';
import '../../components/link_card/link_card_model.dart';

/// Whether a given day in the activity strip is a future day, a completed
/// workout day, today, or an ordinary past day.
enum DayState { past, today, workout, future }

/// A single day cell in the weekly activity strip.
@immutable
class DayActivity {
  const DayActivity({
    required this.weekdayLabel,
    required this.dayNumber,
    required this.state,
  });

  /// Short weekday label (e.g. "M", "Tu").
  final String weekdayLabel;

  /// Day of month.
  final int dayNumber;

  final DayState state;

  @override
  bool operator ==(Object other) =>
      other is DayActivity &&
      other.weekdayLabel == weekdayLabel &&
      other.dayNumber == dayNumber &&
      other.state == state;

  @override
  int get hashCode => Object.hash(weekdayLabel, dayNumber, state);
}

/// A week's worth of activity: a label, a workout count and the per-day strip.
@immutable
class WeeklyActivity {
  const WeeklyActivity({
    required this.label,
    required this.workoutCount,
    required this.days,
  });

  /// e.g. "This week" / "Last week".
  final String label;
  final int workoutCount;
  final List<DayActivity> days;

  @override
  bool operator ==(Object other) =>
      other is WeeklyActivity &&
      other.label == label &&
      other.workoutCount == workoutCount &&
      listEquals(other.days, days);

  @override
  int get hashCode => Object.hash(label, workoutCount, Object.hashAll(days));
}

/// All data needed to render the loaded Home screen.
@immutable
class HomeData {
  const HomeData({
    required this.memberName,
    required this.activityMessage,
    required this.thisWeek,
    required this.lastWeek,
    required this.challenge,
    required this.inMotion,
    required this.referFriend,
    required this.classes,
    required this.groupFitnessDescription,
    this.heroImageAsset,
    this.heroImageUrl,
  });

  final String memberName;
  final String activityMessage;
  final WeeklyActivity thisWeek;
  final WeeklyActivity lastWeek;
  final LinkCardModel challenge;
  final List<ContentCardModel> inMotion;
  final LinkCardModel referFriend;
  final List<ClassCardModel> classes;
  final String groupFitnessDescription;
  final String? heroImageAsset;
  final String? heroImageUrl;

  @override
  bool operator ==(Object other) =>
      other is HomeData &&
      other.memberName == memberName &&
      other.activityMessage == activityMessage &&
      other.thisWeek == thisWeek &&
      other.lastWeek == lastWeek &&
      other.challenge == challenge &&
      listEquals(other.inMotion, inMotion) &&
      other.referFriend == referFriend &&
      listEquals(other.classes, classes) &&
      other.groupFitnessDescription == groupFitnessDescription &&
      other.heroImageAsset == heroImageAsset &&
      other.heroImageUrl == heroImageUrl;

  @override
  int get hashCode => Object.hash(
        memberName,
        activityMessage,
        thisWeek,
        lastWeek,
        challenge,
        Object.hashAll(inMotion),
        referFriend,
        Object.hashAll(classes),
        groupFitnessDescription,
        heroImageAsset,
        heroImageUrl,
      );
}

/// Exhaustive state for the Home screen. Consumers must handle every variant.
@immutable
sealed class HomeState {
  const HomeState();
}

/// Nothing requested yet.
class HomeIdle extends HomeState {
  const HomeIdle();
}

/// Data is being fetched — show skeletons.
class HomeLoading extends HomeState {
  const HomeLoading();
}

/// Data loaded successfully.
class HomeLoaded extends HomeState {
  const HomeLoaded(this.data);
  final HomeData data;
}

/// Loaded successfully but there is nothing to show.
class HomeEmpty extends HomeState {
  const HomeEmpty();
}

/// Loading failed.
class HomeError extends HomeState {
  const HomeError(this.message);
  final String message;
}

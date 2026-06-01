import '../../components/content_card/content_card_model.dart';
import 'progress_model.dart';

/// Deterministic, offline sample data for Progress previews and tests.
///
/// Images are real exported Figma assets bundled under assets/images. No
/// `DateTime.now()` / `Random` — the calendar is fixed and mirrors the Figma
/// reference frame.
abstract final class ProgressStubs {
  ProgressStubs._();

  static const String _images = 'assets/images';

  static const StreakWeek _week1 = StreakWeek(
    rangeLabel: '29 Jul – 4 Aug',
    workoutCount: 2,
    hasStreak: false,
    status: WeekStatus.upcoming,
    days: [
      CalendarDay(day: 29, state: CalendarDayState.workout),
      CalendarDay(day: 30, state: CalendarDayState.workout),
      CalendarDay(day: 31, state: CalendarDayState.past),
      CalendarDay(day: 1, state: CalendarDayState.past),
      CalendarDay(day: 2, state: CalendarDayState.past),
      CalendarDay(day: 3, state: CalendarDayState.past),
      CalendarDay(day: 4, state: CalendarDayState.past),
    ],
  );

  static const StreakWeek _week2 = StreakWeek(
    rangeLabel: '5 – 11 Aug',
    workoutCount: 3,
    hasStreak: true,
    status: WeekStatus.attended,
    days: [
      CalendarDay(day: 5, state: CalendarDayState.workout),
      CalendarDay(day: 6, state: CalendarDayState.past),
      CalendarDay(day: 7, state: CalendarDayState.workout),
      CalendarDay(day: 8, state: CalendarDayState.workout),
      CalendarDay(day: 9, state: CalendarDayState.past),
      CalendarDay(day: 10, state: CalendarDayState.past),
      CalendarDay(day: 11, state: CalendarDayState.past),
    ],
  );

  static const StreakWeek _week3 = StreakWeek(
    rangeLabel: '12 – 18 Aug',
    workoutCount: 3,
    hasStreak: true,
    status: WeekStatus.attended,
    days: [
      CalendarDay(day: 12, state: CalendarDayState.workout),
      CalendarDay(day: 13, state: CalendarDayState.past),
      CalendarDay(day: 14, state: CalendarDayState.past),
      CalendarDay(day: 15, state: CalendarDayState.workout),
      CalendarDay(day: 16, state: CalendarDayState.past),
      CalendarDay(day: 17, state: CalendarDayState.workout),
      CalendarDay(day: 18, state: CalendarDayState.past),
    ],
  );

  static const StreakWeek _week4 = StreakWeek(
    rangeLabel: '19 – 25 Aug',
    workoutCount: 0,
    hasStreak: false,
    status: WeekStatus.upcoming,
    days: [
      CalendarDay(day: 19, state: CalendarDayState.today),
      CalendarDay(day: 20, state: CalendarDayState.future),
      CalendarDay(day: 21, state: CalendarDayState.future),
      CalendarDay(day: 22, state: CalendarDayState.future),
      CalendarDay(day: 23, state: CalendarDayState.future),
      CalendarDay(day: 24, state: CalendarDayState.future),
      CalendarDay(day: 25, state: CalendarDayState.future),
    ],
  );

  static const List<AchievementBadgeModel> badges = [
    AchievementBadgeModel(
      id: 'class-explorer',
      label: 'Class Explorer',
      emblem: 'CLASS\nEXPLORER',
      colour: BadgeColour.dark,
    ),
    AchievementBadgeModel(
      id: 'pumped-up',
      label: 'Pumped Up',
      emblem: 'PUMPED UP',
      colour: BadgeColour.blue,
    ),
    AchievementBadgeModel(
      id: 'quick-win',
      label: 'Quick Win',
      emblem: 'QUICK\nWIN',
      colour: BadgeColour.brown,
    ),
    AchievementBadgeModel(
      id: 'class-act',
      label: 'Class Act',
      emblem: 'CLASS\nACT',
      colour: BadgeColour.orange,
    ),
  ];

  static const NextBadge nextToUnlock = NextBadge(
    label: 'Half Century',
    emblem: 'HALF\nCENTURY',
    current: 42,
    total: 50,
  );

  static const List<ContentCardModel> tips = [
    ContentCardModel(
      id: 'improve-strength',
      title: 'Improve strength',
      description:
          'Focus on progressive resistance training, gradually increasing the '
          'weight or resistance.',
      imageAsset: '$_images/tip_improve_strength.png',
    ),
    ContentCardModel(
      id: 'mental-wellbeing',
      title: 'Mental wellbeing',
      description:
          'Prioritise exercise, mindfulness, and maintaining social '
          'connections.',
      imageAsset: '$_images/tip_mental_wellbeing.png',
    ),
  ];

  static const ProgressData loaded = ProgressData(
    dateRange: '29 JUL - 25 AUG',
    weeks: [_week1, _week2, _week3, _week4],
    lastWeekValue: '3 workouts',
    currentStreakValue: '2 weeks',
    badges: badges,
    nextToUnlock: nextToUnlock,
    tips: tips,
    headerImageAsset: '$_images/progress_header.png',
  );

  static const ProgressState loadedState = ProgressLoaded(loaded);
  static const ProgressState loadingState = ProgressLoading();
  static const ProgressState emptyState = ProgressEmpty();
  static const ProgressState errorState =
      ProgressError('We couldn’t load your progress');
}

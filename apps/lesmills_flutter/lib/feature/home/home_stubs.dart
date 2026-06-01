import '../../components/class_card/class_card_model.dart';
import '../../components/content_card/content_card_model.dart';
import '../../components/link_card/link_card_model.dart';
import '../../l10n/app_strings.dart';
import 'home_model.dart';

/// Deterministic, offline sample data for Home previews and tests.
///
/// Image URLs are intentionally null so previews and tests never depend on the
/// network. No `DateTime.now()` / `Random` — the strip is fixed.
abstract final class HomeStubs {
  HomeStubs._();

  /// Bundled photography exported from the Figma Home frame.
  static const String _images = 'assets/images';

  static const WeeklyActivity thisWeek = WeeklyActivity(
    label: 'This week',
    workoutCount: 2,
    days: [
      DayActivity(weekdayLabel: 'M', dayNumber: 15, state: DayState.workout),
      DayActivity(weekdayLabel: 'Tu', dayNumber: 16, state: DayState.past),
      DayActivity(weekdayLabel: 'W', dayNumber: 17, state: DayState.past),
      DayActivity(weekdayLabel: 'Th', dayNumber: 18, state: DayState.workout),
      DayActivity(weekdayLabel: 'F', dayNumber: 19, state: DayState.today),
      DayActivity(weekdayLabel: 'Sa', dayNumber: 20, state: DayState.future),
      DayActivity(weekdayLabel: 'Su', dayNumber: 21, state: DayState.future),
    ],
  );

  static const WeeklyActivity lastWeek = WeeklyActivity(
    label: 'Last week',
    workoutCount: 4,
    days: [
      DayActivity(weekdayLabel: 'M', dayNumber: 8, state: DayState.workout),
      DayActivity(weekdayLabel: 'Tu', dayNumber: 9, state: DayState.past),
      DayActivity(weekdayLabel: 'W', dayNumber: 10, state: DayState.workout),
      DayActivity(weekdayLabel: 'Th', dayNumber: 11, state: DayState.workout),
      DayActivity(weekdayLabel: 'F', dayNumber: 12, state: DayState.past),
      DayActivity(weekdayLabel: 'Sa', dayNumber: 13, state: DayState.workout),
      DayActivity(weekdayLabel: 'Su', dayNumber: 14, state: DayState.past),
    ],
  );

  static const HomeData loaded = HomeData(
    memberName: 'Aprille',
    activityMessage:
        'Just 1 more workout until you hit your goal this week!',
    thisWeek: thisWeek,
    lastWeek: lastWeek,
    heroImageAsset: '$_images/hero.png',
    challenge: LinkCardModel(
      id: 'kickstart-challenge',
      title: '6-week Kickstart Challenge',
      ctaLabel: 'Explore challenge',
      imageAsset: '$_images/challenge.png',
    ),
    inMotion: [
      ContentCardModel(
        id: 'wellness-day',
        title: 'Global wellness day',
        description: 'Come along and celebrate with us at your local club.',
        imageAsset: '$_images/in_motion_wellness.png',
      ),
      ContentCardModel(
        id: 'reo-maori',
        title: 'Gearing up for te wiki o te reo Māori week!',
        description:
            'You might spot a few changes around the club as we celebrate.',
        imageAsset: '$_images/in_motion_reo_maori.png',
      ),
      ContentCardModel(
        id: 'level-up-lunge',
        title: 'Level up your lunge',
        description: '3 ways you can lift your lunge game.',
        imageAsset: '$_images/in_motion_lunge.png',
      ),
    ],
    referFriend: LinkCardModel(
      id: 'bring-a-friend',
      title: 'Bring a friend for free',
      ctaLabel: 'Share invite',
      imageAsset: '$_images/refer_friend.png',
    ),
    classes: [
      ClassCardModel(
        id: 'the-trip',
        name: 'The Trip',
        intensity: 4,
        imageAsset: '$_images/class_the_trip.png',
      ),
      ClassCardModel(
        id: 'conquer',
        name: 'Conquer',
        intensity: 5,
        imageAsset: '$_images/class_conquer.png',
      ),
      ClassCardModel(
        id: 'bodybalance',
        name: 'BodyBalance',
        intensity: 2,
        imageAsset: '$_images/class_bodybalance.png',
      ),
    ],
    groupFitnessDescription: AppStrings.groupFitnessDescription,
  );

  static const HomeState loadedState = HomeLoaded(loaded);
  static const HomeState loadingState = HomeLoading();
  static const HomeState emptyState = HomeEmpty();
  static const HomeState errorState =
      HomeError('We couldn’t load your home');
}

/// Les Mills — centralised user-visible copy.
///
/// No i18n library is in use, so every user-visible string and accessibility
/// label lives here rather than being scattered through widget trees. If
/// multilingual support is added later, this file becomes the extraction point.
abstract final class AppStrings {
  AppStrings._();

  // Generic / shared
  static const String retry = 'Try again';
  static const String loading = 'Loading';

  // Home — hero
  static const String homeScanIn = 'Scan in';
  static const String homeGreetingLead = 'Mōrena';
  static const String homeGreetingSubtitle = 'It’s great to see you again';

  // Home — activity summary
  static const String activitySummaryTitle = 'Activity summary';
  static const String activityThisWeek = 'This week';
  static const String activityLastWeek = 'Last week';
  static const String viewClassBookings = 'View class bookings';

  // Home — In Motion
  static const String inMotionTitle = 'In Motion';

  // Home — Group Fitness
  static const String groupFitnessTitle = 'Explore Group Fitness';
  static const String groupFitnessDescription =
      'Whether you’re new or experienced with working out, Group Fitness '
      'workouts deliver a results-focused fitness experience.';
  static const String groupFitnessTimetableCta = 'View the Group Fitness Timetable';

  // Home — error / empty
  static const String homeLoadErrorTitle = 'We couldn’t load your home';
  static const String homeLoadErrorBody =
      'Check your connection and try again.';
  static const String homeEmptyTitle = 'Nothing here yet';
  static const String homeEmptyBody =
      'Your activity and recommendations will appear here once you get started.';

  // Bottom navigation
  static const String navHome = 'Home';
  static const String navProgress = 'Progress';
  static const String navTimetable = 'Timetable';
  static const String navExplore = 'Explore';
  static const String navProfile = 'Profile';

  // Accessibility — semantic labels
  static const String a11yIntensity = 'Workout intensity';
  static String a11yIntensityValue(int level, int max) =>
      '$level out of $max';
  static String a11yClassCard(String name) => '$name class';
  static String a11yWeeklyWorkouts(int count) =>
      '$count ${count == 1 ? 'workout' : 'workouts'}';
}

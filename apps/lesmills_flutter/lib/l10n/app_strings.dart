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

  // Splash / launch
  static const String appName = 'LES MILLS';
  static const String splashTagline = 'For people, for planet';
  static const String launchErrorTitle = 'We couldn’t start the app';
  static const String launchErrorBody =
      'Check your connection and try again.';
  static const String a11ySplash = 'Les Mills';
  static const String a11yStarting = 'Starting Les Mills';

  // Shell — placeholder for tabs not yet built
  static const String comingSoonTitle = 'Coming soon';
  static String comingSoonBody(String tab) =>
      'The $tab experience is on its way.';

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

  // Progress — page
  static const String progressTitle = 'Progress';
  static const String progressSummaryTitle = '4 week summary';
  static const String progressSummaryDescription =
      'Complete at least 3 workouts every week to continue building your '
      'streaks.';
  static const String progressLastWeek = 'Last week';
  static const String progressCurrentStreak = 'Current streak';
  static const String progressViewWorkouts = 'View workouts';
  static const String progressBadgesTitle = 'Badges earned';
  static const String progressViewAll = 'View all';
  static const String progressNextToUnlock = 'Next to unlock';
  static String progressClubVisits(int current, int total) =>
      '$current/$total club visits';
  static const String progressTipsTitle = 'Workout tips';
  static const String progressEmptyTitle = 'No progress yet';
  static const String progressEmptyBody =
      'Complete your first workout and your streaks, badges and tips will '
      'appear here.';
  static const String progressErrorTitle = 'We couldn’t load your progress';

  // Progress — accessibility
  static String a11yWeekStreak(String range, int workouts) =>
      'Week of $range, $workouts ${workouts == 1 ? 'workout' : 'workouts'} '
      'completed';
  static String a11yBadgeEarned(String label) => '$label badge, earned';
  static String a11yBadgeLocked(String label) => '$label badge, locked';
  static String a11yNextToUnlock(String label, int current, int total) =>
      'Next to unlock: $label, $current of $total club visits';

  // Timetable
  static const String timetableTitle = 'Timetable';
  static const String timetableClubTab = 'Club Timetable';
  static const String timetableBookingsTab = 'My Bookings';
  static const String timetableMorning = 'Morning';
  static const String timetableLunch = 'Lunch';
  static const String timetableAfternoon = 'Afternoon';
  static const String timetableNight = 'Night';
  static const String timetableBookNow = 'Book now';
  static const String timetableBooked = 'Booked';
  static String timetableAvailable(int count) => '$count available';
  static const String timetableFull = 'Full';
  static const String timetableEmptyTitle = 'No classes scheduled';
  static const String timetableEmptyBody =
      'There are no classes for this time of day. Try another filter or '
      'pick a different date.';
  static const String timetableErrorTitle =
      'We couldn’t load the timetable';

  // Timetable — accessibility
  static String a11yDateOption(String weekday, int day, bool selected) =>
      '$weekday $day${selected ? ', selected' : ''}';
  static String a11yClassSession(
    String time,
    String duration,
    String name,
    String studio,
    String instructor,
  ) =>
      '$name at $time, $duration, $studio with $instructor';
  static String a11yBookClass(String name, String time) =>
      'Book $name at $time';
  static String a11yClassBooked(String name, String time) =>
      '$name at $time, booked';

  // Explore
  static const String exploreTitle = 'Explore';
  static const String explorePersonalTrainingTitle = 'Personal training';
  static const String explorePersonalTrainingDescription =
      'You’ll achieve results faster with the one-on-one attention of our '
      'enthusiastic, experienced Personal Trainers.';
  static const String exploreAtHomeTitle = 'Les Mills At Home';
  static const String exploreAtHomeDescription =
      'Whether you want to give Group Fitness a test drive before trying it in '
      'the club or you want to smash out a 15 minute workout at home, Les Mills '
      'at Home has you covered.';
  static const String exploreNewInLabel = 'New In';
  static const String exploreClassesLabel = 'Classes';
  static const String exploreCollectionsLabel = 'Collections';
  static const String exploreGroupFitnessTitle = 'Group fitness';
  static const String exploreGroupFitnessDescription =
      'Whether you’re new or experienced with working out, Group Fitness '
      'workouts deliver a results-focused fitness experience.';
  static const String exploreTimetableCta = 'View the Group Fitness Timetable';
  static const String exploreEmptyTitle = 'Nothing to explore yet';
  static const String exploreEmptyBody =
      'New classes and collections will appear here. Check back soon.';
  static const String exploreErrorTitle =
      'We couldn’t load Explore';
  static const String exploreCarouselError =
      'We couldn’t load this. Try again later.';
  static const String exploreCarouselEmpty = 'Nothing here yet.';

  // Explore — accessibility
  static String a11yDiscoveryCard(String title) => title;
  static String a11yExploreTimetableCta(String label) => label;

  // Profile
  static const String profileTitle = 'Profile';
  static const String profileAppSettingsTitle = 'App Settings';
  static const String profileMembershipTitle = 'Membership';
  static const String profileNotificationPrefs = 'Notification preferences';
  static const String profileSyncCalendar = 'Sync classes to my calendar';
  static const String profileChangePassword = 'Change password';
  static const String profileTermsOfUse = 'Terms of use';
  static const String profilePayAccount = 'Pay account';
  static const String profilePersonalDetails = 'My personal details';
  static const String profileTransactionHistory = 'Transaction history';
  static const String profileManageMembership = 'Manage membership';
  static const String profileContactUs = 'Contact us';
  static const String profileAppVersion = 'App version 3.304';
  static const String profileLogout = 'Log out';
  static const String profileEmptyTitle = 'Nothing to show yet';
  static const String profileEmptyBody =
      'Your settings will appear here once they load.';
  static const String profileErrorTitle = 'We couldn’t load your profile';

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

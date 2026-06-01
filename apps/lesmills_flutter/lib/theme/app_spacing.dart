/// Les Mills design system — spacing scale.
///
/// 4-based scale. Every spacing value in the app (padding, margins, gaps,
/// `SizedBox`) must come from these constants. Corner radii snap to [s2]/[s3];
/// pill buttons use `StadiumBorder` instead of a raw radius.
abstract final class AppSpacing {
  AppSpacing._();

  static const double s1 = 4;
  static const double s2 = 8;
  static const double s3 = 12;
  static const double s4 = 16;
  static const double s5 = 24;
  static const double s6 = 32;
  static const double s7 = 48;
  static const double s8 = 64;
}

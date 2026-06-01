import '../../l10n/app_strings.dart';
import 'splash_model.dart';

/// Deterministic sample states for splash previews and tests. No timers, no
/// network — each state is fixed.
abstract final class SplashStubs {
  SplashStubs._();

  static const SplashState initialisingState = SplashInitialising();
  static const SplashState readyState = SplashReady();
  static const SplashState errorState =
      SplashError(AppStrings.launchErrorBody);
}

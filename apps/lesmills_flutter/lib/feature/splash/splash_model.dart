import 'package:flutter/foundation.dart';

/// Exhaustive state for the launch / splash sequence. Consumers must handle
/// every variant.
@immutable
sealed class SplashState {
  const SplashState();
}

/// The app is booting — restoring the session and warming shell data. The
/// branded splash is shown.
class SplashInitialising extends SplashState {
  const SplashInitialising();
}

/// Initialisation succeeded; the shell is ready to take over.
class SplashReady extends SplashState {
  const SplashReady();
}

/// Initialisation failed (offline / session refresh failed). The splash shows
/// a message with a Retry action.
class SplashError extends SplashState {
  const SplashError(this.message);
  final String message;
}

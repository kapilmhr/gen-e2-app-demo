import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import 'feature/shell/app_shell.dart';
import 'feature/splash/splash_model.dart';
import 'feature/splash/splash_screen.dart';
import 'l10n/app_strings.dart';
import 'theme/app_theme.dart';

// Top-level reference keeps the handle alive for the process lifetime so the
// Flutter semantics tree stays populated for Maestro and other a11y tooling.
// ignore: unused_element
SemanticsHandle? _semanticsHandle;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Force the Flutter semantics tree to be built so Maestro (and other
  // accessibility tooling) can read UI elements on the iOS simulator.
  _semanticsHandle = SemanticsBinding.instance.ensureSemantics();
  runApp(const LesMillsApp());
}

/// Root of the Les Mills member app. Light theme only.
class LesMillsApp extends StatelessWidget {
  const LesMillsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Les Mills',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const LaunchGate(),
    );
  }
}

/// Orchestrates the cold-start sequence: shows the branded [SplashScreen] while
/// [initialize] runs, then reveals the [AppShell]. On failure it surfaces a
/// retry affordance on the splash and re-runs initialisation.
///
/// [initialize] is injectable so tests and previews can drive the success and
/// failure paths deterministically without timers or network.
class LaunchGate extends StatefulWidget {
  const LaunchGate({super.key, this.initialize});

  /// Runs app initialisation (session restore, shell preload). Defaults to a
  /// short delay so the brand splash is not a jarring flash on fast boots.
  final Future<void> Function()? initialize;

  @override
  State<LaunchGate> createState() => _LaunchGateState();
}

class _LaunchGateState extends State<LaunchGate> {
  SplashState _state = const SplashInitialising();

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    setState(() => _state = const SplashInitialising());
    final initialize = widget.initialize ??
        () => Future<void>.delayed(const Duration(milliseconds: 800));
    try {
      await initialize();
      if (!mounted) return;
      setState(() => _state = const SplashReady());
    } catch (_) {
      if (!mounted) return;
      setState(() => _state = const SplashError(AppStrings.launchErrorBody));
    }
  }

  @override
  Widget build(BuildContext context) {
    return switch (_state) {
      SplashReady() => const AppShell(),
      SplashInitialising() ||
      SplashError() =>
        SplashScreen(state: _state, onRetry: _start),
    };
  }
}

import 'package:flutter/material.dart';

import '../../l10n/app_strings.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import 'splash_model.dart';

/// Branded launch screen shown once on cold start while the app initialises.
///
/// Presentational and state-driven: it renders the [state] it is given and
/// raises [onRetry] when the member taps Retry after a launch failure. The
/// launch lifecycle (running initialisation, navigating onward) lives in the
/// orchestrator that hosts this view, keeping the screen previewable and
/// test-friendly.
///
/// This is a deliberately dark, full-bleed brand surface — one of the few
/// places the app uses a black canvas. Foreground text is [AppColors.white]
/// for contrast, per the design system's "white on dark backgrounds" rule.
class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
    required this.state,
    this.onRetry,
  });

  final SplashState state;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.s6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Semantics(
                  header: true,
                  label: AppStrings.a11ySplash,
                  child: ExcludeSemantics(
                    child: Column(
                      children: [
                        Text(
                          AppStrings.appName,
                          textAlign: TextAlign.center,
                          style: textTheme.headlineMedium?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 4,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s2),
                        Text(
                          AppStrings.splashTagline,
                          textAlign: TextAlign.center,
                          style: textTheme.labelMedium?.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                _SplashFooter(state: state, onRetry: onRetry),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The bottom region: a quiet "starting" hint while initialising, or an error
/// message with a Retry action when launch fails.
class _SplashFooter extends StatelessWidget {
  const _SplashFooter({required this.state, this.onRetry});

  final SplashState state;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return switch (state) {
      SplashInitialising() || SplashReady() => Semantics(
          liveRegion: true,
          label: AppStrings.a11yStarting,
          child: const SizedBox(
            height: AppSpacing.s7,
            width: AppSpacing.s7,
            child: Center(
              child: SizedBox(
                height: AppSpacing.s5,
                width: AppSpacing.s5,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                ),
              ),
            ),
          ),
        ),
      SplashError(:final message) => Semantics(
          liveRegion: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.launchErrorTitle,
                textAlign: TextAlign.center,
                style: textTheme.titleMedium?.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: AppSpacing.s2),
              Text(
                message,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(color: AppColors.grey),
              ),
              const SizedBox(height: AppSpacing.s5),
              OutlinedButton(
                onPressed: onRetry,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.white,
                  side: const BorderSide(color: AppColors.white),
                  minimumSize: const Size.fromHeight(AppSpacing.s7),
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
                  shape: const StadiumBorder(),
                ),
                child: Text(AppStrings.retry.toUpperCase()),
              ),
            ],
          ),
        ),
    };
  }
}

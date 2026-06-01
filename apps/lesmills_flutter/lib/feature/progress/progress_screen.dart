import 'package:flutter/material.dart';

import '../../components/page_header/page_header.dart';
import '../../components/section_header/section_header.dart';
import '../../l10n/app_strings.dart';
import '../../theme/app_spacing.dart';
import 'progress_model.dart';
import 'progress_stubs.dart';
import 'widgets/badges_section.dart';
import 'widgets/streak_calendar_card.dart';
import 'widgets/workout_tips_section.dart';

/// The Progress tab — the member's streaks, badges and workout tips. Renders
/// the [ProgressState] passed in (defaulting to loaded sample data). The
/// persistent bottom navigation is owned by `AppShell`, so this screen is a
/// pure tab body.
class ProgressScreen extends StatelessWidget {
  const ProgressScreen({
    super.key,
    this.initialState = ProgressStubs.loadedState,
    this.onRetry,
  });

  final ProgressState initialState;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: switch (initialState) {
        ProgressIdle() || ProgressLoading() => const _ProgressSkeleton(),
        ProgressEmpty() => const _ProgressMessage(
            title: AppStrings.progressEmptyTitle,
            body: AppStrings.progressEmptyBody,
          ),
        ProgressError(:final message) => _ProgressMessage(
            title: message,
            body: AppStrings.progressEmptyBody,
            onRetry: onRetry,
          ),
        ProgressLoaded(:final data) => _ProgressContent(data: data),
      },
    );
  }
}

class _ProgressContent extends StatelessWidget {
  const _ProgressContent({required this.data});

  final ProgressData data;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        PageHeader(
          title: AppStrings.progressTitle,
          imageAsset: data.headerImageAsset,
          imageUrl: data.headerImageUrl,
        ),
        const SizedBox(height: AppSpacing.s5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                title: AppStrings.progressSummaryTitle,
                description: AppStrings.progressSummaryDescription,
              ),
              const SizedBox(height: AppSpacing.s5),
              StreakCalendarCard(
                dateRange: data.dateRange,
                weeks: data.weeks,
                lastWeekValue: data.lastWeekValue,
                currentStreakValue: data.currentStreakValue,
              ),
              const SizedBox(height: AppSpacing.s5),
              OutlinedButton(
                onPressed: () {},
                child: Text(AppStrings.progressViewWorkouts.toUpperCase()),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s6),
        BadgesSection(
          badges: data.badges,
          nextToUnlock: data.nextToUnlock,
          onViewAll: () {},
          onBadgeTap: (_) {},
        ),
        const SizedBox(height: AppSpacing.s6),
        WorkoutTipsSection(
          tips: data.tips,
          onTipTap: (_) {},
        ),
        const SizedBox(height: AppSpacing.s7),
      ],
    );
  }
}

/// Static (non-animated) skeleton — respects reduced-motion preferences by
/// avoiding shimmer entirely.
class _ProgressSkeleton extends StatelessWidget {
  const _ProgressSkeleton();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.surfaceContainerLowest;

    Widget block(double height) => Container(
          height: height,
          margin: const EdgeInsets.only(bottom: AppSpacing.s4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(AppSpacing.s3),
          ),
        );

    return Semantics(
      label: AppStrings.loading,
      child: ExcludeSemantics(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.s5),
          children: [
            block(120),
            block(334),
            block(150),
            block(180),
          ],
        ),
      ),
    );
  }
}

class _ProgressMessage extends StatelessWidget {
  const _ProgressMessage({
    required this.title,
    required this.body,
    this.onRetry,
  });

  final String title;
  final String body;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.s2),
            Text(
              body,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.s5),
              ElevatedButton(
                onPressed: onRetry,
                child: Text(AppStrings.retry.toUpperCase()),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

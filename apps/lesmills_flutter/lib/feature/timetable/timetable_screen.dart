import 'package:flutter/material.dart';

import '../../l10n/app_strings.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import 'timetable_model.dart';
import 'timetable_stubs.dart';
import 'widgets/day_part_filter.dart';
import 'widgets/timetable_class_card.dart';
import 'widgets/timetable_header.dart';

/// The Timetable tab — browse and book club classes by day and time of day.
///
/// Renders the [TimetableState] passed in (defaulting to loaded sample data).
/// The persistent bottom navigation is owned by `AppShell`, so this screen is
/// a pure tab body.
class TimetableScreen extends StatelessWidget {
  const TimetableScreen({
    super.key,
    this.initialState = TimetableStubs.loadedState,
    this.onRetry,
  });

  final TimetableState initialState;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: switch (initialState) {
        TimetableIdle() || TimetableLoading() => const _TimetableSkeleton(),
        TimetableEmpty() => const _TimetableMessage(
            title: AppStrings.timetableEmptyTitle,
            body: AppStrings.timetableEmptyBody,
          ),
        TimetableError(:final message) => _TimetableMessage(
            title: message,
            body: AppStrings.timetableEmptyBody,
            onRetry: onRetry,
          ),
        TimetableLoaded(:final data) => _TimetableContent(data: data),
      },
    );
  }
}

class _TimetableContent extends StatelessWidget {
  const _TimetableContent({required this.data});

  final TimetableData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TimetableHeader(data: data),
        Expanded(
          child: ColoredBox(
            color: AppColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.s2),
                DayPartFilter(selected: data.selectedDayPart),
                const SizedBox(height: AppSpacing.s2),
                Expanded(
                  child: data.classes.isEmpty
                      ? _TimetableMessage(
                          title: AppStrings.timetableEmptyTitle,
                          body: AppStrings.timetableEmptyBody,
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(
                            AppSpacing.s4,
                            AppSpacing.s2,
                            AppSpacing.s4,
                            AppSpacing.s6,
                          ),
                          itemCount: data.classes.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: AppSpacing.s4),
                          itemBuilder: (context, index) =>
                              TimetableClassCard(session: data.classes[index]),
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Static (non-animated) skeleton — respects reduced-motion preferences by
/// avoiding shimmer entirely.
class _TimetableSkeleton extends StatelessWidget {
  const _TimetableSkeleton();

  @override
  Widget build(BuildContext context) {
    Widget block(double height, {double? width}) => Container(
          height: height,
          width: width,
          margin: const EdgeInsets.only(bottom: AppSpacing.s4),
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(AppSpacing.s3),
          ),
        );

    return Semantics(
      label: AppStrings.loading,
      child: ExcludeSemantics(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.s5),
          children: [
            block(40, width: 220),
            block(68),
            block(32, width: 280),
            const SizedBox(height: AppSpacing.s2),
            block(96),
            block(96),
            block(96),
          ],
        ),
      ),
    );
  }
}

class _TimetableMessage extends StatelessWidget {
  const _TimetableMessage({
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

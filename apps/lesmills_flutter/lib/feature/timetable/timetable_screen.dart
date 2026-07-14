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
class TimetableScreen extends StatefulWidget {
  const TimetableScreen({
    super.key,
    this.initialState = TimetableStubs.loadedState,
    this.onRetry,
  });

  final TimetableState initialState;
  final VoidCallback? onRetry;

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  final Set<String> _bookedIds = {};

  void _handleBook(TimetableClass session) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.s4)),
      ),
      builder: (sheetContext) => _BookingConfirmSheet(
        session: session,
        onConfirm: () {
          Navigator.of(sheetContext).pop();
          setState(() => _bookedIds.add(session.id));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: switch (widget.initialState) {
        TimetableIdle() || TimetableLoading() => const _TimetableSkeleton(),
        TimetableEmpty() => const _TimetableMessage(
            title: AppStrings.timetableEmptyTitle,
            body: AppStrings.timetableEmptyBody,
          ),
        TimetableError(:final message) => _TimetableMessage(
            title: message,
            body: AppStrings.timetableEmptyBody,
            onRetry: widget.onRetry,
          ),
        TimetableLoaded(:final data) => _TimetableContent(
            data: data,
            bookedIds: _bookedIds,
            onBook: _handleBook,
          ),
      },
    );
  }
}

class _TimetableContent extends StatefulWidget {
  const _TimetableContent({
    required this.data,
    required this.bookedIds,
    required this.onBook,
  });

  final TimetableData data;
  final Set<String> bookedIds;
  final void Function(TimetableClass) onBook;

  @override
  State<_TimetableContent> createState() => _TimetableContentState();
}

class _TimetableContentState extends State<_TimetableContent> {
  late DayPart _selectedDayPart;

  @override
  void initState() {
    super.initState();
    _selectedDayPart = widget.data.selectedDayPart;
  }

  /// Parses a time string like '7:15am' or '6:20pm' to a 24-hour integer hour.
  int _parseHour(String time) {
    final lower = time.toLowerCase();
    final isPm = lower.endsWith('pm');
    final stripped = lower.replaceAll('am', '').replaceAll('pm', '');
    final hour = int.parse(stripped.split(':').first);
    if (isPm && hour != 12) return hour + 12;
    if (!isPm && hour == 12) return 0;
    return hour;
  }

  List<TimetableClass> get _filteredClasses {
    return widget.data.classes.where((c) {
      final hour = _parseHour(c.time);
      return switch (_selectedDayPart) {
        DayPart.morning => hour >= 5 && hour < 12,
        DayPart.lunch => hour == 12 || hour == 13,
        DayPart.afternoon => hour >= 14 && hour <= 17,
        DayPart.night => hour >= 18,
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredClasses;
    return Column(
      children: [
        TimetableHeader(data: widget.data),
        Expanded(
          child: ColoredBox(
            color: AppColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.s2),
                DayPartFilter(
                  selected: _selectedDayPart,
                  onSelected: (part) =>
                      setState(() => _selectedDayPart = part),
                ),
                const SizedBox(height: AppSpacing.s2),
                Expanded(
                  child: filtered.isEmpty
                      ? const _TimetableMessage(
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
                          itemCount: filtered.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: AppSpacing.s4),
                          itemBuilder: (context, index) {
                            final session = filtered[index];
                            final effective =
                                widget.bookedIds.contains(session.id)
                                    ? session.copyWith(
                                        bookingState:
                                            ClassBookingState.booked,
                                      )
                                    : session;
                            return TimetableClassCard(
                              session: effective,
                              onBook: effective.bookingState ==
                                      ClassBookingState.booked
                                  ? null
                                  : () => widget.onBook(session),
                            );
                          },
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

/// Bottom sheet shown when the member taps "Book now".
/// Displays class details and offers Cancel / Confirm actions.
class _BookingConfirmSheet extends StatelessWidget {
  const _BookingConfirmSheet({
    required this.session,
    required this.onConfirm,
  });

  final TimetableClass session;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.s5,
          AppSpacing.s5,
          AppSpacing.s5,
          AppSpacing.s4,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.timetableConfirmTitle,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.s4),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.s4),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(AppSpacing.s3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    session.name.toUpperCase(),
                    style: theme.textTheme.labelLarge,
                  ),
                  const SizedBox(height: AppSpacing.s1),
                  Text(
                    '${session.time} · ${session.duration}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.darkGrey,
                    ),
                  ),
                  Text(
                    '${session.studio} with ${session.instructor}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.darkGrey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.s5),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(AppStrings.cancel),
                  ),
                ),
                const SizedBox(width: AppSpacing.s3),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    child: Text(AppStrings.timetableConfirmCta),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../l10n/app_strings.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../timetable_model.dart';

/// A single class session row: time + duration on the left, class details in
/// the middle, and a booking CTA on the right.
class TimetableClassCard extends StatelessWidget {
  const TimetableClassCard({
    super.key,
    required this.session,
    this.onBook,
  });

  final TimetableClass session;
  final VoidCallback? onBook;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isBooked = session.bookingState == ClassBookingState.booked;

    return Semantics(
      label: isBooked
          ? AppStrings.a11yClassBooked(session.name, session.time)
          : AppStrings.a11yClassSession(
              session.time,
              session.duration,
              session.name,
              session.studio,
              session.instructor,
            ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(AppSpacing.s4),
        ),
        padding: const EdgeInsets.all(AppSpacing.s3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 74,
                  child: ExcludeSemantics(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          session.time.toUpperCase(),
                          style: theme.textTheme.labelLarge,
                        ),
                        Text(
                          session.duration,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.darkGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.s2),
                Expanded(
                  child: ExcludeSemantics(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          session.name.toUpperCase(),
                          style: theme.textTheme.labelLarge,
                        ),
                        const SizedBox(height: AppSpacing.s1),
                        Wrap(
                          spacing: AppSpacing.s2,
                          children: [
                            Text(
                              session.studio,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: AppColors.darkGrey,
                              ),
                            ),
                            Text(
                              session.instructor,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: AppColors.darkGrey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s2),
            _CtaRow(session: session, onBook: onBook),
          ],
        ),
      ),
    );
  }
}

class _CtaRow extends StatelessWidget {
  const _CtaRow({required this.session, this.onBook});

  final TimetableClass session;
  final VoidCallback? onBook;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (session.bookingState == ClassBookingState.booked) {
      return _BookedChip();
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (session.availableCount != null)
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.s2),
            child: ExcludeSemantics(
              child: Text(
                AppStrings.timetableAvailable(session.availableCount!),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.darkGrey,
                ),
              ),
            ),
          ),
        _BookButton(session: session, onBook: onBook),
      ],
    );
  }
}

class _BookButton extends StatelessWidget {
  const _BookButton({required this.session, this.onBook});

  final TimetableClass session;
  final VoidCallback? onBook;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      button: true,
      label: AppStrings.a11yBookClass(session.name, session.time),
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.s2),
        child: InkWell(
          onTap: onBook,
          borderRadius: BorderRadius.circular(AppSpacing.s2),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s4,
              vertical: AppSpacing.s2,
            ),
            child: ExcludeSemantics(
              child: Text(
                AppStrings.timetableBookNow,
                style: theme.textTheme.labelSmall,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BookedChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ExcludeSemantics(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.success,
          borderRadius: BorderRadius.circular(AppSpacing.s2),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s4,
          vertical: AppSpacing.s2,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.timetableBooked,
              style: theme.textTheme.labelSmall?.copyWith(
                color: AppColors.white,
              ),
            ),
            const SizedBox(width: AppSpacing.s2),
            const Icon(Icons.check, size: 16, color: AppColors.white),
          ],
        ),
      ),
    );
  }
}

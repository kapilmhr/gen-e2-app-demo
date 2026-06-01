import 'package:flutter/material.dart';

import '../../../l10n/app_strings.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../timetable_model.dart';
import 'date_selector.dart';

/// The gradient header: section tabs, the month + location row, and the
/// horizontal date selector.
class TimetableHeader extends StatelessWidget {
  const TimetableHeader({
    super.key,
    required this.data,
    this.onSectionSelected,
    this.onDaySelected,
    this.onLocationTap,
    this.onInfoTap,
  });

  final TimetableData data;
  final ValueChanged<TimetableSection>? onSectionSelected;
  final ValueChanged<TimetableDay>? onDaySelected;
  final VoidCallback? onLocationTap;
  final VoidCallback? onInfoTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.blue, AppColors.darkOrange],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.s5,
            AppSpacing.s2,
            AppSpacing.s5,
            AppSpacing.s5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionTabs(
                section: data.section,
                onSelected: onSectionSelected,
              ),
              const SizedBox(height: AppSpacing.s5),
              _MonthLocationRow(
                month: data.month,
                location: data.location,
                onLocationTap: onLocationTap,
                onInfoTap: onInfoTap,
              ),
              const SizedBox(height: AppSpacing.s4),
              DateSelector(days: data.days, onDaySelected: onDaySelected),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTabs extends StatelessWidget {
  const _SectionTabs({required this.section, this.onSelected});

  final TimetableSection section;
  final ValueChanged<TimetableSection>? onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _Tab(
            label: AppStrings.timetableClubTab,
            isSelected: section == TimetableSection.clubTimetable,
            onTap: onSelected == null
                ? null
                : () => onSelected!(TimetableSection.clubTimetable),
          ),
          const SizedBox(width: AppSpacing.s4),
          _Tab(
            label: AppStrings.timetableBookingsTab,
            isSelected: section == TimetableSection.myBookings,
            onTap: onSelected == null
                ? null
                : () => onSelected!(TimetableSection.myBookings),
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({required this.label, required this.isSelected, this.onTap});

  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final background =
        isSelected ? AppColors.white : AppColors.white.withValues(alpha: 0.3);
    final foreground = isSelected ? AppColors.black : AppColors.white;

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(AppSpacing.s2),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s4,
              vertical: AppSpacing.s2,
            ),
            child: ExcludeSemantics(
              child: Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(color: foreground),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MonthLocationRow extends StatelessWidget {
  const _MonthLocationRow({
    required this.month,
    required this.location,
    this.onLocationTap,
    this.onInfoTap,
  });

  final String month;
  final String location;
  final VoidCallback? onLocationTap;
  final VoidCallback? onInfoTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Semantics(
            header: true,
            child: Text(
              month.toUpperCase(),
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelLarge
                  ?.copyWith(color: AppColors.white),
            ),
          ),
        ),
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: _LocationPill(label: location, onTap: onLocationTap)),
              const SizedBox(width: AppSpacing.s1),
              IconButton(
                onPressed: onInfoTap,
                icon: const Icon(Icons.info_outline, color: AppColors.white),
                iconSize: 24,
                tooltip: MaterialLocalizations.of(context).moreButtonTooltip,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LocationPill extends StatelessWidget {
  const _LocationPill({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.white, width: 2),
        borderRadius: BorderRadius.circular(AppSpacing.s2),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s4,
            vertical: AppSpacing.s2,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 16,
                color: AppColors.offWhite,
              ),
              const SizedBox(width: AppSpacing.s1),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.offWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

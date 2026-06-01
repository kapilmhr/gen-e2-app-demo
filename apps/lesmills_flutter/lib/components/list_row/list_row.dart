import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';
import 'list_row_model.dart';

/// A single tappable settings-style row: a title followed by a trailing
/// chevron. Reports taps via [onTap]. The chevron is decorative — the whole
/// row is a single semantic button exposing the [ListRowModel.title].
///
/// Rows are designed to be grouped inside a rounded surface (see
/// `SettingsListSection`); the chevron mirrors automatically under RTL.
class ListRow extends StatelessWidget {
  const ListRow({super.key, required this.model, this.onTap});

  final ListRowModel model;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      button: onTap != null,
      label: model.title,
      child: ExcludeSemantics(
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            // 48px minimum keeps the tap target accessible while letting the
            // row grow for large text.
            constraints: const BoxConstraints(minHeight: AppSpacing.s7),
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppSpacing.s4,
                right: AppSpacing.s5,
                top: AppSpacing.s2,
                bottom: AppSpacing.s2,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      model.title,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.s3),
                  Icon(
                    Directionality.of(context) == TextDirection.rtl
                        ? Icons.chevron_left
                        : Icons.chevron_right,
                    color: theme.colorScheme.onSurface,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

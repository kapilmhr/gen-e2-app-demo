import 'package:flutter/material.dart';

import '../../../components/list_row/list_row.dart';
import '../../../components/list_row/list_row_model.dart';
import '../../../components/section_header/section_header.dart';
import '../../../theme/app_spacing.dart';

/// A titled group of settings rows rendered inside a single rounded surface,
/// with hairline dividers between rows (but not after the last). Used for the
/// Profile screen's "App Settings" and "Membership" sections.
class SettingsListSection extends StatelessWidget {
  const SettingsListSection({
    super.key,
    required this.title,
    required this.rows,
    this.onRowTap,
  });

  final String title;
  final List<ListRowModel> rows;
  final ValueChanged<ListRowModel>? onRowTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: title),
        const SizedBox(height: AppSpacing.s4),
        Material(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSpacing.s2),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (var i = 0; i < rows.length; i++) ...[
                ListRow(
                  model: rows[i],
                  onTap:
                      onRowTap == null ? null : () => onRowTap!(rows[i]),
                ),
                if (i < rows.length - 1)
                  Divider(
                    height: 1,
                    thickness: 1,
                    indent: AppSpacing.s4,
                    endIndent: AppSpacing.s5,
                    color: theme.colorScheme.outline,
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

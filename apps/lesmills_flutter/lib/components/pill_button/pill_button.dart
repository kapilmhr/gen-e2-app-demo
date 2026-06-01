import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';

/// Displays a compact white pill-shaped button with an optional leading icon.
///
/// Pure-display atom: no internal state model — it renders its parameters and
/// reports taps via [onPressed]. Used for the hero "Scan in" action and the
/// call-to-action inside link cards.
class PillButton extends StatelessWidget {
  const PillButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
  });

  /// The visible button text. Also used as the accessibility label.
  final String label;

  /// Invoked when the button is tapped. When null the button is disabled.
  final VoidCallback? onPressed;

  /// Optional leading icon shown before the label.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final foreground = theme.colorScheme.onSurface;

    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: label,
      child: Material(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.s2),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppSpacing.s2),
          child: ConstrainedBox(
            // iOS HIG 44pt / Material 48dp minimum tap target.
            constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpacing.s4,
                vertical: AppSpacing.s2,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: AppSpacing.s2,
                children: [
                  if (icon != null)
                    Icon(icon, size: 16, color: foreground),
                  Flexible(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelMedium
                          ?.copyWith(color: foreground),
                    ),
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

import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../progress_model.dart';

/// A hexagonal achievement emblem with short centred text, painted directly so
/// it renders deterministically offline (no network image).
///
/// Pure-display: it renders [colour] and [emblem]; the caller supplies size and
/// semantics. Locked badges are rendered muted by the parent via [opacity].
class AchievementBadge extends StatelessWidget {
  const AchievementBadge({
    super.key,
    required this.emblem,
    required this.colour,
    this.size = const Size(84, 95),
    this.emblemStyle,
  });

  /// Short text rendered inside the hexagon (may contain a line break).
  final String emblem;

  final BadgeColour colour;

  /// Emblem footprint. Defaults to the 84×95 Figma badge size.
  final Size size;

  /// Optional override for the emblem text style (e.g. smaller for the locked
  /// "next to unlock" badge).
  final TextStyle? emblemStyle;

  Color get _fill => switch (colour) {
        BadgeColour.dark => AppColors.black,
        BadgeColour.blue => AppColors.secondaryBlue,
        BadgeColour.brown => AppColors.darkBrown,
        BadgeColour.orange => AppColors.darkOrange,
        BadgeColour.locked => AppColors.grey,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox.fromSize(
      size: size,
      child: CustomPaint(
        painter: _HexagonPainter(_fill),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              emblem,
              textAlign: TextAlign.center,
              style: emblemStyle ??
                  theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.white,
                    height: 1.1,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Paints a flat-top hexagon filling the available size.
class _HexagonPainter extends CustomPainter {
  const _HexagonPainter(this.fill);

  final Color fill;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    // Flat-top hexagon: two points at the vertical mid-line, four at the
    // quarter heights, matching the badge silhouette in the design.
    final path = Path()
      ..moveTo(w * 0.5, 0)
      ..lineTo(w, h * 0.25)
      ..lineTo(w, h * 0.75)
      ..lineTo(w * 0.5, h)
      ..lineTo(0, h * 0.75)
      ..lineTo(0, h * 0.25)
      ..close();
    canvas.drawPath(path, Paint()..color = fill);
  }

  @override
  bool shouldRepaint(_HexagonPainter oldDelegate) => oldDelegate.fill != fill;
}

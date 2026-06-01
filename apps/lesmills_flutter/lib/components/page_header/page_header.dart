import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../common/remote_image.dart';

/// A full-bleed branded screen header: a background image with a dark scrim and
/// a centred uppercase title. Shared across the Progress, Explore and Profile
/// tabs so every screen opens with a consistent brand moment.
///
/// Pure-display atom — it renders its parameters and holds no state. When no
/// image is provided a neutral placeholder is shown so it renders
/// deterministically offline.
class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.title,
    this.imageAsset,
    this.imageUrl,
    this.height = 195,
  });

  /// Header text. Rendered in uppercase per the brand type treatment.
  final String title;

  /// Optional bundled image asset. Preferred over [imageUrl].
  final String? imageAsset;

  /// Optional remote image; null (with no [imageAsset]) shows a neutral
  /// placeholder.
  final String? imageUrl;

  /// Header height. Matches the 195px Figma frame by default.
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          RemoteImage(assetPath: imageAsset, url: imageUrl),
          // Scrim keeps the white title legible over any image.
          const ColoredBox(color: AppColors.scrimMedium),
          SafeArea(
            bottom: false,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
                child: Semantics(
                  header: true,
                  child: Text(
                    title.toUpperCase(),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.displayMedium
                        ?.copyWith(color: AppColors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

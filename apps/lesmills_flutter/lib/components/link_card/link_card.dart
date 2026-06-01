import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../common/remote_image.dart';
import '../pill_button/pill_button.dart';
import 'link_card_model.dart';

/// Displays a full-bleed promotional card: an image with a dark scrim, a white
/// title and a single call-to-action pill button.
class LinkCard extends StatelessWidget {
  const LinkCard({
    super.key,
    required this.model,
    this.onPressed,
    this.height = 180,
    this.scrim = AppColors.scrimMedium,
  });

  final LinkCardModel model;

  /// Invoked when the card's call-to-action is tapped.
  final VoidCallback? onPressed;

  final double height;

  /// Dark overlay placed over the image to keep the white title legible.
  final Color scrim;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      container: true,
      label: model.title,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.s4),
        child: SizedBox(
          height: height,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              RemoteImage(
                assetPath: model.imageAsset,
                url: model.imageUrl,
              ),
              // Scrim guarantees ≥4.5:1 contrast for the white title regardless
              // of the underlying image.
              ColoredBox(color: scrim),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.s4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title.toUpperCase(),
                      style: theme.textTheme.titleLarge
                          ?.copyWith(color: AppColors.white),
                    ),
                    const Spacer(),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: PillButton(
                        label: model.ctaLabel,
                        onPressed: onPressed,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

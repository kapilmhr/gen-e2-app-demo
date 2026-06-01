import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';
import '../common/remote_image.dart';
import 'content_card_model.dart';

/// Displays an editorial "In Motion" story as a fixed-width image card with a
/// title and short description. Reports taps via [onTap].
class ContentCard extends StatelessWidget {
  const ContentCard({
    super.key,
    required this.model,
    this.onTap,
    this.width = 240,
  });

  final ContentCardModel model;
  final VoidCallback? onTap;

  /// Fixed card width; the card is designed for a horizontal carousel.
  final double width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      button: onTap != null,
      label: model.title,
      child: SizedBox(
        width: width,
        child: Material(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSpacing.s2),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: ExcludeSemantics(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSpacing.s2),
                    child: SizedBox(
                      height: 140,
                      width: double.infinity,
                      child: RemoteImage(
                        assetPath: model.imageAsset,
                        url: model.imageUrl,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.s3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      spacing: AppSpacing.s1,
                      children: [
                        Text(
                          model.title.toUpperCase(),
                          style: theme.textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          model.description,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
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

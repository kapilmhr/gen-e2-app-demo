import 'dart:ui';

import 'package:flutter/material.dart';

import '../../l10n/app_strings.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../common/remote_image.dart';
import '../intensity_rating/intensity_rating.dart';
import 'class_card_model.dart';

/// Displays a Group Fitness class as a tall image card with a white name chip
/// (top-leading) and an intensity rating (bottom-trailing). Reports taps via
/// [onTap].
class ClassCard extends StatelessWidget {
  const ClassCard({
    super.key,
    required this.model,
    this.onTap,
    this.width = 240,
    this.height = 300,
  });

  final ClassCardModel model;
  final VoidCallback? onTap;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      button: onTap != null,
      label: AppStrings.a11yClassCard(model.name),
      value: AppStrings.a11yIntensityValue(model.intensity, model.maxIntensity),
      child: ExcludeSemantics(
        child: SizedBox(
          width: width,
          height: height,
          child: Material(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppSpacing.s4),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  RemoteImage(
                    assetPath: model.imageAsset,
                    url: model.imageUrl,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.s4),
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: _NameChip(name: model.name),
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: IntensityRating(
                            level: model.intensity,
                            max: model.maxIntensity,
                            color: AppColors.white,
                          ),
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

class _NameChip extends StatelessWidget {
  const _NameChip({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.s4),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.s3,
            vertical: AppSpacing.s1,
          ),
          color: AppColors.white,
          child: Text(
            name,
            style: theme.textTheme.labelMedium,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../components/common/remote_image.dart';
import '../../../components/pill_button/pill_button.dart';
import '../../../l10n/app_strings.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';

/// The Home hero: a tall background image with a "Scan in" action and a
/// personalised greeting. Single-use sub-widget of the Home screen.
class HomeHeroHeader extends StatelessWidget {
  const HomeHeroHeader({
    super.key,
    required this.memberName,
    this.imageAsset,
    this.imageUrl,
    this.onScanIn,
    this.height = 473,
  });

  final String memberName;
  final String? imageAsset;
  final String? imageUrl;
  final VoidCallback? onScanIn;
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
          // Scrim keeps white text and the action legible over any image.
          const ColoredBox(color: AppColors.scrimMedium),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.s5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: PillButton(
                      label: AppStrings.homeScanIn,
                      icon: Icons.qr_code_scanner,
                      onPressed: onScanIn,
                    ),
                  ),
                  const Spacer(),
                  Semantics(
                    header: true,
                    child: Text(
                      '${AppStrings.homeGreetingLead}\n$memberName'
                          .toUpperCase(),
                      style: theme.textTheme.displaySmall
                          ?.copyWith(color: AppColors.white),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s2),
                  Text(
                    AppStrings.homeGreetingSubtitle,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: AppColors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

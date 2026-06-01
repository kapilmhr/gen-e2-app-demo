import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Renders an image with a deterministic neutral fallback.
///
/// Used by every image-backed card. Prefers a bundled [assetPath] (the source
/// of truth for the design's photography), falling back to a remote [url], and
/// finally to a neutral [AppColors.neutralBlue] surface when neither is given
/// or the image fails to load. The neutral fallback keeps layout deterministic
/// offline and is decorative, so it is hidden from assistive tech.
class RemoteImage extends StatelessWidget {
  const RemoteImage({
    super.key,
    this.assetPath,
    this.url,
    this.fit = BoxFit.cover,
  });

  /// Bundled asset path (e.g. `assets/images/hero.png`). Takes precedence over
  /// [url] when provided.
  final String? assetPath;

  /// Remote image URL, used when [assetPath] is null.
  final String? url;

  /// How the image should be inscribed into its box.
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final placeholder = ExcludeSemantics(
      child: ColoredBox(color: AppColors.neutralBlue),
    );

    if (assetPath != null) {
      return Image.asset(
        assetPath!,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => placeholder,
      );
    }

    if (url == null) {
      return placeholder;
    }

    return Image.network(
      url!,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => placeholder,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return placeholder;
      },
    );
  }
}

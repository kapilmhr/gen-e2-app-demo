import 'package:flutter/foundation.dart';

/// Immutable data for a [LinkCard] — a full-bleed promotional card with a
/// single call-to-action (e.g. "6-week Kickstart Challenge").
@immutable
class LinkCardModel {
  const LinkCardModel({
    required this.id,
    required this.title,
    required this.ctaLabel,
    this.imageAsset,
    this.imageUrl,
  });

  final String id;

  /// Headline shown over the image.
  final String title;

  /// Label for the call-to-action pill button.
  final String ctaLabel;

  /// Optional bundled image asset. Preferred over [imageUrl].
  final String? imageAsset;

  /// Optional remote image; null (with no [imageAsset]) shows a neutral
  /// placeholder.
  final String? imageUrl;

  LinkCardModel copyWith({
    String? id,
    String? title,
    String? ctaLabel,
    String? imageAsset,
    String? imageUrl,
  }) {
    return LinkCardModel(
      id: id ?? this.id,
      title: title ?? this.title,
      ctaLabel: ctaLabel ?? this.ctaLabel,
      imageAsset: imageAsset ?? this.imageAsset,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is LinkCardModel &&
        other.id == id &&
        other.title == title &&
        other.ctaLabel == ctaLabel &&
        other.imageAsset == imageAsset &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode =>
      Object.hash(id, title, ctaLabel, imageAsset, imageUrl);
}

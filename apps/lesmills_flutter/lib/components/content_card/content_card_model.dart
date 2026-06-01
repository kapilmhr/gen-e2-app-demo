import 'package:flutter/foundation.dart';

/// Immutable data for a [ContentCard] — an editorial / "In Motion" story tile.
@immutable
class ContentCardModel {
  const ContentCardModel({
    required this.id,
    required this.title,
    required this.description,
    this.imageAsset,
    this.imageUrl,
  });

  /// Stable identifier for keys and analytics.
  final String id;

  /// Story headline.
  final String title;

  /// Short supporting summary.
  final String description;

  /// Optional bundled image asset. Preferred over [imageUrl].
  final String? imageAsset;

  /// Optional remote image. When both this and [imageAsset] are null a neutral
  /// placeholder is shown so the widget renders deterministically offline.
  final String? imageUrl;

  ContentCardModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageAsset,
    String? imageUrl,
  }) {
    return ContentCardModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageAsset: imageAsset ?? this.imageAsset,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ContentCardModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.imageAsset == imageAsset &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode =>
      Object.hash(id, title, description, imageAsset, imageUrl);
}

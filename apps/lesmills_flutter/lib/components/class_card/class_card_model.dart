import 'package:flutter/foundation.dart';

/// Immutable data for a [ClassCard] — a Group Fitness class tile.
@immutable
class ClassCardModel {
  const ClassCardModel({
    required this.id,
    required this.name,
    required this.intensity,
    this.maxIntensity = 5,
    this.imageAsset,
    this.imageUrl,
  }) : assert(
          intensity >= 0 && intensity <= maxIntensity,
          'intensity must be between 0 and maxIntensity',
        );

  final String id;

  /// Class name shown in the label chip (e.g. "The Trip").
  final String name;

  /// Intensity level (filled droplets).
  final int intensity;

  /// Intensity scale maximum.
  final int maxIntensity;

  /// Optional bundled image asset. Preferred over [imageUrl].
  final String? imageAsset;

  /// Optional remote image; null (with no [imageAsset]) shows a neutral
  /// placeholder.
  final String? imageUrl;

  ClassCardModel copyWith({
    String? id,
    String? name,
    int? intensity,
    int? maxIntensity,
    String? imageAsset,
    String? imageUrl,
  }) {
    return ClassCardModel(
      id: id ?? this.id,
      name: name ?? this.name,
      intensity: intensity ?? this.intensity,
      maxIntensity: maxIntensity ?? this.maxIntensity,
      imageAsset: imageAsset ?? this.imageAsset,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ClassCardModel &&
        other.id == id &&
        other.name == name &&
        other.intensity == intensity &&
        other.maxIntensity == maxIntensity &&
        other.imageAsset == imageAsset &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode =>
      Object.hash(id, name, intensity, maxIntensity, imageAsset, imageUrl);
}

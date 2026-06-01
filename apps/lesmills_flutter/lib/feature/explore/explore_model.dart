import 'package:flutter/foundation.dart';

import '../../components/class_card/class_card_model.dart';
import '../../components/content_card/content_card_model.dart';
import '../../components/link_card/link_card_model.dart';

/// A labelled horizontal carousel of discovery tiles (e.g. "New In",
/// "Classes", "Collections").
@immutable
class DiscoveryCarousel {
  const DiscoveryCarousel({
    required this.id,
    required this.label,
    required this.items,
    this.hasError = false,
  });

  final String id;
  final String label;
  final List<ContentCardModel> items;

  /// When true this carousel failed to load and renders an inline error
  /// placeholder, so a single failure never blanks the whole page.
  final bool hasError;

  @override
  bool operator ==(Object other) =>
      other is DiscoveryCarousel &&
      other.id == id &&
      other.label == label &&
      other.hasError == hasError &&
      listEquals(other.items, items);

  @override
  int get hashCode => Object.hash(id, label, hasError, Object.hashAll(items));
}

/// Immutable data backing the Explore screen.
@immutable
class ExploreData {
  const ExploreData({
    required this.headerImageAsset,
    required this.headerImageUrl,
    required this.promo,
    required this.personalTraining,
    required this.discoveryCarousels,
    required this.groupFitnessClasses,
    required this.closingCard,
  });

  final String? headerImageAsset;
  final String? headerImageUrl;

  /// Top promotional link card (e.g. Les Mills playlists).
  final LinkCardModel promo;

  /// Personal-training promotional link card.
  final LinkCardModel personalTraining;

  /// "Les Mills At Home" discovery carousels (New In / Classes / Collections).
  final List<DiscoveryCarousel> discoveryCarousels;

  /// Group-fitness class tiles.
  final List<ClassCardModel> groupFitnessClasses;

  /// Closing promotional link card (e.g. Club details).
  final LinkCardModel closingCard;

  @override
  bool operator ==(Object other) =>
      other is ExploreData &&
      other.headerImageAsset == headerImageAsset &&
      other.headerImageUrl == headerImageUrl &&
      other.promo == promo &&
      other.personalTraining == personalTraining &&
      listEquals(other.discoveryCarousels, discoveryCarousels) &&
      listEquals(other.groupFitnessClasses, groupFitnessClasses) &&
      other.closingCard == closingCard;

  @override
  int get hashCode => Object.hash(
        headerImageAsset,
        headerImageUrl,
        promo,
        personalTraining,
        Object.hashAll(discoveryCarousels),
        Object.hashAll(groupFitnessClasses),
        closingCard,
      );
}

/// Exhaustive UI state for the Explore screen.
sealed class ExploreState {
  const ExploreState();
}

class ExploreIdle extends ExploreState {
  const ExploreIdle();
}

class ExploreLoading extends ExploreState {
  const ExploreLoading();
}

class ExploreLoaded extends ExploreState {
  const ExploreLoaded(this.data);

  final ExploreData data;
}

class ExploreEmpty extends ExploreState {
  const ExploreEmpty();
}

class ExploreError extends ExploreState {
  const ExploreError(this.message);

  final String message;
}

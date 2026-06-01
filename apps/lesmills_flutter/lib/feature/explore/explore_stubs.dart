import '../../components/class_card/class_card_model.dart';
import '../../components/content_card/content_card_model.dart';
import '../../components/link_card/link_card_model.dart';
import '../../l10n/app_strings.dart';
import 'explore_model.dart';

/// Deterministic, offline sample data for the Explore screen. Images are real
/// exported Figma assets bundled under assets/images; the group-fitness class
/// photos are reused from the Home screen's assets.
abstract final class ExploreStubs {
  static const String _images = 'assets/images';

  static const LinkCardModel _promo = LinkCardModel(
    id: 'promo-playlists',
    title: 'Listen to Les Mills playlists',
    ctaLabel: 'Open in Spotify',
    imageAsset: '$_images/explore_playlists.png',
  );

  static const LinkCardModel _personalTraining = LinkCardModel(
    id: 'promo-personal-training',
    title: 'Get 2 sessions for \$49',
    ctaLabel: 'Find out more',
    imageAsset: '$_images/explore_personal_training.png',
  );

  static const LinkCardModel _closing = LinkCardModel(
    id: 'promo-club-details',
    title: 'Club details',
    ctaLabel: 'View clubs',
    imageAsset: '$_images/explore_club_details.png',
  );

  static const List<DiscoveryCarousel> _carousels = [
    DiscoveryCarousel(
      id: 'new-in',
      label: AppStrings.exploreNewInLabel,
      items: [
        ContentCardModel(
          id: 'shbam-51',
          title: "SH'BAM 51",
          description: 'Fun-loving and insanely addictive dance workout',
          imageAsset: '$_images/content_shbam51.png',
        ),
        ContentCardModel(
          id: 'shbam-51-express',
          title: "SH'BAM 51 - Express",
          description: 'Fun-loving and insanely addictive dance workout',
          imageAsset: '$_images/content_shbam51_express.png',
        ),
        ContentCardModel(
          id: 'grit-strength-44',
          title: 'Grit Strength 44',
          description: 'High Intensity Interval Training',
          imageAsset: '$_images/content_grit_strength_44.png',
        ),
      ],
    ),
    DiscoveryCarousel(
      id: 'classes',
      label: AppStrings.exploreClassesLabel,
      items: [
        ContentCardModel(
          id: 'the-trip',
          title: 'The Trip',
          description: 'Immersive cinematic indoor cycling',
          imageAsset: '$_images/content_the_trip.png',
        ),
        ContentCardModel(
          id: 'bodypump',
          title: 'Bodypump',
          description: 'Barbell strength for every muscle group',
          imageAsset: '$_images/content_bodypump.png',
        ),
      ],
    ),
    DiscoveryCarousel(
      id: 'collections',
      label: AppStrings.exploreCollectionsLabel,
      items: [
        ContentCardModel(
          id: 'short-sweat',
          title: 'Short + Sweat',
          description: 'Short, sharp workouts to get you sweating',
          imageAsset: '$_images/content_short_sweat.png',
        ),
        ContentCardModel(
          id: 'take-a-breathe',
          title: 'Take a Breathe',
          description: 'Discover breath work with these mindful workouts.',
          imageAsset: '$_images/content_take_a_breathe.png',
        ),
        ContentCardModel(
          id: 'no-equipment',
          title: 'No equipment, no worries',
          description: 'Workouts you can do anywhere with zero equipment '
              'needed!',
          imageAsset: '$_images/content_no_equipment.png',
        ),
        ContentCardModel(
          id: 'wellness',
          title: 'Wellness',
          description: 'Explore wellness in this collection',
          imageAsset: '$_images/content_wellness.png',
        ),
      ],
    ),
  ];

  static const List<ClassCardModel> _groupFitnessClasses = [
    ClassCardModel(
      id: 'gf-the-trip',
      name: 'The Trip',
      intensity: 5,
      imageAsset: '$_images/class_the_trip.png',
    ),
    ClassCardModel(
      id: 'gf-conquer',
      name: 'Conquer',
      intensity: 4,
      imageAsset: '$_images/class_conquer.png',
    ),
    ClassCardModel(
      id: 'gf-bodybalance',
      name: 'Bodybalance',
      intensity: 2,
      imageAsset: '$_images/class_bodybalance.png',
    ),
  ];

  static const ExploreData _data = ExploreData(
    headerImageAsset: '$_images/explore_header.png',
    headerImageUrl: null,
    promo: _promo,
    personalTraining: _personalTraining,
    discoveryCarousels: _carousels,
    groupFitnessClasses: _groupFitnessClasses,
    closingCard: _closing,
  );

  static ExploreData get loaded => _data;

  static const ExploreState loadedState = ExploreLoaded(_data);
  static const ExploreState loadingState = ExploreLoading();
  static const ExploreState emptyState = ExploreEmpty();
  static const ExploreState errorState =
      ExploreError(AppStrings.exploreErrorTitle);

  /// One carousel ("Classes") failed while the rest of the page loaded — used
  /// to demonstrate independent per-carousel degradation.
  static const ExploreData _degradedData = ExploreData(
    headerImageAsset: '$_images/explore_header.png',
    headerImageUrl: null,
    promo: _promo,
    personalTraining: _personalTraining,
    discoveryCarousels: [
      DiscoveryCarousel(
        id: 'new-in',
        label: AppStrings.exploreNewInLabel,
        items: [
          ContentCardModel(
            id: 'shbam-51',
            title: "SH'BAM 51",
            description: 'Fun-loving and insanely addictive dance workout',
            imageAsset: '$_images/content_shbam51.png',
          ),
        ],
      ),
      DiscoveryCarousel(
        id: 'classes',
        label: AppStrings.exploreClassesLabel,
        items: [],
        hasError: true,
      ),
    ],
    groupFitnessClasses: _groupFitnessClasses,
    closingCard: _closing,
  );

  static const ExploreState degradedState = ExploreLoaded(_degradedData);
}

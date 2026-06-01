import 'content_card_model.dart';

/// Deterministic, offline sample data for [ContentCard] previews and tests.
///
/// Image URLs are intentionally null so previews and tests never depend on the
/// network and Figma asset expiry cannot break them.
abstract final class ContentCardStubs {
  ContentCardStubs._();

  static const ContentCardModel loaded = ContentCardModel(
    id: 'wellness-day',
    title: 'Global wellness day',
    description: 'Come along and celebrate with us at your local club.',
  );

  static const ContentCardModel longContent = ContentCardModel(
    id: 'reo-maori',
    title: 'Gearing up for te wiki o te reo Māori week!',
    description:
        'You might spot a few changes around the club as we celebrate the '
        'Māori language together throughout the week.',
  );

  static const List<ContentCardModel> list = [
    loaded,
    longContent,
    ContentCardModel(
      id: 'level-up-lunge',
      title: 'Level up your lunge',
      description: '3 ways you can lift your lunge game.',
    ),
  ];
}

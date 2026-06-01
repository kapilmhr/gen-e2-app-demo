import 'link_card_model.dart';

/// Deterministic, offline sample data for [LinkCard] previews and tests.
abstract final class LinkCardStubs {
  LinkCardStubs._();

  static const LinkCardModel loaded = LinkCardModel(
    id: 'kickstart-challenge',
    title: '6-week Kickstart Challenge',
    ctaLabel: 'Explore challenge',
  );

  static const LinkCardModel referFriend = LinkCardModel(
    id: 'bring-a-friend',
    title: 'Bring a friend for free',
    ctaLabel: 'Share invite',
  );

  static const LinkCardModel longContent = LinkCardModel(
    id: 'long',
    title: 'Join the nationwide 6-week Kickstart Challenge this winter',
    ctaLabel: 'Explore the full challenge',
  );

  static const List<LinkCardModel> list = [loaded, referFriend];
}

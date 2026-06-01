import 'class_card_model.dart';

/// Deterministic, offline sample data for [ClassCard] previews and tests.
abstract final class ClassCardStubs {
  ClassCardStubs._();

  static const ClassCardModel loaded = ClassCardModel(
    id: 'the-trip',
    name: 'The Trip',
    intensity: 4,
  );

  static const ClassCardModel maxIntensity = ClassCardModel(
    id: 'conquer',
    name: 'Conquer',
    intensity: 5,
  );

  static const ClassCardModel lowIntensity = ClassCardModel(
    id: 'bodybalance',
    name: 'BodyBalance',
    intensity: 2,
  );

  static const ClassCardModel longContent = ClassCardModel(
    id: 'long',
    name: 'BodyBalance Restorative Flow',
    intensity: 1,
  );

  static const List<ClassCardModel> list = [
    loaded,
    maxIntensity,
    lowIntensity,
  ];
}

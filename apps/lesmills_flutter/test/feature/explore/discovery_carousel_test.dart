import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lesmills_flutter/components/content_card/content_card.dart';
import 'package:lesmills_flutter/components/content_card/content_card_model.dart';
import 'package:lesmills_flutter/feature/explore/widgets/discovery_carousel.dart';
import 'package:lesmills_flutter/theme/app_theme.dart';

Widget _host(Widget child) => MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(body: child),
    );

const _items = [
  ContentCardModel(id: 'a', title: 'Alpha', description: 'First card'),
  ContentCardModel(id: 'b', title: 'Bravo', description: 'Second card'),
  ContentCardModel(id: 'c', title: 'Charlie', description: 'Third card'),
  ContentCardModel(id: 'd', title: 'Delta', description: 'Fourth card'),
];

void main() {
  group('DiscoveryCarouselView', () {
    testWidgets('renders the label and its cards', (tester) async {
      await tester.pumpWidget(
        _host(const DiscoveryCarouselView(label: 'New In', items: _items)),
      );

      expect(find.text('NEW IN'), findsOneWidget);
      expect(find.text('ALPHA'), findsOneWidget);
    });

    testWidgets('tapping a card fires onItemTap with the model',
        (tester) async {
      ContentCardModel? tapped;
      await tester.pumpWidget(
        _host(DiscoveryCarouselView(
          label: 'New In',
          items: _items,
          onItemTap: (item) => tapped = item,
        )),
      );

      await tester.tap(find.text('ALPHA'));
      expect(tapped?.id, 'a');
    });

    testWidgets('scrolls horizontally to reveal off-screen cards',
        (tester) async {
      await tester.pumpWidget(
        _host(const DiscoveryCarouselView(label: 'New In', items: _items)),
      );

      // Last card starts off-screen on a default-width surface.
      await tester.drag(find.byType(ContentCard).first, const Offset(-600, 0));
      await tester.pumpAndSettle();

      expect(find.text('DELTA'), findsOneWidget);
    });

    testWidgets('renders an inline error placeholder when hasError is true',
        (tester) async {
      await tester.pumpWidget(
        _host(const DiscoveryCarouselView(
          label: 'New In',
          items: [],
          hasError: true,
        )),
      );

      expect(find.byType(ContentCard), findsNothing);
      expect(
        find.text('We couldn’t load this. Try again later.'),
        findsOneWidget,
      );
    });
  });
}

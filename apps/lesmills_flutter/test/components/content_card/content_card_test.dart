import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lesmills_flutter/components/content_card/content_card.dart';
import 'package:lesmills_flutter/components/content_card/content_card_stubs.dart';
import 'package:lesmills_flutter/theme/app_theme.dart';

Widget _host(Widget child) => MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(body: Center(child: child)),
    );

void main() {
  group('ContentCard', () {
    testWidgets('renders the title in uppercase and the description',
        (tester) async {
      await tester.pumpWidget(
        _host(ContentCard(model: ContentCardStubs.loaded, onTap: () {})),
      );
      expect(find.text('GLOBAL WELLNESS DAY'), findsOneWidget);
      expect(
        find.text('Come along and celebrate with us at your local club.'),
        findsOneWidget,
      );
    });

    testWidgets('invokes onTap when tapped', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        _host(ContentCard(model: ContentCardStubs.loaded, onTap: () => taps++)),
      );
      await tester.tap(find.byType(ContentCard));
      expect(taps, 1);
    });
  });
}

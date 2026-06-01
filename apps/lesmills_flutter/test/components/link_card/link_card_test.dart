import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lesmills_flutter/components/link_card/link_card.dart';
import 'package:lesmills_flutter/components/link_card/link_card_stubs.dart';
import 'package:lesmills_flutter/components/pill_button/pill_button.dart';
import 'package:lesmills_flutter/theme/app_theme.dart';

Widget _host(Widget child) => MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(body: Center(child: child)),
    );

void main() {
  group('LinkCard', () {
    testWidgets('renders the title in uppercase and the CTA label',
        (tester) async {
      await tester.pumpWidget(
        _host(LinkCard(model: LinkCardStubs.loaded, onPressed: () {})),
      );

      expect(find.text('6-WEEK KICKSTART CHALLENGE'), findsOneWidget);
      expect(find.text('Explore challenge'), findsOneWidget);
    });

    testWidgets('invokes onPressed when the CTA is tapped', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        _host(LinkCard(model: LinkCardStubs.loaded, onPressed: () => taps++)),
      );

      await tester.tap(find.byType(PillButton));
      expect(taps, 1);
    });

    testWidgets('exposes the title as the card semantics label', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _host(LinkCard(model: LinkCardStubs.loaded, onPressed: () {})),
      );

      expect(
        find.bySemanticsLabel(RegExp('Kickstart Challenge')),
        findsOneWidget,
      );
      handle.dispose();
    });
  });
}

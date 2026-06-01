import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lesmills_flutter/components/class_card/class_card.dart';
import 'package:lesmills_flutter/components/class_card/class_card_stubs.dart';
import 'package:lesmills_flutter/theme/app_theme.dart';

Widget _host(Widget child) => MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(body: Center(child: child)),
    );

void main() {
  group('ClassCard', () {
    testWidgets('renders the class name', (tester) async {
      await tester.pumpWidget(
        _host(ClassCard(model: ClassCardStubs.loaded, onTap: () {})),
      );
      expect(find.text('The Trip'), findsOneWidget);
    });

    testWidgets('exposes name and intensity to assistive tech', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _host(ClassCard(model: ClassCardStubs.loaded, onTap: () {})),
      );
      final semantics =
          tester.getSemantics(find.bySemanticsLabel('The Trip class'));
      expect(semantics.value, '4 out of 5');
      handle.dispose();
    });

    testWidgets('invokes onTap when tapped', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        _host(ClassCard(model: ClassCardStubs.loaded, onTap: () => taps++)),
      );
      await tester.tap(find.byType(ClassCard));
      expect(taps, 1);
    });
  });
}

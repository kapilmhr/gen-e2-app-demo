import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lesmills_flutter/components/pill_button/pill_button.dart';
import 'package:lesmills_flutter/theme/app_theme.dart';

Widget _host(Widget child) => MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(body: Center(child: child)),
    );

void main() {
  group('PillButton', () {
    testWidgets('renders its label', (tester) async {
      await tester.pumpWidget(_host(PillButton(label: 'Scan in', onPressed: () {})));
      expect(find.text('Scan in'), findsOneWidget);
    });

    testWidgets('invokes onPressed when tapped', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        _host(PillButton(label: 'Scan in', onPressed: () => taps++)),
      );
      await tester.tap(find.byType(PillButton));
      expect(taps, 1);
    });

    testWidgets('is disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(_host(const PillButton(label: 'Scan in')));
      final inkWell = tester.widget<InkWell>(
        find.descendant(
          of: find.byType(PillButton),
          matching: find.byType(InkWell),
        ),
      );
      expect(inkWell.onTap, isNull);
    });

    testWidgets('meets minimum tap target size', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _host(PillButton(label: 'Scan in', onPressed: () {})),
      );
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      handle.dispose();
    });
  });
}

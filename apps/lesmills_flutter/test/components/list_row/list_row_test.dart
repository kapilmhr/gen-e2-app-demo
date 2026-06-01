import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lesmills_flutter/components/list_row/list_row.dart';
import 'package:lesmills_flutter/components/list_row/list_row_model.dart';
import 'package:lesmills_flutter/theme/app_theme.dart';

Widget _host(Widget child) => MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(body: child),
    );

const _model = ListRowModel(id: 'terms', title: 'Terms of use');

void main() {
  group('ListRow', () {
    testWidgets('renders its title and a chevron', (tester) async {
      await tester.pumpWidget(_host(const ListRow(model: _model)));

      expect(find.text('Terms of use'), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('tapping the row fires onTap', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        _host(ListRow(model: _model, onTap: () => taps++)),
      );

      await tester.tap(find.byType(ListRow));
      expect(taps, 1);
    });

    testWidgets('exposes a single button semantics with the title',
        (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _host(ListRow(model: _model, onTap: () {})),
      );

      expect(find.bySemanticsLabel('Terms of use'), findsOneWidget);
      handle.dispose();
    });

    testWidgets('mirrors the chevron under RTL', (tester) async {
      await tester.pumpWidget(
        _host(const Directionality(
          textDirection: TextDirection.rtl,
          child: ListRow(model: _model),
        )),
      );

      expect(find.byIcon(Icons.chevron_left), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsNothing);
    });

    testWidgets('meets the 48px minimum tap target', (tester) async {
      await tester.pumpWidget(
        _host(ListRow(model: _model, onTap: () {})),
      );

      final size = tester.getSize(find.byType(ListRow));
      expect(size.height, greaterThanOrEqualTo(48));
    });
  });
}

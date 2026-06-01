import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lesmills_flutter/components/page_header/page_header.dart';
import 'package:lesmills_flutter/theme/app_theme.dart';

Widget _host(Widget child) => MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(body: child),
    );

void main() {
  group('PageHeader', () {
    testWidgets('renders the title in uppercase', (tester) async {
      await tester.pumpWidget(_host(const PageHeader(title: 'Progress')));
      expect(find.text('PROGRESS'), findsOneWidget);
    });

    testWidgets('marks the title as a header for assistive tech',
        (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(_host(const PageHeader(title: 'Progress')));
      final data =
          tester.getSemantics(find.text('PROGRESS')).getSemanticsData();
      expect(data.flagsCollection.isHeader, isTrue);
      handle.dispose();
    });

    testWidgets('renders without an image (offline placeholder)',
        (tester) async {
      await tester.pumpWidget(_host(const PageHeader(title: 'Explore')));
      expect(tester.takeException(), isNull);
      expect(find.text('EXPLORE'), findsOneWidget);
    });
  });
}

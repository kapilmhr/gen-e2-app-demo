import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lesmills_flutter/components/section_header/section_header.dart';
import 'package:lesmills_flutter/theme/app_theme.dart';

Widget _host(Widget child) => MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(body: child),
    );

void main() {
  group('SectionHeader', () {
    testWidgets('renders the title in uppercase', (tester) async {
      await tester.pumpWidget(_host(const SectionHeader(title: 'In Motion')));
      expect(find.text('IN MOTION'), findsOneWidget);
    });

    testWidgets('omits the description when not provided', (tester) async {
      await tester.pumpWidget(_host(const SectionHeader(title: 'In Motion')));
      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('renders the description when provided', (tester) async {
      await tester.pumpWidget(
        _host(const SectionHeader(title: 'Activity', description: 'Keep going')),
      );
      expect(find.text('Keep going'), findsOneWidget);
    });

    testWidgets('marks the title as a header for assistive tech',
        (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(_host(const SectionHeader(title: 'In Motion')));
      final data =
          tester.getSemantics(find.text('IN MOTION')).getSemanticsData();
      expect(data.flagsCollection.isHeader, isTrue);
      handle.dispose();
    });
  });
}

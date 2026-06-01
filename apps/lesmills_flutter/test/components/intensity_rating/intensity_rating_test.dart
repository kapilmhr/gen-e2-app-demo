import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lesmills_flutter/components/intensity_rating/intensity_rating.dart';
import 'package:lesmills_flutter/theme/app_theme.dart';

Widget _host(Widget child) => MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(body: Center(child: child)),
    );

void main() {
  group('IntensityRating', () {
    testWidgets('exposes its level as an accessible value', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(_host(const IntensityRating(level: 4)));
      final semantics =
          tester.getSemantics(find.bySemanticsLabel('Workout intensity'));
      expect(semantics.value, '4 out of 5');
      handle.dispose();
    });

    testWidgets('renders the requested number of filled droplets',
        (tester) async {
      await tester.pumpWidget(_host(const IntensityRating(level: 2)));
      expect(find.byIcon(Icons.water_drop), findsNWidgets(2));
      expect(find.byIcon(Icons.water_drop_outlined), findsNWidgets(3));
    });

    testWidgets('supports a custom maximum', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(_host(const IntensityRating(level: 1, max: 3)));
      final semantics =
          tester.getSemantics(find.bySemanticsLabel('Workout intensity'));
      expect(semantics.value, '1 out of 3');
      handle.dispose();
    });
  });
}

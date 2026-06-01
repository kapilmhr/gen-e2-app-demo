import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lesmills_flutter/feature/progress/progress_screen.dart';
import 'package:lesmills_flutter/feature/progress/progress_stubs.dart';
import 'package:lesmills_flutter/theme/app_theme.dart';

Widget _host(Widget child) => MaterialApp(theme: AppTheme.light, home: child);

void main() {
  group('ProgressScreen', () {
    testWidgets('loaded state renders the key sections', (tester) async {
      // Tall surface so the lazily-built sections are all laid out.
      tester.view.physicalSize = const Size(390, 4000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        _host(const ProgressScreen(initialState: ProgressStubs.loadedState)),
      );

      expect(find.text('PROGRESS'), findsOneWidget);
      expect(find.text('4 WEEK SUMMARY'), findsOneWidget);
      expect(find.text('BADGES EARNED'), findsOneWidget);
      expect(find.text('WORKOUT TIPS'), findsOneWidget);
      expect(find.text('VIEW WORKOUTS'), findsOneWidget);
    });

    testWidgets('exposes a per-week streak summary for assistive tech',
        (tester) async {
      tester.view.physicalSize = const Size(390, 4000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _host(const ProgressScreen(initialState: ProgressStubs.loadedState)),
      );

      expect(
        find.bySemanticsLabel(RegExp('3 workouts completed')),
        findsWidgets,
      );
      handle.dispose();
    });

    testWidgets('empty state shows the empty message', (tester) async {
      await tester.pumpWidget(
        _host(const ProgressScreen(initialState: ProgressStubs.emptyState)),
      );
      expect(find.text('No progress yet'), findsOneWidget);
    });

    testWidgets('error state shows a retry action that fires', (tester) async {
      var retries = 0;
      await tester.pumpWidget(
        _host(ProgressScreen(
          initialState: ProgressStubs.errorState,
          onRetry: () => retries++,
        )),
      );
      expect(find.text('TRY AGAIN'), findsOneWidget);
      await tester.tap(find.text('TRY AGAIN'));
      expect(retries, 1);
    });
  });
}

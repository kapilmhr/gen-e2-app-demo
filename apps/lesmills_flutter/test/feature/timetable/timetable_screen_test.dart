import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lesmills_flutter/feature/timetable/timetable_screen.dart';
import 'package:lesmills_flutter/feature/timetable/timetable_stubs.dart';
import 'package:lesmills_flutter/theme/app_theme.dart';

Widget _host(Widget child) => MaterialApp(theme: AppTheme.light, home: child);

void main() {
  group('TimetableScreen', () {
    testWidgets('loaded state renders header, filter and classes',
        (tester) async {
      tester.view.physicalSize = const Size(390, 4000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        _host(const TimetableScreen(initialState: TimetableStubs.loadedState)),
      );

      expect(find.text('Club Timetable'), findsOneWidget);
      expect(find.text('MARCH'), findsOneWidget);
      expect(find.text('Auckland City'), findsOneWidget);
      expect(find.text('Morning'), findsOneWidget);
      expect(find.text('CEREMONY'), findsWidgets);
      expect(find.text('Book now'), findsWidgets);
      expect(find.text('Booked'), findsOneWidget);
    });

    testWidgets('exposes accessible labels for class sessions',
        (tester) async {
      tester.view.physicalSize = const Size(390, 4000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _host(const TimetableScreen(initialState: TimetableStubs.loadedState)),
      );

      expect(
        find.bySemanticsLabel(RegExp('Ceremony at .* with Nats Levi')),
        findsWidgets,
      );
      handle.dispose();
    });

    testWidgets('empty state shows the empty message', (tester) async {
      await tester.pumpWidget(
        _host(const TimetableScreen(initialState: TimetableStubs.emptyState)),
      );
      expect(find.text('No classes scheduled'), findsOneWidget);
    });

    testWidgets('error state shows a retry action that fires', (tester) async {
      var retries = 0;
      await tester.pumpWidget(
        _host(TimetableScreen(
          initialState: TimetableStubs.errorState,
          onRetry: () => retries++,
        )),
      );
      expect(find.text('TRY AGAIN'), findsOneWidget);
      await tester.tap(find.text('TRY AGAIN'));
      expect(retries, 1);
    });
  });
}

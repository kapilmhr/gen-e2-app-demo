import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lesmills_flutter/feature/home/home_screen.dart';
import 'package:lesmills_flutter/feature/home/home_stubs.dart';
import 'package:lesmills_flutter/theme/app_theme.dart';

Widget _host(Widget child) => MaterialApp(theme: AppTheme.light, home: child);

void main() {
  group('HomeScreen', () {
    testWidgets('loaded state renders the key sections', (tester) async {
      // Tall surface so the lazily-built sections are all laid out.
      tester.view.physicalSize = const Size(390, 4000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        _host(const HomeScreen(initialState: HomeStubs.loadedState)),
      );

      expect(find.text('ACTIVITY SUMMARY'), findsOneWidget);
      expect(find.text('IN MOTION'), findsOneWidget);
      expect(find.text('EXPLORE GROUP FITNESS'), findsOneWidget);
    });

    testWidgets('empty state shows the empty message', (tester) async {
      await tester.pumpWidget(
        _host(const HomeScreen(initialState: HomeStubs.emptyState)),
      );
      expect(find.text('Nothing here yet'), findsOneWidget);
    });

    testWidgets('error state shows a retry action that fires', (tester) async {
      var retries = 0;
      await tester.pumpWidget(
        _host(HomeScreen(
          initialState: HomeStubs.errorState,
          onRetry: () => retries++,
        )),
      );
      expect(find.text('TRY AGAIN'), findsOneWidget);
      await tester.tap(find.text('TRY AGAIN'));
      expect(retries, 1);
    });
  });
}

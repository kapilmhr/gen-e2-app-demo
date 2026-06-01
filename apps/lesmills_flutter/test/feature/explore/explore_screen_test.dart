import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lesmills_flutter/feature/explore/explore_screen.dart';
import 'package:lesmills_flutter/feature/explore/explore_stubs.dart';
import 'package:lesmills_flutter/theme/app_theme.dart';

Widget _host(Widget child) => MaterialApp(theme: AppTheme.light, home: child);

void main() {
  group('ExploreScreen', () {
    testWidgets('loaded state renders header, sections and carousels',
        (tester) async {
      tester.view.physicalSize = const Size(390, 6000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        _host(const ExploreScreen(initialState: ExploreStubs.loadedState)),
      );

      expect(find.text('EXPLORE'), findsOneWidget);
      expect(find.text('PERSONAL TRAINING'), findsOneWidget);
      expect(find.text('LES MILLS AT HOME'), findsOneWidget);
      expect(find.text('NEW IN'), findsOneWidget);
      expect(find.text('COLLECTIONS'), findsOneWidget);
      expect(find.text('GROUP FITNESS'), findsOneWidget);
      expect(find.text("SH'BAM 51"), findsOneWidget);
      expect(find.text('Open in Spotify'), findsOneWidget);
    });

    testWidgets('carousel labels are exposed as semantic headers',
        (tester) async {
      tester.view.physicalSize = const Size(390, 6000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _host(const ExploreScreen(initialState: ExploreStubs.loadedState)),
      );

      expect(find.bySemanticsLabel('NEW IN'), findsWidgets);
      handle.dispose();
    });

    testWidgets('empty state shows the empty message', (tester) async {
      await tester.pumpWidget(
        _host(const ExploreScreen(initialState: ExploreStubs.emptyState)),
      );
      expect(find.text('Nothing to explore yet'), findsOneWidget);
    });

    testWidgets('loading state renders the skeleton (no content text)',
        (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _host(const ExploreScreen(initialState: ExploreStubs.loadingState)),
      );
      expect(find.bySemanticsLabel('Loading'), findsOneWidget);
      expect(find.text('EXPLORE'), findsNothing);
      handle.dispose();
    });

    testWidgets('a failed carousel degrades without blanking the page',
        (tester) async {
      tester.view.physicalSize = const Size(390, 6000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        _host(const ExploreScreen(initialState: ExploreStubs.degradedState)),
      );

      // The whole page is still present...
      expect(find.text('EXPLORE'), findsOneWidget);
      expect(find.text('NEW IN'), findsOneWidget);
      expect(find.text("SH'BAM 51"), findsOneWidget);
      // ...while the failed "Classes" carousel shows an inline error.
      expect(find.text('CLASSES'), findsOneWidget);
      expect(
        find.text('We couldn’t load this. Try again later.'),
        findsOneWidget,
      );
    });

    testWidgets('error state shows a retry action that fires', (tester) async {
      var retries = 0;
      await tester.pumpWidget(
        _host(ExploreScreen(
          initialState: ExploreStubs.errorState,
          onRetry: () => retries++,
        )),
      );
      expect(find.text('TRY AGAIN'), findsOneWidget);
      await tester.tap(find.text('TRY AGAIN'));
      expect(retries, 1);
    });
  });
}

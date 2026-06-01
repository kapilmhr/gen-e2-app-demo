import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lesmills_flutter/feature/profile/profile_screen.dart';
import 'package:lesmills_flutter/feature/profile/profile_stubs.dart';
import 'package:lesmills_flutter/theme/app_theme.dart';

Widget _host(Widget child) => MaterialApp(theme: AppTheme.light, home: child);

void main() {
  group('ProfileScreen', () {
    testWidgets('loaded state renders header, sections, version and logout',
        (tester) async {
      tester.view.physicalSize = const Size(390, 4000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        _host(const ProfileScreen(initialState: ProfileStubs.loadedState)),
      );

      expect(find.text('PROFILE'), findsOneWidget);
      expect(find.text('APP SETTINGS'), findsOneWidget);
      expect(find.text('MEMBERSHIP'), findsOneWidget);
      expect(find.text('Notification preferences'), findsOneWidget);
      expect(find.text('Manage membership'), findsOneWidget);
      expect(find.text('App version 3.304'), findsOneWidget);
      expect(find.text('LOG OUT'), findsOneWidget);
    });

    testWidgets('tapping log out fires the callback', (tester) async {
      tester.view.physicalSize = const Size(390, 4000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      var loggedOut = 0;
      await tester.pumpWidget(
        _host(ProfileScreen(
          initialState: ProfileStubs.loadedState,
          onLogout: () => loggedOut++,
        )),
      );

      await tester.ensureVisible(find.text('LOG OUT'));
      await tester.tap(find.text('LOG OUT'));
      expect(loggedOut, 1);
    });

    testWidgets('loading state renders the skeleton', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _host(const ProfileScreen(initialState: ProfileStubs.loadingState)),
      );
      expect(find.bySemanticsLabel('Loading'), findsOneWidget);
      expect(find.text('PROFILE'), findsNothing);
      handle.dispose();
    });

    testWidgets('empty state shows the empty message with a retry that fires',
        (tester) async {
      var retries = 0;
      await tester.pumpWidget(
        _host(ProfileScreen(
          initialState: ProfileStubs.emptyState,
          onRetry: () => retries++,
        )),
      );
      expect(find.text('Nothing to show yet'), findsOneWidget);
      expect(find.text('TRY AGAIN'), findsOneWidget);
      await tester.tap(find.text('TRY AGAIN'));
      expect(retries, 1);
    });

    testWidgets('error state shows a retry action that fires', (tester) async {
      var retries = 0;
      await tester.pumpWidget(
        _host(ProfileScreen(
          initialState: ProfileStubs.errorState,
          onRetry: () => retries++,
        )),
      );
      expect(find.text('TRY AGAIN'), findsOneWidget);
      await tester.tap(find.text('TRY AGAIN'));
      expect(retries, 1);
    });
  });
}

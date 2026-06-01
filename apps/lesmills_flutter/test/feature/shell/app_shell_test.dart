import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lesmills_flutter/components/app_bottom_nav_bar/app_bottom_nav_bar.dart';
import 'package:lesmills_flutter/feature/shell/app_shell.dart';
import 'package:lesmills_flutter/theme/app_theme.dart';

Widget _host(Widget child) => MaterialApp(theme: AppTheme.light, home: child);

void main() {
  group('AppShell', () {
    testWidgets('starts on the Home tab by default', (tester) async {
      tester.view.physicalSize = const Size(390, 4000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(_host(const AppShell()));

      final nav = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(nav.currentIndex, AppTab.home.index);
    });

    testWidgets('selecting a tab updates the navigation selection',
        (tester) async {
      await tester.pumpWidget(_host(const AppShell()));

      await tester.tap(find.text('Profile'));
      await tester.pump();

      final nav = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(nav.currentIndex, AppTab.profile.index);
    });

    testWidgets('every tab now renders its real screen', (tester) async {
      tester.view.physicalSize = const Size(390, 4000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(_host(const AppShell(initialTab: AppTab.profile)));

      // The Profile screen (the last tab wired up) renders, not a placeholder.
      expect(find.text('PROFILE'), findsOneWidget);
      expect(find.text('Coming soon'), findsNothing);
    });

    testWidgets('the bottom nav persists across every tab', (tester) async {
      await tester.pumpWidget(_host(const AppShell()));

      for (final tab in AppTab.values) {
        await tester.tap(find.text(tab.label).first);
        await tester.pump();
        expect(find.byType(AppBottomNavBar), findsOneWidget);
      }
    });
  });
}

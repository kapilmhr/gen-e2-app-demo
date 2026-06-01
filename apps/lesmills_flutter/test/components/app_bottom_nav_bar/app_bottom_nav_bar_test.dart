import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lesmills_flutter/components/app_bottom_nav_bar/app_bottom_nav_bar.dart';
import 'package:lesmills_flutter/theme/app_theme.dart';

Widget _host(Widget child) => MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(bottomNavigationBar: child),
    );

void main() {
  group('AppBottomNavBar', () {
    testWidgets('renders all five destinations', (tester) async {
      await tester.pumpWidget(
        _host(const AppBottomNavBar(currentTab: AppTab.home)),
      );
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Progress'), findsOneWidget);
      expect(find.text('Timetable'), findsOneWidget);
      expect(find.text('Explore'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('reports the selected tab', (tester) async {
      AppTab? selected;
      await tester.pumpWidget(
        _host(AppBottomNavBar(
          currentTab: AppTab.home,
          onTabSelected: (tab) => selected = tab,
        )),
      );
      await tester.tap(find.text('Timetable'));
      expect(selected, AppTab.timetable);
    });
  });
}

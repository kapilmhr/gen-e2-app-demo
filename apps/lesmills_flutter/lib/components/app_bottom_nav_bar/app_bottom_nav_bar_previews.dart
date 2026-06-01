import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../theme/app_theme.dart';
import 'app_bottom_nav_bar.dart';

@Preview(name: 'Home selected')
Widget navHome() => _wrap(const AppBottomNavBar(currentTab: AppTab.home));

@Preview(name: 'Timetable selected')
Widget navTimetable() =>
    _wrap(const AppBottomNavBar(currentTab: AppTab.timetable));

@Preview(name: 'Profile selected')
Widget navProfile() => _wrap(const AppBottomNavBar(currentTab: AppTab.profile));

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget navDark() => _wrap(const AppBottomNavBar(currentTab: AppTab.home));

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget navLargeText() => _wrap(const AppBottomNavBar(currentTab: AppTab.home));

@Preview(name: 'RTL')
Widget navRtl() => _wrap(
      const Directionality(
        textDirection: TextDirection.rtl,
        child: AppBottomNavBar(currentTab: AppTab.home),
      ),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(bottomNavigationBar: child),
    );

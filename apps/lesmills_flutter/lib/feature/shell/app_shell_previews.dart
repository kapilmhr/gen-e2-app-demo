import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../components/app_bottom_nav_bar/app_bottom_nav_bar.dart';
import '../../theme/app_theme.dart';
import 'app_shell.dart';

@Preview(name: 'Default (Home tab)')
Widget shellHome() => _wrap(const AppShell());

@Preview(name: 'Progress tab')
Widget shellProgress() => _wrap(const AppShell(initialTab: AppTab.progress));

@Preview(name: 'Timetable tab')
Widget shellTimetable() => _wrap(const AppShell(initialTab: AppTab.timetable));

@Preview(name: 'Explore tab')
Widget shellExplore() => _wrap(const AppShell(initialTab: AppTab.explore));

@Preview(name: 'Profile tab')
Widget shellProfile() => _wrap(const AppShell(initialTab: AppTab.profile));

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget shellLargeText() => _wrap(const AppShell(initialTab: AppTab.progress));

@Preview(name: 'RTL')
Widget shellRtl() => _wrap(
      const Directionality(
        textDirection: TextDirection.rtl,
        child: AppShell(),
      ),
    );

@Preview(name: 'Narrow width')
Widget shellNarrow() => _wrap(
      const SizedBox(width: 320, child: AppShell()),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: child,
    );

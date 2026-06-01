import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../components/app_bottom_nav_bar/app_bottom_nav_bar.dart';
import '../../theme/preview_support.dart';
import 'app_shell.dart';

@Preview(name: 'Default (Home tab)', size: phoneSize, theme: previewTheme)
Widget shellHome() => const AppShell();

@Preview(name: 'Progress tab', size: phoneSize, theme: previewTheme)
Widget shellProgress() => const AppShell(initialTab: AppTab.progress);

@Preview(name: 'Timetable tab', size: phoneSize, theme: previewTheme)
Widget shellTimetable() => const AppShell(initialTab: AppTab.timetable);

@Preview(name: 'Explore tab', size: phoneSize, theme: previewTheme)
Widget shellExplore() => const AppShell(initialTab: AppTab.explore);

@Preview(name: 'Profile tab', size: phoneSize, theme: previewTheme)
Widget shellProfile() => const AppShell(initialTab: AppTab.profile);

@Preview(
  name: 'Large text',
  size: phoneSize,
  theme: previewTheme,
  textScaleFactor: 2.0,
)
Widget shellLargeText() => const AppShell(initialTab: AppTab.progress);

@Preview(name: 'RTL', size: phoneSize, theme: previewTheme)
Widget shellRtl() => const Directionality(
      textDirection: TextDirection.rtl,
      child: AppShell(),
    );

@Preview(name: 'Narrow width', size: phoneSize, theme: previewTheme)
Widget shellNarrow() => const SizedBox(width: 320, child: AppShell());

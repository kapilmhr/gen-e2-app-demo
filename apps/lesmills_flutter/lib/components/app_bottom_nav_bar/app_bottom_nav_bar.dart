import 'package:flutter/material.dart';

import '../../l10n/app_strings.dart';

/// The primary destinations of the Les Mills member app.
enum AppTab {
  home(AppStrings.navHome, Icons.home_outlined, Icons.home),
  progress(AppStrings.navProgress, Icons.insights_outlined, Icons.insights),
  timetable(
    AppStrings.navTimetable,
    Icons.calendar_today_outlined,
    Icons.calendar_today,
  ),
  explore(AppStrings.navExplore, Icons.explore_outlined, Icons.explore),
  profile(AppStrings.navProfile, Icons.person_outline, Icons.person);

  const AppTab(this.label, this.icon, this.selectedIcon);

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

/// Fixed five-destination bottom navigation bar, shared across the app's
/// top-level screens. Styling comes from `BottomNavigationBarThemeData` in
/// [AppTheme] — this widget only maps [AppTab] values to items.
@immutable
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentTab,
    this.onTabSelected,
  });

  final AppTab currentTab;
  final ValueChanged<AppTab>? onTabSelected;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentTab.index,
      onTap: onTabSelected == null
          ? null
          : (index) => onTabSelected!(AppTab.values[index]),
      items: [
        for (final tab in AppTab.values)
          BottomNavigationBarItem(
            icon: Icon(tab.icon),
            activeIcon: Icon(tab.selectedIcon),
            label: tab.label,
            tooltip: tab.label,
          ),
      ],
    );
  }
}

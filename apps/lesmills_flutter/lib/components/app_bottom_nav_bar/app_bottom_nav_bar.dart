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
    final bar = BottomNavigationBar(
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

    // Flutter's BottomNavigationBar uses MergeSemantics internally, which
    // produces labels like "Timetable\nTab 3 of 5". Maestro's tapOn:text:
    // does an anchored regex match so "Timetable" won't match that string.
    // Fix: exclude the bar's built-in semantics and overlay a Row of clean
    // Semantics nodes — one per tab — each carrying only the plain label.
    return Stack(
      children: [
        ExcludeSemantics(child: bar),
        Positioned.fill(
          child: Row(
            children: [
              for (final tab in AppTab.values)
                Expanded(
                  child: Semantics(
                    label: tab.label,
                    button: true,
                    selected: currentTab == tab,
                    onTap: onTabSelected == null ? null : () => onTabSelected!(tab),
                    child: const SizedBox.expand(),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

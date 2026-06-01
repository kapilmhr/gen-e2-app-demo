import 'package:flutter/material.dart';

import '../../components/app_bottom_nav_bar/app_bottom_nav_bar.dart';
import '../home/home_screen.dart';
import '../progress/progress_screen.dart';
import '../timetable/timetable_screen.dart';
import '../explore/explore_screen.dart';
import '../profile/profile_screen.dart';

/// The app's main shell: a persistent five-destination bottom navigation bar
/// hosting one body per tab.
///
/// Tab bodies are kept alive in an [IndexedStack] so each tab preserves its
/// own scroll position when the member switches away and back. [AppTab.home]
/// is selected on first render.
class AppShell extends StatefulWidget {
  const AppShell({super.key, this.initialTab = AppTab.home});

  final AppTab initialTab;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late AppTab _currentTab = widget.initialTab;

  void _selectTab(AppTab tab) {
    if (tab == _currentTab) return;
    setState(() => _currentTab = tab);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentTab.index,
        children: const [
          HomeScreen(),
          ProgressScreen(),
          TimetableScreen(),
          ExploreScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentTab: _currentTab,
        onTabSelected: _selectTab,
      ),
    );
  }
}

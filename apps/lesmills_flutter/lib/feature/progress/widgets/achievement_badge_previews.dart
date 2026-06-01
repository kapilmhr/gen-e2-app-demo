import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../theme/app_spacing.dart';
import '../../../theme/app_theme.dart';
import '../progress_model.dart';
import 'achievement_badge.dart';

@Preview(name: 'All colours')
Widget achievementBadgeAll() => _wrap(
      const Wrap(
        spacing: AppSpacing.s4,
        runSpacing: AppSpacing.s4,
        children: [
          AchievementBadge(emblem: 'CLASS\nEXPLORER', colour: BadgeColour.dark),
          AchievementBadge(emblem: 'PUMPED UP', colour: BadgeColour.blue),
          AchievementBadge(emblem: 'QUICK\nWIN', colour: BadgeColour.brown),
          AchievementBadge(emblem: 'CLASS\nACT', colour: BadgeColour.orange),
          AchievementBadge(emblem: 'HALF\nCENTURY', colour: BadgeColour.locked),
        ],
      ),
    );

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget achievementBadgeDark() => _wrap(
      const AchievementBadge(emblem: 'CLASS\nACT', colour: BadgeColour.orange),
    );

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget achievementBadgeLargeText() => _wrap(
      const AchievementBadge(emblem: 'PUMPED UP', colour: BadgeColour.blue),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.s5),
            child: child,
          ),
        ),
      ),
    );

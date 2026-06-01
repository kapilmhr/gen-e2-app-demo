import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../theme/app_spacing.dart';
import '../../../theme/app_theme.dart';
import '../progress_stubs.dart';
import 'streak_calendar_card.dart';

@Preview(name: 'Default')
Widget streakCalendarDefault() => _wrap(_card());

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget streakCalendarDark() => _wrap(_card());

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget streakCalendarLargeText() => _wrap(_card());

@Preview(name: 'RTL')
Widget streakCalendarRtl() => _wrap(
      Directionality(textDirection: TextDirection.rtl, child: _card()),
    );

@Preview(name: 'Narrow width')
Widget streakCalendarNarrow() =>
    _wrap(SizedBox(width: 320 - AppSpacing.s5 * 2, child: _card()));

StreakCalendarCard _card() => StreakCalendarCard(
      dateRange: ProgressStubs.loaded.dateRange,
      weeks: ProgressStubs.loaded.weeks,
      lastWeekValue: ProgressStubs.loaded.lastWeekValue,
      currentStreakValue: ProgressStubs.loaded.currentStreakValue,
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.s5),
          child: child,
        ),
      ),
    );

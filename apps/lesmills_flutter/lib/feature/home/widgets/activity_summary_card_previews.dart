import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../theme/app_spacing.dart';
import '../../../theme/app_theme.dart';
import '../home_stubs.dart';
import 'activity_summary_card.dart';

@Preview(name: 'Default')
Widget activityDefault() => _wrap(
      ActivitySummaryCard(
        message: HomeStubs.loaded.activityMessage,
        thisWeek: HomeStubs.thisWeek,
        lastWeek: HomeStubs.lastWeek,
        onViewBookings: () {},
      ),
    );

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget activityDark() => _wrap(
      ActivitySummaryCard(
        message: HomeStubs.loaded.activityMessage,
        thisWeek: HomeStubs.thisWeek,
        lastWeek: HomeStubs.lastWeek,
        onViewBookings: () {},
      ),
    );

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget activityLargeText() => _wrap(
      ActivitySummaryCard(
        message: HomeStubs.loaded.activityMessage,
        thisWeek: HomeStubs.thisWeek,
        lastWeek: HomeStubs.lastWeek,
        onViewBookings: () {},
      ),
    );

@Preview(name: 'RTL')
Widget activityRtl() => _wrap(
      Directionality(
        textDirection: TextDirection.rtl,
        child: ActivitySummaryCard(
          message: HomeStubs.loaded.activityMessage,
          thisWeek: HomeStubs.thisWeek,
          lastWeek: HomeStubs.lastWeek,
          onViewBookings: () {},
        ),
      ),
    );

@Preview(name: 'Narrow width')
Widget activityNarrow() => _wrap(
      SizedBox(
        width: 320,
        child: ActivitySummaryCard(
          message: HomeStubs.loaded.activityMessage,
          thisWeek: HomeStubs.thisWeek,
          lastWeek: HomeStubs.lastWeek,
          onViewBookings: () {},
        ),
      ),
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

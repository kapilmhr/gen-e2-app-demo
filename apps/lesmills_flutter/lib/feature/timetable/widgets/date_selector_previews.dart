import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_theme.dart';
import '../timetable_stubs.dart';
import 'date_selector.dart';

@Preview(name: 'Default')
Widget dateSelectorDefault() =>
    _wrap(DateSelector(days: TimetableStubs.loaded.days));

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget dateSelectorDark() =>
    _wrap(DateSelector(days: TimetableStubs.loaded.days));

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget dateSelectorLargeText() =>
    _wrap(DateSelector(days: TimetableStubs.loaded.days));

@Preview(name: 'RTL')
Widget dateSelectorRtl() => _wrap(
      Directionality(
        textDirection: TextDirection.rtl,
        child: DateSelector(days: TimetableStubs.loaded.days),
      ),
    );

// A gradient backdrop matching the header so the translucent pills read.
Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.blue, AppColors.darkOrange],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.s5),
            child: Align(alignment: Alignment.topCenter, child: child),
          ),
        ),
      ),
    );

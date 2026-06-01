import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';
import '../timetable_model.dart';
import 'day_part_filter.dart';

@Preview(name: 'Morning selected')
Widget dayPartMorning() =>
    _wrap(const DayPartFilter(selected: DayPart.morning));

@Preview(name: 'Afternoon selected')
Widget dayPartAfternoon() =>
    _wrap(const DayPartFilter(selected: DayPart.afternoon));

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget dayPartDark() => _wrap(const DayPartFilter(selected: DayPart.morning));

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget dayPartLargeText() =>
    _wrap(const DayPartFilter(selected: DayPart.morning));

@Preview(name: 'RTL')
Widget dayPartRtl() => _wrap(
      const Directionality(
        textDirection: TextDirection.rtl,
        child: DayPartFilter(selected: DayPart.morning),
      ),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(
        backgroundColor: AppColors.white,
        body: Align(alignment: Alignment.topCenter, child: child),
      ),
    );

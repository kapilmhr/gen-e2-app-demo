import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../theme/app_theme.dart';
import '../timetable_model.dart';
import '../timetable_stubs.dart';
import 'timetable_header.dart';

@Preview(name: 'Club Timetable')
Widget headerClub() => _wrap(TimetableHeader(data: TimetableStubs.loaded));

@Preview(name: 'My Bookings')
Widget headerBookings() => _wrap(
      TimetableHeader(
        data: _section(TimetableSection.myBookings),
      ),
    );

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget headerLargeText() => _wrap(TimetableHeader(data: TimetableStubs.loaded));

@Preview(name: 'RTL')
Widget headerRtl() => _wrap(
      Directionality(
        textDirection: TextDirection.rtl,
        child: TimetableHeader(data: TimetableStubs.loaded),
      ),
    );

@Preview(name: 'Narrow width')
Widget headerNarrow() => _wrap(
      SizedBox(width: 320, child: TimetableHeader(data: TimetableStubs.loaded)),
    );

TimetableData _section(TimetableSection section) {
  final base = TimetableStubs.loaded;
  return TimetableData(
    section: section,
    month: base.month,
    location: base.location,
    days: base.days,
    selectedDayPart: base.selectedDayPart,
    classes: base.classes,
  );
}

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(
        body: Align(alignment: Alignment.topCenter, child: child),
      ),
    );

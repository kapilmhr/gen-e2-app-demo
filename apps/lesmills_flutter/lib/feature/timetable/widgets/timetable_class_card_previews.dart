import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_theme.dart';
import '../timetable_model.dart';
import 'timetable_class_card.dart';

const _available = TimetableClass(
  id: 'ceremony-0715',
  time: '7:15am',
  duration: '45 mins',
  name: 'Ceremony',
  studio: 'Functional Studio',
  instructor: 'Nats Levi',
  bookingState: ClassBookingState.available,
  availableCount: 8,
);

const _noCount = TimetableClass(
  id: 'bodypump-1000',
  time: '10:00am',
  duration: '55 mins',
  name: 'BodyPump',
  studio: 'Studio 2',
  instructor: 'Sean Oosthuysen',
  bookingState: ClassBookingState.available,
);

const _booked = TimetableClass(
  id: 'thetrip-1820',
  time: '6:20pm',
  duration: '45 mins',
  name: 'The Trip',
  studio: 'Cycle Studio',
  instructor: 'Otto Prodan',
  bookingState: ClassBookingState.booked,
);

@Preview(name: 'Available (with count)')
Widget classCardAvailable() =>
    _wrap(TimetableClassCard(session: _available, onBook: () {}));

@Preview(name: 'Available (no count)')
Widget classCardNoCount() =>
    _wrap(TimetableClassCard(session: _noCount, onBook: () {}));

@Preview(name: 'Booked')
Widget classCardBooked() => _wrap(const TimetableClassCard(session: _booked));

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget classCardDark() => _wrap(const TimetableClassCard(session: _available));

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget classCardLargeText() =>
    _wrap(const TimetableClassCard(session: _available));

@Preview(name: 'RTL')
Widget classCardRtl() => _wrap(
      const Directionality(
        textDirection: TextDirection.rtl,
        child: TimetableClassCard(session: _available),
      ),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: const EdgeInsets.all(AppSpacing.s5),
          child: Align(alignment: Alignment.topCenter, child: child),
        ),
      ),
    );

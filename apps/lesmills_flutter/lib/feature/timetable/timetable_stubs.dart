import '../../l10n/app_strings.dart';
import 'timetable_model.dart';

/// Realistic, deterministic sample data for the timetable screen — taken from
/// the Figma "Timetable / Morning" frame. No network, randomness, or clocks so
/// previews and tests render identically every run.
abstract final class TimetableStubs {
  static const List<TimetableDay> _days = [
    TimetableDay(weekday: 'Wed', dayNumber: 18, isSelected: true),
    TimetableDay(weekday: 'Thu', dayNumber: 19),
    TimetableDay(weekday: 'Fri', dayNumber: 20),
    TimetableDay(weekday: 'Sat', dayNumber: 21),
    TimetableDay(weekday: 'Sun', dayNumber: 22),
    TimetableDay(weekday: 'Mon', dayNumber: 23),
    TimetableDay(weekday: 'Tue', dayNumber: 24),
  ];

  static const List<TimetableClass> _classes = [
    TimetableClass(
      id: 'ceremony-0715',
      time: '7:15am',
      duration: '45 mins',
      name: 'Ceremony',
      studio: 'Functional Studio',
      instructor: 'Nats Levi',
      bookingState: ClassBookingState.available,
      availableCount: 8,
    ),
    TimetableClass(
      id: 'rpm-0720',
      time: '7:20am',
      duration: '45 mins',
      name: 'RPM',
      studio: 'Cycle Studio',
      instructor: 'Laura Rossi',
      bookingState: ClassBookingState.available,
      availableCount: 2,
    ),
    TimetableClass(
      id: 'bodypump-1000',
      time: '10:00am',
      duration: '55 mins',
      name: 'BodyPump',
      studio: 'Studio 2',
      instructor: 'Sean Oosthuysen',
      bookingState: ClassBookingState.available,
    ),
    TimetableClass(
      id: 'bodystep-1010',
      time: '10:10am',
      duration: '55 mins',
      name: 'BodyStep',
      studio: 'Studio 1',
      instructor: 'Lisa Osborne',
      bookingState: ClassBookingState.available,
    ),
    TimetableClass(
      id: 'ceremony-1015',
      time: '10:15am',
      duration: '45 mins',
      name: 'Ceremony',
      studio: 'Functional Studio',
      instructor: 'Khiran Huston',
      bookingState: ClassBookingState.available,
    ),
    TimetableClass(
      id: 'yoga-1130',
      time: '11:30am',
      duration: '55 mins',
      name: 'Yoga',
      studio: 'Studio 2',
      instructor: 'Yogini Nimata Morarji',
      bookingState: ClassBookingState.available,
    ),
    TimetableClass(
      id: 'conquer-1130',
      time: '11:30am',
      duration: '45 mins',
      name: 'Conquer',
      studio: 'Boxing Studio',
      instructor: 'Troy Garton',
      bookingState: ClassBookingState.available,
      availableCount: 2,
    ),
    TimetableClass(
      id: 'thetrip-1820',
      time: '6:20pm',
      duration: '45 mins',
      name: 'The Trip',
      studio: 'Cycle Studio',
      instructor: 'Otto Prodan',
      bookingState: ClassBookingState.booked,
    ),
  ];

  static const TimetableData _data = TimetableData(
    section: TimetableSection.clubTimetable,
    month: 'March',
    location: 'Auckland City',
    days: _days,
    selectedDayPart: DayPart.morning,
    classes: _classes,
  );

  static const TimetableState loadedState = TimetableLoaded(_data);
  static const TimetableState loadingState = TimetableLoading();
  static const TimetableState emptyState = TimetableEmpty();
  static final TimetableState errorState =
      TimetableError(AppStrings.timetableErrorTitle);

  static TimetableData get loaded => _data;
}

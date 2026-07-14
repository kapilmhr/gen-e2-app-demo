import '../../l10n/app_strings.dart';
import 'timetable_model.dart';

/// Realistic, deterministic sample data for the timetable screen — taken from
/// the Figma "Timetable / Morning" frame. No network, randomness, or clocks so
/// previews and tests render identically every run.
abstract final class TimetableStubs {
  static const List<TimetableDay> _days = [
    TimetableDay(weekday: 'Mon', dayNumber: 20, isSelected: true),
    TimetableDay(weekday: 'Tue', dayNumber: 21),
    TimetableDay(weekday: 'Wed', dayNumber: 22),
    TimetableDay(weekday: 'Thu', dayNumber: 23),
    TimetableDay(weekday: 'Fri', dayNumber: 24),
    TimetableDay(weekday: 'Sat', dayNumber: 25),
    TimetableDay(weekday: 'Sun', dayNumber: 26),
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
      id: 'bodycombat-1200',
      time: '12:00pm',
      duration: '55 mins',
      name: 'BodyCombat',
      studio: 'Studio 1',
      instructor: 'Maya Chen',
      bookingState: ClassBookingState.available,
      availableCount: 5,
    ),
    TimetableClass(
      id: 'rpm-1300',
      time: '1:00pm',
      duration: '45 mins',
      name: 'RPM',
      studio: 'Cycle Studio',
      instructor: 'Laura Rossi',
      bookingState: ClassBookingState.available,
    ),
    TimetableClass(
      id: 'grit-1530',
      time: '3:30pm',
      duration: '30 mins',
      name: 'GRIT Strength',
      studio: 'Functional Studio',
      instructor: 'Nats Levi',
      bookingState: ClassBookingState.available,
      availableCount: 3,
    ),
    TimetableClass(
      id: 'yoga-1630',
      time: '4:30pm',
      duration: '55 mins',
      name: 'Yoga',
      studio: 'Studio 2',
      instructor: 'Yogini Nimata Morarji',
      bookingState: ClassBookingState.available,
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
    TimetableClass(
      id: 'bodypump-1900',
      time: '7:00pm',
      duration: '55 mins',
      name: 'BodyPump',
      studio: 'Studio 2',
      instructor: 'Sean Oosthuysen',
      bookingState: ClassBookingState.available,
      availableCount: 10,
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

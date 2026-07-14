import 'package:flutter/foundation.dart';

// Sentinel used by TimetableClass.copyWith to distinguish "not provided" from
// an explicit null for the optional [availableCount] field.
const Object _sentinel = Object();

/// Which top-level timetable view is shown.
enum TimetableSection { clubTimetable, myBookings }

/// Time-of-day filter applied to the class list.
///
/// Named [DayPart] (not `TimeOfDay`) to avoid clashing with Flutter's
/// material `TimeOfDay`.
enum DayPart { morning, lunch, afternoon, night }

/// Booking availability for a single class session.
enum ClassBookingState { available, full, booked }

/// A selectable day in the horizontal date strip.
@immutable
class TimetableDay {
  const TimetableDay({
    required this.weekday,
    required this.dayNumber,
    this.isSelected = false,
  });

  final String weekday;
  final int dayNumber;
  final bool isSelected;

  @override
  bool operator ==(Object other) =>
      other is TimetableDay &&
      other.weekday == weekday &&
      other.dayNumber == dayNumber &&
      other.isSelected == isSelected;

  @override
  int get hashCode => Object.hash(weekday, dayNumber, isSelected);
}

/// A single class session in the timetable.
@immutable
class TimetableClass {
  const TimetableClass({
    required this.id,
    required this.time,
    required this.duration,
    required this.name,
    required this.studio,
    required this.instructor,
    required this.bookingState,
    this.availableCount,
  });

  final String id;
  final String time;
  final String duration;
  final String name;
  final String studio;
  final String instructor;
  final ClassBookingState bookingState;

  /// Remaining spots; shown only when known and the class is bookable.
  final int? availableCount;

  TimetableClass copyWith({
    String? id,
    String? time,
    String? duration,
    String? name,
    String? studio,
    String? instructor,
    ClassBookingState? bookingState,
    Object? availableCount = _sentinel,
  }) =>
      TimetableClass(
        id: id ?? this.id,
        time: time ?? this.time,
        duration: duration ?? this.duration,
        name: name ?? this.name,
        studio: studio ?? this.studio,
        instructor: instructor ?? this.instructor,
        bookingState: bookingState ?? this.bookingState,
        availableCount: availableCount == _sentinel
            ? this.availableCount
            : availableCount as int?,
      );

  @override
  bool operator ==(Object other) =>
      other is TimetableClass &&
      other.id == id &&
      other.time == time &&
      other.duration == duration &&
      other.name == name &&
      other.studio == studio &&
      other.instructor == instructor &&
      other.bookingState == bookingState &&
      other.availableCount == availableCount;

  @override
  int get hashCode => Object.hash(
        id,
        time,
        duration,
        name,
        studio,
        instructor,
        bookingState,
        availableCount,
      );
}

/// Everything needed to render a loaded timetable.
@immutable
class TimetableData {
  const TimetableData({
    required this.section,
    required this.month,
    required this.location,
    required this.days,
    required this.selectedDayPart,
    required this.classes,
  });

  final TimetableSection section;
  final String month;
  final String location;
  final List<TimetableDay> days;
  final DayPart selectedDayPart;
  final List<TimetableClass> classes;

  @override
  bool operator ==(Object other) =>
      other is TimetableData &&
      other.section == section &&
      other.month == month &&
      other.location == location &&
      listEquals(other.days, days) &&
      other.selectedDayPart == selectedDayPart &&
      listEquals(other.classes, classes);

  @override
  int get hashCode => Object.hash(
        section,
        month,
        location,
        Object.hashAll(days),
        selectedDayPart,
        Object.hashAll(classes),
      );
}

/// Exhaustive UI state for the timetable screen.
sealed class TimetableState {
  const TimetableState();
}

class TimetableIdle extends TimetableState {
  const TimetableIdle();
}

class TimetableLoading extends TimetableState {
  const TimetableLoading();
}

class TimetableLoaded extends TimetableState {
  const TimetableLoaded(this.data);

  final TimetableData data;
}

class TimetableEmpty extends TimetableState {
  const TimetableEmpty();
}

class TimetableError extends TimetableState {
  const TimetableError(this.message);

  final String message;
}

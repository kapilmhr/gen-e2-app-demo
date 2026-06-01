import 'package:flutter/foundation.dart';

/// Immutable data for a single [ListRow] — a tappable settings-style row with a
/// title and a trailing chevron affordance.
@immutable
class ListRowModel {
  const ListRowModel({required this.id, required this.title});

  final String id;

  /// Row label shown at the start of the row.
  final String title;

  @override
  bool operator ==(Object other) =>
      other is ListRowModel && other.id == id && other.title == title;

  @override
  int get hashCode => Object.hash(id, title);
}

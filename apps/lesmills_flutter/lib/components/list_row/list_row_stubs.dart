import 'list_row_model.dart';

/// Deterministic, offline sample data for [ListRow] previews and tests.
abstract final class ListRowStubs {
  ListRowStubs._();

  static const ListRowModel loaded = ListRowModel(
    id: 'notifications',
    title: 'Notification preferences',
  );

  static const ListRowModel longTitle = ListRowModel(
    id: 'sync-calendar',
    title: 'Sync my booked classes to my device calendar automatically',
  );

  static const List<ListRowModel> list = [
    loaded,
    ListRowModel(id: 'change-password', title: 'Change password'),
    ListRowModel(id: 'terms-of-use', title: 'Terms of use'),
  ];
}

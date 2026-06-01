import 'package:flutter/foundation.dart';

import '../../components/list_row/list_row_model.dart';

/// Immutable data backing the Profile screen.
@immutable
class ProfileData {
  const ProfileData({
    required this.settings,
    required this.membership,
    required this.appVersion,
    this.headerImageAsset,
    this.headerImageUrl,
  });

  /// "App Settings" rows.
  final List<ListRowModel> settings;

  /// "Membership" rows.
  final List<ListRowModel> membership;

  /// App version label shown in the footer (e.g. "App version 3.304").
  final String appVersion;

  /// Optional bundled header image asset. Preferred over [headerImageUrl].
  final String? headerImageAsset;

  /// Optional remote header image.
  final String? headerImageUrl;

  @override
  bool operator ==(Object other) =>
      other is ProfileData &&
      listEquals(other.settings, settings) &&
      listEquals(other.membership, membership) &&
      other.appVersion == appVersion &&
      other.headerImageAsset == headerImageAsset &&
      other.headerImageUrl == headerImageUrl;

  @override
  int get hashCode => Object.hash(
        Object.hashAll(settings),
        Object.hashAll(membership),
        appVersion,
        headerImageAsset,
        headerImageUrl,
      );
}

/// Exhaustive UI state for the Profile screen.
sealed class ProfileState {
  const ProfileState();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  const ProfileLoaded(this.data);

  final ProfileData data;
}

class ProfileEmpty extends ProfileState {
  const ProfileEmpty();
}

class ProfileError extends ProfileState {
  const ProfileError(this.message);

  final String message;
}

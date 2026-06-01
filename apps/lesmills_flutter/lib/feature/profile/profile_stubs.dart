import '../../components/list_row/list_row_model.dart';
import '../../l10n/app_strings.dart';
import 'profile_model.dart';

/// Deterministic, offline sample data for the Profile screen.
abstract final class ProfileStubs {
  static const String _images = 'assets/images';

  static const List<ListRowModel> _settings = [
    ListRowModel(
      id: 'notification-preferences',
      title: AppStrings.profileNotificationPrefs,
    ),
    ListRowModel(
      id: 'sync-calendar',
      title: AppStrings.profileSyncCalendar,
    ),
    ListRowModel(
      id: 'change-password',
      title: AppStrings.profileChangePassword,
    ),
    ListRowModel(
      id: 'terms-of-use',
      title: AppStrings.profileTermsOfUse,
    ),
  ];

  static const List<ListRowModel> _membership = [
    ListRowModel(id: 'pay-account', title: AppStrings.profilePayAccount),
    ListRowModel(
      id: 'personal-details',
      title: AppStrings.profilePersonalDetails,
    ),
    ListRowModel(
      id: 'transaction-history',
      title: AppStrings.profileTransactionHistory,
    ),
    ListRowModel(
      id: 'manage-membership',
      title: AppStrings.profileManageMembership,
    ),
    ListRowModel(id: 'contact-us', title: AppStrings.profileContactUs),
  ];

  static const ProfileData _data = ProfileData(
    settings: _settings,
    membership: _membership,
    appVersion: AppStrings.profileAppVersion,
    headerImageAsset: '$_images/profile_header.png',
  );

  static ProfileData get loaded => _data;

  static const ProfileState loadedState = ProfileLoaded(_data);
  static const ProfileState loadingState = ProfileLoading();
  static const ProfileState emptyState = ProfileEmpty();
  static const ProfileState errorState =
      ProfileError(AppStrings.profileErrorTitle);
}

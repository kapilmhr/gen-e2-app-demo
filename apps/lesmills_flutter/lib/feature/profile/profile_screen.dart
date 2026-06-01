import 'package:flutter/material.dart';

import '../../components/page_header/page_header.dart';
import '../../l10n/app_strings.dart';
import '../../theme/app_spacing.dart';
import 'profile_model.dart';
import 'profile_stubs.dart';
import 'widgets/settings_list_section.dart';

/// The Profile tab — app settings, membership management, app version and a
/// log-out action. Renders the [ProfileState] passed in (defaulting to loaded
/// sample data). The persistent bottom navigation is owned by `AppShell`, so
/// this screen is a pure tab body.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    this.initialState = ProfileStubs.loadedState,
    this.onLogout,
    this.onRetry,
  });

  final ProfileState initialState;
  final VoidCallback? onLogout;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: switch (initialState) {
        ProfileLoading() => const _ProfileSkeleton(),
        ProfileEmpty() => _ProfileMessage(
            title: AppStrings.profileEmptyTitle,
            body: AppStrings.profileEmptyBody,
            onRetry: onRetry,
          ),
        ProfileError(:final message) => _ProfileMessage(
            title: message,
            body: AppStrings.profileEmptyBody,
            onRetry: onRetry,
          ),
        ProfileLoaded(:final data) => _ProfileContent(
            data: data,
            onLogout: onLogout,
          ),
      },
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({required this.data, this.onLogout});

  final ProfileData data;
  final VoidCallback? onLogout;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        PageHeader(
          title: AppStrings.profileTitle,
          imageAsset: data.headerImageAsset,
          imageUrl: data.headerImageUrl,
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.s5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SettingsListSection(
                title: AppStrings.profileAppSettingsTitle,
                rows: data.settings,
                onRowTap: (_) {},
              ),
              const SizedBox(height: AppSpacing.s6),
              SettingsListSection(
                title: AppStrings.profileMembershipTitle,
                rows: data.membership,
                onRowTap: (_) {},
              ),
              const SizedBox(height: AppSpacing.s6),
              Text(
                data.appVersion,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.s4),
              OutlinedButton(
                onPressed: onLogout,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: theme.colorScheme.primary, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.s4),
                  ),
                ),
                child: Text(AppStrings.profileLogout.toUpperCase()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Static (non-animated) skeleton — respects reduced-motion preferences by
/// avoiding shimmer entirely.
class _ProfileSkeleton extends StatelessWidget {
  const _ProfileSkeleton();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.surfaceContainerLowest;

    Widget block(double height) => Container(
          height: height,
          margin: const EdgeInsets.only(bottom: AppSpacing.s4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(AppSpacing.s3),
          ),
        );

    return Semantics(
      label: AppStrings.loading,
      child: ExcludeSemantics(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.s5),
          children: [
            block(AppSpacing.s6),
            block(AppSpacing.s7 * 4),
            const SizedBox(height: AppSpacing.s2),
            block(AppSpacing.s6),
            block(AppSpacing.s7 * 5),
          ],
        ),
      ),
    );
  }
}

class _ProfileMessage extends StatelessWidget {
  const _ProfileMessage({
    required this.title,
    required this.body,
    this.onRetry,
  });

  final String title;
  final String body;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.s2),
            Text(
              body,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.s5),
              ElevatedButton(
                onPressed: onRetry,
                child: Text(AppStrings.retry.toUpperCase()),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

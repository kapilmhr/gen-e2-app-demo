import 'package:flutter/material.dart';

import '../../components/app_bottom_nav_bar/app_bottom_nav_bar.dart';
import '../../components/link_card/link_card.dart';
import '../../l10n/app_strings.dart';
import '../../theme/app_spacing.dart';
import 'home_model.dart';
import 'home_stubs.dart';
import 'widgets/activity_summary_card.dart';
import 'widgets/group_fitness_section.dart';
import 'widgets/home_hero_header.dart';
import 'widgets/in_motion_section.dart';

/// The Home dashboard — the member's landing screen. Renders the [HomeState]
/// passed in (defaulting to loaded sample data) and owns only the local
/// bottom-navigation selection.
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.initialState = HomeStubs.loadedState,
    this.onRetry,
  });

  final HomeState initialState;
  final VoidCallback? onRetry;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppTab _currentTab = AppTab.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: switch (widget.initialState) {
        HomeIdle() || HomeLoading() => const _HomeSkeleton(),
        HomeEmpty() => const _HomeMessage(
            title: AppStrings.homeEmptyTitle,
            body: AppStrings.homeEmptyBody,
          ),
        HomeError(:final message) => _HomeMessage(
            title: message,
            body: AppStrings.homeLoadErrorBody,
            onRetry: widget.onRetry,
          ),
        HomeLoaded(:final data) => _HomeContent(data: data),
      },
      bottomNavigationBar: AppBottomNavBar(
        currentTab: _currentTab,
        onTabSelected: (tab) => setState(() => _currentTab = tab),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.data});

  final HomeData data;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        HomeHeroHeader(
          memberName: data.memberName,
          imageAsset: data.heroImageAsset,
          imageUrl: data.heroImageUrl,
          onScanIn: () {},
        ),
        const SizedBox(height: AppSpacing.s6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
          child: ActivitySummaryCard(
            message: data.activityMessage,
            thisWeek: data.thisWeek,
            lastWeek: data.lastWeek,
            onViewBookings: () {},
          ),
        ),
        const SizedBox(height: AppSpacing.s6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
          child: LinkCard(model: data.challenge, onPressed: () {}),
        ),
        const SizedBox(height: AppSpacing.s6),
        InMotionSection(
          items: data.inMotion,
          onCardTap: (_) {},
        ),
        const SizedBox(height: AppSpacing.s6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
          child: LinkCard(model: data.referFriend, onPressed: () {}),
        ),
        const SizedBox(height: AppSpacing.s6),
        GroupFitnessSection(
          description: data.groupFitnessDescription,
          classes: data.classes,
          onClassTap: (_) {},
          onTimetable: () {},
        ),
        const SizedBox(height: AppSpacing.s7),
      ],
    );
  }
}

/// Static (non-animated) skeleton — respects reduced-motion preferences by
/// avoiding shimmer entirely.
class _HomeSkeleton extends StatelessWidget {
  const _HomeSkeleton();

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
            block(320),
            block(180),
            block(180),
            block(260),
          ],
        ),
      ),
    );
  }
}

class _HomeMessage extends StatelessWidget {
  const _HomeMessage({
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

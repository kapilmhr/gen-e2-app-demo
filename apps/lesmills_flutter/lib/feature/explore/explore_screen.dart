import 'package:flutter/material.dart';

import '../../components/link_card/link_card.dart';
import '../../components/page_header/page_header.dart';
import '../../components/section_header/section_header.dart';
import '../../l10n/app_strings.dart';
import '../../theme/app_spacing.dart';
import 'explore_model.dart';
import 'explore_stubs.dart';
import 'widgets/discovery_carousel.dart';
import 'widgets/explore_group_fitness_section.dart';

/// The Explore tab — curated content: promotions, personal training, at-home
/// discovery carousels and group fitness. Renders the [ExploreState] passed in
/// (defaulting to loaded sample data). The persistent bottom navigation is
/// owned by `AppShell`, so this screen is a pure tab body.
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({
    super.key,
    this.initialState = ExploreStubs.loadedState,
    this.onRetry,
  });

  final ExploreState initialState;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: switch (initialState) {
        ExploreIdle() || ExploreLoading() => const _ExploreSkeleton(),
        ExploreEmpty() => const _ExploreMessage(
            title: AppStrings.exploreEmptyTitle,
            body: AppStrings.exploreEmptyBody,
          ),
        ExploreError(:final message) => _ExploreMessage(
            title: message,
            body: AppStrings.exploreEmptyBody,
            onRetry: onRetry,
          ),
        ExploreLoaded(:final data) => _ExploreContent(data: data),
      },
    );
  }
}

class _ExploreContent extends StatelessWidget {
  const _ExploreContent({required this.data});

  final ExploreData data;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        PageHeader(
          title: AppStrings.exploreTitle,
          imageAsset: data.headerImageAsset,
          imageUrl: data.headerImageUrl,
        ),
        const SizedBox(height: AppSpacing.s5),
        // Promotional card.
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
          child: LinkCard(model: data.promo, onPressed: () {}),
        ),
        const SizedBox(height: AppSpacing.s6),
        // Personal training.
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                title: AppStrings.explorePersonalTrainingTitle,
                description: AppStrings.explorePersonalTrainingDescription,
              ),
              const SizedBox(height: AppSpacing.s5),
              LinkCard(model: data.personalTraining, onPressed: () {}),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s6),
        // Les Mills At Home.
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
          child: SectionHeader(
            title: AppStrings.exploreAtHomeTitle,
            description: AppStrings.exploreAtHomeDescription,
          ),
        ),
        const SizedBox(height: AppSpacing.s5),
        for (final carousel in data.discoveryCarousels) ...[
          DiscoveryCarouselView(
            label: carousel.label,
            items: carousel.items,
            hasError: carousel.hasError,
            onItemTap: (_) {},
          ),
          const SizedBox(height: AppSpacing.s5),
        ],
        const SizedBox(height: AppSpacing.s2),
        // Group fitness.
        ExploreGroupFitnessSection(
          classes: data.groupFitnessClasses,
          onClassTap: (_) {},
          onTimetable: () {},
        ),
        const SizedBox(height: AppSpacing.s6),
        // Closing card.
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
          child: LinkCard(model: data.closingCard, onPressed: () {}),
        ),
        const SizedBox(height: AppSpacing.s7),
      ],
    );
  }
}

/// Static (non-animated) skeleton — respects reduced-motion preferences by
/// avoiding shimmer entirely.
class _ExploreSkeleton extends StatelessWidget {
  const _ExploreSkeleton();

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
            block(160),
            const SizedBox(height: AppSpacing.s2),
            block(28),
            block(180),
            const SizedBox(height: AppSpacing.s2),
            block(28),
            block(220),
          ],
        ),
      ),
    );
  }
}

class _ExploreMessage extends StatelessWidget {
  const _ExploreMessage({
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

---
id: US-004
title: "Explore tab — discover classes, collections & content"
priority: high
status: ready
points: 5
assignee: ""
tags: [explore, discovery, les-mills, mobile]
epic: "App Navigation & Core Tabs"
createdAt: "2026-06-01"
updatedAt: "2026-06-01"
dueDate: null
---

# Explore tab — discover classes, collections & content

## User Story

As a **Les Mills member**
I want to **browse curated content — personal training, at-home workouts, classes and collections**
So that **I can discover new ways to train and decide what to try next**

## Acceptance Criteria

1. The screen shows a branded page header consistent with the other tabs.
2. The screen presents promotional link cards (e.g. Personal training, Les Mills at Home, refer a friend) using the existing LinkCard.
3. A "Personal training" section shows a heading, supporting description and a link card.
4. A "Les Mills At Home" section shows a heading, description and horizontally scrollable discovery carousels titled "New In", "Classes" and "Collections".
5. A "Group fitness" section shows a heading, description and a horizontally scrollable row of class cards, ending with a "View the Group Fitness Timetable" call-to-action card.
6. The screen renders exhaustive states: Idle/Loading (skeleton), Loaded, Empty, and Error (with Retry); each carousel degrades independently so one failure never blanks the page.
7. All copy, spacing, colour and typography use design-system tokens; the screen is light-theme only.
8. Accessibility: carousels are keyboard/scroll accessible, cards expose a meaningful label, headers are exposed, tap targets meet 44/48px, text scales to 2×, RTL mirrors correctly.

## Tasks

| Status | Title | Description |
|--------|-------|-------------|
| [ ] | Explore model & state | `@immutable` data + sealed `ExploreState` (Idle/Loading/Loaded/Empty/Error). |
| [ ] | Explore stubs | Deterministic offline data: promos, carousels, group-fitness classes. |
| [ ] | DiscoveryCarousel widget | SectionHeader + horizontal ContentCard list + "view timetable" end card + previews. |
| [ ] | ExploreGroupFitnessSection widget | ClassCard scroll + timetable CTA card + previews. |
| [ ] | ExploreScreen | Compose header/promos/carousels/group fitness, render states + previews. |
| [ ] | Wire into AppShell | Replace the Explore `_ComingSoon` placeholder. |
| [ ] | Tests | Render, state, a11y, carousel scroll & card-tap interaction. |

## Technical Notes

- Reuse `LinkCard`/`LinkCardModel`, `ContentCard`/`ContentCardModel`, `ClassCard`/`ClassCardModel`, `SectionHeader`, `PillButton`.
- Reuse the shared `PageHeader` component (from the Progress story).
- The Home `GroupFitnessSection` pattern can inform the Explore group-fitness carousel; share where genuinely identical, otherwise keep Explore-local.
- No network in stubs; images via bundled assets/placeholders only.
- Light theme only; tokens via `Theme.of(context)` / `AppSpacing`.

## Design Notes

- Figma frame: Les Mills — Member App Demo, node `13301:27411`.
- Section order: Page header → Link card → Personal training (+link card) → Les Mills At Home (New In / Classes / Collections carousels) → Group fitness (class scroll + timetable card) → closing link card.
- Sample content from frame: SH'BAM 51, Grit Strength 44, Short + Sweat, Take a Breathe, Wellness; classes The Trip, Conquer, Bodybalance.

## Dependencies

- Shared `PageHeader` component (from US-002).
- Existing `LinkCard`, `ContentCard`, `ClassCard`, `SectionHeader`, `PillButton`, `IntensityRating`.
- `AppShell` (built) to host the tab.

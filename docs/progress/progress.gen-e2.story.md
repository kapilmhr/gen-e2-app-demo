---
id: US-002
title: "Progress tab — streaks, badges & workout tips"
priority: high
status: ready
points: 5
assignee: ""
tags: [progress, gamification, les-mills, mobile]
epic: "App Navigation & Core Tabs"
createdAt: "2026-06-01"
updatedAt: "2026-06-01"
dueDate: null
---

# Progress tab — streaks, badges & workout tips

## User Story

As a **Les Mills member**
I want to **see my multi-week workout streak, the badges I've earned and what I can unlock next**
So that **I stay motivated and understand how close I am to my next achievement**

## Acceptance Criteria

1. The screen shows a branded page header consistent with the other tabs.
2. A "4 week summary" section displays a date range, a 7-column weekday calendar, four week-rows of workout/streak indicators, and a footer showing last-week workout count and current streak, with a button to view detail.
3. A "Badges earned" section shows a horizontally scrollable row of achievement badges, each with an icon and a name (e.g. Class Explorer, Pumped Up, Quick Win, Class Act).
4. A "Next to unlock" card shows the next badge with a progress bar and a "42/50 club visits" style progress label.
5. A "Workout tips" section shows a horizontally scrollable carousel of content cards.
6. The screen renders five exhaustive states: Idle/Loading (skeleton), Loaded, Empty (new member with no streak/badges), and Error (with Retry).
7. All copy, spacing, colour and typography use design-system tokens; the screen is light-theme only.
8. The screen meets accessibility requirements: section headers exposed, 44/48px tap targets, text scales to 2×, RTL mirrors correctly, and the streak calendar exposes a meaningful semantic summary.

## Tasks

| Status | Title | Description |
|--------|-------|-------------|
| [ ] | Shared PageHeader component | Extract the 195px branded header (greeting + gradient) as a reusable component with model, previews, stubs, tests. |
| [ ] | Progress model & state | `@immutable` data + sealed `ProgressState` (Idle/Loading/Loaded/Empty/Error). |
| [ ] | Progress stubs | Deterministic offline sample data for loaded/empty/error states. |
| [ ] | StreakCalendar widget | 4-week dot/streak grid with weekday header and summary footer + previews. |
| [ ] | BadgeCard + AchievementBadge widgets | Horizontal earned-badges row + previews. |
| [ ] | NextToUnlockCard widget | Badge + progress bar + progress label + previews. |
| [ ] | WorkoutTipsSection widget | ContentCard carousel reusing the existing ContentCard + previews. |
| [ ] | ProgressScreen | Compose sections, render all states, pure tab body + previews. |
| [ ] | Wire into AppShell | Replace the Progress `_ComingSoon` placeholder. |
| [ ] | Tests | Render, state, a11y (`meetsGuideline`), interaction; component tests for PageHeader. |

## Technical Notes

- Follow the existing Home pattern exactly (model + sealed state + stubs + screen + widgets + previews + tests).
- Reuse `ContentCard`/`ContentCardModel` for Workout tips and `SectionHeader` for all titles.
- `PageHeader` is a new shared component under `lib/components/page_header/` (also consumed by Explore and Profile).
- No `DateTime.now()`/`Random` in stubs — fixed, deterministic data only.
- Light theme only; tokens via `Theme.of(context)` / `AppSpacing`.

## Design Notes

- Figma frame: Les Mills — Member App Demo, node `13301:27981`.
- Sections top→bottom: Page header → 4-week summary (StreakCalendar) → Badges earned → Next to unlock → Workout tips.
- Badge labels from frame: Class Explorer, Pumped Up, Quick Win, Class Act; Next-to-unlock: Half Century 42/50 club visits.
- Accessibility: load the `accessibility` skill; calendar must summarise workouts/streak for screen readers rather than reading every empty cell.

## Dependencies

- Shared `PageHeader` component (built within this story; reused by Explore/Profile).
- Existing `ContentCard`, `SectionHeader` components.
- `AppShell` (built) to host the tab.

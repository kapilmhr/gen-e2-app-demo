---
id: US-005
title: "Profile tab — settings, membership & sign out"
priority: high
status: ready
points: 3
assignee: ""
tags: [profile, settings, account, les-mills, mobile]
epic: "App Navigation & Core Tabs"
createdAt: "2026-06-01"
updatedAt: "2026-06-01"
dueDate: null
---

# Profile tab — settings, membership & sign out

## User Story

As a **Les Mills member**
I want to **manage my app settings and membership and sign out**
So that **I can control my account and preferences in one place**

## Acceptance Criteria

1. The screen shows a branded page header consistent with the other tabs.
2. An "App Settings" section shows a list of tappable rows, each with a title and a trailing chevron.
3. A "Membership" section shows a list of tappable rows, each with a title and a trailing chevron.
4. A footer shows the app version (e.g. "App version 3.304").
5. A primary "Log out" button is shown beneath the version.
6. The screen renders exhaustive states: Loaded (the default), and an Error/Empty fallback if settings fail to load (with Retry).
7. All copy, spacing, colour and typography use design-system tokens; the screen is light-theme only.
8. Accessibility: each list row is a single button exposing its title; the chevron is decorative; tap targets meet 44/48px; text scales to 2×; RTL mirrors the chevron correctly.

## Tasks

| Status | Title | Description |
|--------|-------|-------------|
| [ ] | Shared ListRow component | Tappable title + trailing chevron row with model, previews, stubs, tests. |
| [ ] | Profile model & state | `@immutable` data (setting/membership rows, version) + sealed `ProfileState`. |
| [ ] | Profile stubs | Deterministic offline settings/membership rows + version. |
| [ ] | SettingsListSection widget | SectionHeader + grouped ListRows + previews. |
| [ ] | ProfileScreen | Compose header/sections/version/logout, render states, pure tab body + previews. |
| [ ] | Wire into AppShell | Replace the Profile `_ComingSoon` placeholder. |
| [ ] | Tests | Render, row-tap interaction, logout callback, a11y; ListRow component tests. |

## Technical Notes

- `ListRow` is a new shared component under `lib/components/list_row/` (reusable for any settings-style list).
- Reuse the shared `PageHeader` (from US-002), `SectionHeader`, and the themed `ElevatedButton` for Log out.
- Row taps and logout are callbacks only (no backend/auth in this story).
- App version string lives in `AppStrings`; light theme only; tokens via `Theme.of(context)` / `AppSpacing`.

## Design Notes

- Figma frame: Les Mills — Member App Demo, node `13301:28482`.
- Section order: Page header → App Settings list → Membership list → App version footer → Log out button.
- Use `Icons.chevron_right` (direction-aware) for the trailing affordance; rows divided per the design-system divider token.

## Dependencies

- Shared `PageHeader` component (from US-002).
- New shared `ListRow` component (built within this story).
- `AppShell` (built) to host the tab.

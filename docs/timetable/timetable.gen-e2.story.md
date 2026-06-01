---
id: US-003
title: "Timetable tab — browse & book group fitness classes"
priority: high
status: ready
points: 8
assignee: ""
tags: [timetable, booking, les-mills, mobile]
epic: "App Navigation & Core Tabs"
createdAt: "2026-06-01"
updatedAt: "2026-06-01"
dueDate: null
---

# Timetable tab — browse & book group fitness classes

## User Story

As a **Les Mills member**
I want to **browse my club's class timetable by date and time of day and see availability**
So that **I can find and book the classes that fit my schedule**

## Acceptance Criteria

1. A segmented control lets the member switch between "Club timetable" and "My bookings".
2. A header shows the current month, the selected club/location, and a filter affordance.
3. A horizontally scrollable date strip lets the member pick a day; the selected day is visually distinct.
4. A time-of-day filter (Morning / Lunch / Afternoon / Night) lets the member narrow the list; the active segment is visually distinct.
5. The class list shows one card per class with: start time, duration, class name, studio/room, instructor, an availability/queue label (e.g. "8 available", "3 queued"), and a booking CTA (Book / Join queue).
6. The screen renders exhaustive states: Idle/Loading (skeleton), Loaded, Empty (no classes for the chosen day/filter), and Error (with Retry).
7. All copy, spacing, colour and typography use design-system tokens; the screen is light-theme only.
8. Accessibility: each class card is a single semantic group announcing class, time, room, instructor and availability; tap targets meet 44/48px; text scales to 2×; RTL mirrors correctly.

## Tasks

| Status | Title | Description |
|--------|-------|-------------|
| [ ] | Shared SegmentedTabs component | Generic 2+ option segmented control with model, previews, stubs, tests. |
| [ ] | Timetable model & state | `@immutable` data (class entries, dates, filters) + sealed `TimetableState`. |
| [ ] | Timetable stubs | Deterministic offline timetable data for loaded/empty/error states. |
| [ ] | TimetableDateStrip widget | Horizontal selectable date picker + previews. |
| [ ] | TimeOfDayFilter widget | Morning/Lunch/Afternoon/Night filter (uses SegmentedTabs) + previews. |
| [ ] | TimetableClassCard widget | Time • class • room • instructor • availability + CTA + previews. |
| [ ] | TimetableScreen | Compose toggle/header/date/filter/list, render states, pure tab body + previews. |
| [ ] | Wire into AppShell | Replace the Timetable `_ComingSoon` placeholder. |
| [ ] | Tests | Render, state, filter/date selection, a11y, CTA interaction; SegmentedTabs component tests. |

## Technical Notes

- Reuse `PillButton` for card CTAs and `SectionHeader` where a titled section is needed.
- `SegmentedTabs` is a new shared component under `lib/components/segmented_tabs/`.
- Date strip and filters are presentational — selection state lives in the screen; no live clock (`DateTime.now()` forbidden in stubs).
- Booking action is a callback only (no backend in this story).
- Light theme only; tokens via `Theme.of(context)` / `AppSpacing`.

## Design Notes

- Figma frame: Les Mills — Member App Demo, node `13301:27537`.
- Header order: Sections toggle → Month + Club selector → Date strip → Time-of-day pills → Class list → filter FAB.
- Time-of-day pills may use the Sunset accent gradients sparingly per the design system; primary surfaces stay off-white/white.
- Sample classes from frame: Ceremony, RPM, BodyPump, BodyStep, The Trip, Yoga, Conquer, BodyAttack, BodyCombat, Virtual classes, etc.

## Dependencies

- Shared `SegmentedTabs` component (built within this story).
- Existing `PillButton`, `SectionHeader` components.
- `AppShell` (built) to host the tab.

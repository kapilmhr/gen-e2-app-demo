# Component Conventions — Flutter / Dart (Les Mills)

Stack-specific conventions for Les Mills. Load this file alongside
[component-rules.md](./component-rules.md) when working on Flutter / Dart components.

---

## Project Conventions

| Aspect | Convention |
|---|---|
| Stack | Flutter / Dart |
| Shared component directory | `lib/components/<name>/` (reusable across screens) |
| Feature component directory | `lib/feature/<feature_name>/` (screen + its single-use sub-widgets) |
| File naming | snake_case |
| Component file | `<name>.dart` |
| Model file | `<name>_model.dart` |
| Stubs file | `<name>_stubs.dart` |
| Preview file | `<name>_previews.dart` |
| Test file | `<name>_test.dart` |
| State management | library-agnostic (none detected — props in, callbacks out) |
| Test framework | `flutter_test` (widget + golden) |
| Preview tool | Native Flutter Widget Previews (`@Preview`) |
| Animation library | platform default (`AnimatedSwitcher`, `AnimatedContainer`, implicit animations) |
| i18n library | not detected — centralise strings in `lib/l10n/app_strings.dart` |
| Design-system skill | `les-mills-design-system` |

**Layer decision:** reach for a shared component in `lib/components/` first. Only create a widget under `lib/feature/<feature_name>/` when it is genuinely used by that one screen.

---

## File Structure

For a **shared** `MetricCard` component:

```
lib/components/metric_card/
├── metric_card.dart            // StatelessWidget/StatefulWidget — props in, callbacks out
├── metric_card_model.dart      // @immutable model + sealed-class state (if data-driven)
├── metric_card_stubs.dart      // MetricCardStubs: loaded / empty / error / loading / longContent / list
└── metric_card_previews.dart   // @Preview functions — all states + config matrix, reuse stubs
```

For a **feature/screen** (e.g. Home), the screen and any single-use widgets co-locate:

```
lib/feature/home/
├── home_screen.dart            // Page widget — owns state, wires shared components
├── home_screen_previews.dart   // @Preview for the screen (idle/loaded/empty/error)
└── widgets/
    └── home_greeting_header.dart   // single-use sub-widget (+ _previews.dart)
```

Tests mirror the `lib/` path under `test/` — e.g. `test/components/metric_card/metric_card_test.dart`, feature tests at `test/feature/<feature>/...`.

---

## Preview Tool Notes

**Tool:** Native Flutter Widget Previews (`@Preview`)

Write one top-level (or `static`) function per preview in `<name>_previews.dart`, annotated with `@Preview(...)` from `package:flutter/widget_previews.dart`, returning a `Widget`. Use a shared local `_wrap(Widget)` helper that applies `AppTheme.light` and padding so each preview is isolated. Cover every state, then the happy path in dark (`brightness: Brightness.dark`), large text (`textScaleFactor: 2.0`), RTL (`Directionality`), and narrow width (`SizedBox(width: 320)`). Launch the live preview surface with `flutter widget-preview start`, or use the IDE's "Widget Preview" panel (auto-discovers `@Preview`-annotated functions under `lib/`). Previews must reuse the shared stubs — never inline data.

---

## Test Framework Notes

**Framework:** `flutter_test`

Query by semantics first: `find.bySemanticsLabel(...)` and `find.text(...)`; fall back to `find.byTooltip` / `find.byIcon`; use `find.byKey` only as an escape hatch. Assert accessibility with `meetsGuideline(textContrastGuideline / androidTapTargetGuideline / iOSTapTargetGuideline / labeledTapTargetGuideline)` inside an `ensureSemantics()` handle. Capture goldens with `matchesGoldenFile` reusing the same stubs as previews. Run all tests with `flutter test`; refresh goldens intentionally with `flutter test --update-goldens`.

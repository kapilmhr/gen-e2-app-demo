# Component Rules — Les Mills

The complete rules for building any component in this project. Self-contained. Load alongside SKILL.md.

---

## 1. Purpose

Every component in Les Mills follows these rules: single responsibility, exhaustive state, semantic tokens, mandatory accessibility, comprehensive previews, and stub-driven tests. The rules below apply to every Atom, Molecule, Organism, Template, and Page.

Two layers of components exist in this project:

- **Shared / reusable components** → `lib/components/<name>/`. Built to be used by more than one screen. Atoms and Molecules live here. Always shipped with a model, stubs, previews, and tests.
- **Feature / screen-specific components** → `lib/feature/<feature_name>/`. The screen itself plus any sub-component that only that screen uses. Reach for a shared component first; only create a feature-local widget when it is genuinely single-use.

Every component and every screen view ships with **previews** (Native Flutter Widget Previews via `@Preview`) and **stubs** — no exceptions.

### Feature folder map

The app's primary screens map to feature folders as follows. Sub-widgets used by only one screen live in that feature's `widgets/` folder; anything reused across two or more screens is promoted to `lib/components/`.

| Screen | Feature folder | Page widget |
|---|---|---|
| Splash | `lib/feature/splash/` | `splash_screen.dart` |
| Home | `lib/feature/home/` | `home_screen.dart` |
| Progress | `lib/feature/progress/` | `progress_screen.dart` |
| Timetable | `lib/feature/timetable/` | `timetable_screen.dart` |
| Explore | `lib/feature/explore/` | `explore_screen.dart` |
| Profile | `lib/feature/profile/` | `profile_screen.dart` |

Candidates for `lib/components/` (reused across the screens above): bottom navigation bar, class/session card, metric card, section header, avatar, pill chip/filter, primary/secondary buttons, empty-state, error-state, loading skeleton.

## 2. Project Conventions

Stack-specific conventions — component directory, file naming, state-management library, test framework, preview tool, file-structure tree — live in the stack reference file for your stack. See `## Stack References` in SKILL.md to find the right file: [flutter.md](./flutter.md).

## 3. Single Responsibility & API Surface

Universal rules for how every component is structured. The Flutter reference provides idiomatic syntax; this section provides the principles.

### Single Responsibility 🔴

Every component has **exactly one job**. State it in one sentence starting with a verb.

- ✅ "Displays a user's avatar with optional online indicator"
- ✅ "Collects and validates a single form field with label and error message"
- ❌ "Handles user profile display and editing" → two components
- ❌ "Shows a card with data fetching" → separate UI from data source

**Test:** if you need "and" to describe it, split it.

**Split threshold:** if the widget `build` method exceeds ~60–80 lines or the constructor takes more than ~5–6 parameters, extract sub-widgets or introduce slot (`Widget child` / `WidgetBuilder`) APIs.

### Unidirectional Data Flow 🔴

Data flows **down** through constructor parameters. Events flow **up** through callbacks. This is the foundational pattern across all UI frameworks and is mandatory here.

- Component receives immutable data and optional callbacks
- Component never fetches data, navigates, or writes to global state internally
- Component never imports or instantiates a ViewModel, service, repository, or singleton
- Parent decides what to do with events; component only reports them via `VoidCallback` / `ValueChanged<T>`

**Screen-level components** (the page widget under `lib/feature/<feature_name>/`) are the exception — they own the state holder, collect state, and wire child components. They get 2–3 integration previews; exhaustive coverage lives on the child components in `lib/components/`.

### Composition Strategy 🟡

Flutter offers three primary composition tools. Choose based on what changes the hierarchy:

| Mechanism | Use When | Flutter form |
|-----------|----------|--------------|
| **Cross-cutting behaviour** | Applying appearance/behaviour without changing structure (padding, elevation, shimmer) | A wrapper widget (`Padding`, `Card`) or an extension method that wraps a child |
| **Wrapper component** | Composing multiple children into a new semantic unit (label + field + error = `LabeledField`) | A `StatelessWidget` / `StatefulWidget` subclass |
| **Slot API** | Letting the caller supply content into named positions | `Widget` / `Widget?` params (`leading`, `trailing`), `WidgetBuilder`, `IndexedWidgetBuilder` |

**Decision rule:** if functionality applies to any widget and does *not* add/remove children, make it a wrapper or extension. If it *must* add children, it is a wrapper widget.

**Internal layout test:** if changing the internal layout direction (`Row` ↔ `Column`) would break the public API, you have exposed too much. Expose *intent* (`isCompact`, `variant`), not structure.

### API Surface Design 🟡

#### Required vs Optional Parameters

- **Required**: data the component cannot function without (primary content, essential callbacks) → positional or `required` named.
- **Optional**: customisation, variants, styling overrides — always provide sensible defaults.
- **Rule**: a component should render something useful with only its required parameters.

#### Parameter Categories

| Category | Naming Pattern | Examples |
|----------|---------------|---------|
| Data | Noun describing the content | `title`, `amount`, `user`, `items` |
| Boolean state | `is*` / `has*` / adjective | `isLoading`, `hasError`, `disabled` |
| Callbacks | `on*` + event name | `onTap`, `onChanged`, `onDismiss`, `onSubmit` |
| Slots/builders | Noun describing the slot | `leading`, `trailing`, `header`, `content` |
| Style override | Flutter convention | named params; `Key? key` via super |

#### Callback Signatures

Always declare the full type — never use bare `Function` when the callback carries data:

- ✅ `final ValueChanged<ClassSession> onSessionSelected;` — caller knows what data arrives
- ❌ `final Function onSessionSelected;` — opaque, untyped

#### Flutter Entry Point

Every Flutter widget accepts `Key? key` via the super-initializer and exposes its customisation through named parameters. Prefer `const` constructors wherever the widget is immutable.

```dart
class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
    required this.model,
    this.onTap,
    this.isCompact = false,
  });

  final MetricCardModel model;
  final VoidCallback? onTap;
  final bool isCompact;
}
```

→ See [flutter.md](./flutter.md) for exact conventions.

### Slot-Based Composition

Components above Atom level should expose **named slots** rather than accepting raw data for sub-sections:

- Use **data parameters** for Atoms and simple Molecules with fixed internal structure
- Use **slots** (`Widget`/`Widget?`) for Organisms and Templates that need layout flexibility
- Use **builder callbacks** (`WidgetBuilder`, `IndexedWidgetBuilder`) when slot content depends on index or runtime data (lists, grids)

### Component File Organisation

#### Co-location (the project default)

Place the component, its model, previews, and tests together:

```
lib/components/metric_card/
├── metric_card.dart            // implementation
├── metric_card_model.dart      // data + state sum type
├── metric_card_stubs.dart      // realistic stub data
└── metric_card_previews.dart   // @Preview functions (all states)
test/components/metric_card/
└── metric_card_test.dart       // all test categories, reuse stubs
```

Feature-local widgets co-locate the same way under `lib/feature/<feature_name>/`.

### API Stability 🟡

- Keep the public API minimal — fewer parameters = easier to maintain
- New features are added as **optional named parameters with defaults** — never break existing callers
- Extract internal sub-widgets as private (`_LeadingIcon`) — they are not part of the contract
- If a component needs more than ~8 required parameters, it likely needs decomposition

### Anti-Patterns

| Anti-Pattern | Problem | Fix |
|-------------|---------|-----|
| God component | Does too many things, 200+ lines | Split by responsibility |
| Prop drilling | Passing data through 3+ layers untouched | Use `InheritedWidget`/context, or restructure composition |
| Stringly typed | Using strings for variant/state selection | Use `enum` / `sealed class` |
| Boolean blindness | `isLoading, isError, isEmpty` as separate bools | Single state sum type (see §4) |
| Hidden dependencies | Component internally fetches data or reads singletons | Accept data and callbacks via parameters |
| Style leaking | Component applies styles that affect its parent's layout | Styles stay within bounds; parent controls placement |
| Inheritance abuse | Subclassing a framework widget to add features | Compose with slots, wrappers |

## 4. Exhaustive State Modeling

How to model component state so it is exhaustive, impossible to be invalid, and clearly communicates every possible display mode.

### The Core Rule 🔴

**Make illegal states unrepresentable.**

Model state as a **`sealed class`** (Dart sum type) where:
- Each subclass represents one mutually exclusive state
- Data relevant to a state lives only inside that subclass
- An exhaustive `switch` expression forces handling — adding a new state produces a compile error at every unhandled site

### Why Sum Types, Not Boolean Flags

| Approach | Problem |
|----------|---------|
| `bool isLoading, isError, isEmpty` | 2³ = 8 combinations, most invalid. What does `isLoading && isError` mean? |
| `Data? data, String? error` | Nullable combinations are ambiguous. Is `data == null` loading or empty? |
| `String state = 'loading'` | No compiler checking. Typos compile fine. No associated data. |
| **`sealed class` with subclasses** | Exactly N valid states. Compiler-checked exhaustive `switch`. Data co-located with its state. |

### Required States

Every component that displays data from an external source must handle these states:

| State | What it represents | Associated data |
|-------|--------------------|----------------|
| **Idle** | Initial state before any action | None |
| **Loading** | Async operation in progress | Optional progress |
| **Loaded / Success** | Data available | The data itself |
| **Error** | Operation failed | Error message, optional retry action |
| **Empty** | Succeeded but returned no data | Optional message or CTA |

**Pure-display components** (Atoms that only render what they receive) may not need their own state model — they render parameters directly. Their **parent** owns the state model. When skipping a state model, add a one-line comment saying so.

**Interactive components** add as needed: Focused, Disabled, Selected / Active, Pressed / Hover, Validating, Valid / Invalid.

### Dart Mechanism

```dart
sealed class TimetableState {
  const TimetableState();
}

class TimetableIdle extends TimetableState {
  const TimetableIdle();
}

class TimetableLoading extends TimetableState {
  const TimetableLoading();
}

class TimetableLoaded extends TimetableState {
  const TimetableLoaded(this.sessions);
  final List<ClassSession> sessions;
}

class TimetableEmpty extends TimetableState {
  const TimetableEmpty({this.message});
  final String? message;
}

class TimetableError extends TimetableState {
  const TimetableError(this.message, {this.onRetry});
  final String message;
  final VoidCallback? onRetry;
}
```

Rendered with an exhaustive `switch` expression — no `default` clause, so a new state is a compile error until handled:

```dart
Widget build(BuildContext context) => switch (state) {
  TimetableIdle() => const SizedBox.shrink(),
  TimetableLoading() => const _TimetableSkeleton(),
  TimetableLoaded(:final sessions) => _TimetableList(sessions: sessions),
  TimetableEmpty(:final message) => _TimetableEmpty(message: message),
  TimetableError(:final message, :final onRetry) =>
    _TimetableError(message: message, onRetry: onRetry),
};
```

### State Hoisting Rules

#### Component owns (UI state)
- Animation progress, hover/pressed/focus state
- Local toggles (expanded/collapsed, show/hide)
- Scroll position, text cursor position

#### Parent owns (business state)
- Data loading / loaded / error / empty
- Selected items in a list
- Form field values (when parent needs them)
- Navigation decisions

#### The boundary

The component **receives** business state via parameters and **reports** user actions via callbacks. It never fetches data, navigates, or writes to global state internally.

### When to Use State Machines vs Simple Sum Types

- **Simple sum type (most components)** — straightforward transitions: idle → loading → loaded/error. No formal state machine needed.
- **State machine (complex flows)** — when there are guards, side effects tied to transitions, the same event produces different outcomes depending on current state, or the flow has cycles (retry → loading → error → retry).

For most UI components, **a simple sum type with exhaustive `switch` is sufficient**.

### Anti-Patterns

| Anti-Pattern | Problem | Fix |
|-------------|---------|-----|
| Separate boolean flags | Impossible combinations compile fine | Single sum type |
| Nullable data + nullable error | Ambiguous null semantics | Sum type with data in correct variant |
| String-typed state | No compiler safety, no associated data | `enum` or `sealed class` |
| State owned inside component | Component fetches its own data | Hoist to parent; pass state as parameter |
| Missing empty state | Only handles loaded and loading | Always define `Empty` as a variant |
| Missing idle state | Component starts in loading — but what if not triggered? | `Idle` is the initial state |

## 5. Design Tokens



How every component consumes the design system: colours, typography, spacing, elevation, and shape. No component may contain hardcoded appearance values.

### The Cardinal Rule 🔴

**Never hardcode a colour, font size, spacing value, or elevation literal.** Every appearance value is resolved from a semantic token at render time.

Hardcoded values:
- Break when themes change (brand themes, dynamic colour)
- Require find-and-replace across the codebase for design updates
- Cannot be overridden by the design system

### Token Resolution Order

When styling a component, resolve tokens in this priority order:

1. **Component-level theme** — the design system configures a widget theme (e.g., `CardTheme`, `ElevatedButtonTheme`) in `AppTheme` — read it implicitly by using the standard widget.
2. **Semantic token** — a role-based token via `Theme.of(context).colorScheme.*` / `Theme.of(context).textTheme.*`.
3. **Scale token** — a value from `AppSpacing.*` (4-based scale).
4. ❌ **Raw literal** — a hex code, pixel value, or magic number → **never allowed**.

### Colour Tokens 🔴

Components reference **intent**, not raw values. In Flutter, read through `Theme.of(context).colorScheme`:

| Role | Usage |
|------|-------|
| `primary` | Primary brand action (buttons) |
| `onPrimary` | Content on primary surfaces |
| `surface` | Default background (cards = `white`) |
| `onSurface` | Content on surface |
| `surfaceContainerLowest` | App canvas (`off-white`) |
| `error` | Error states |
| `onError` | Content on error backgrounds |
| `outline` | Borders and dividers |
| `outlineVariant` | Subtle borders |

For tokens with no semantic slot (Sunset accents/gradients, beiges, status colours, `darkestBlue`, tinted neutral blues), use the named `AppColors.*` constants directly — this is the only sanctioned use of the palette constants. `lib/theme/app_colors.dart` is the **only** file permitted to contain `Color(0xFF…)` literals.

Quick reference for the no-slot tokens (full list in the design-system skill):

| Group | Tokens | Use |
|---|---|---|
| Status | `AppColors.error`, `AppColors.success` | Feedback (validation, toasts) |
| Sunset accents | `AppColors.darkOrange`, `AppColors.lightOrange`, `AppColors.secondaryBlue`, `AppColors.blue`, browns | Accents & gradients, used sparingly |
| Beiges | `AppColors.lightBeige`, `AppColors.beige`, `AppColors.darkBeige` | Tinted surfaces / gradient stops only |
| Tinted neutrals | `AppColors.neutralBlue`, `AppColors.neutralLightBlue`, `AppColors.darkestBlue` | Subtle tinted backgrounds / deep accents |

#### Light theme is the source of truth

This app is **light-theme only**: the canvas is `off-white` (`#F8F9F9`) with `white` cards. Light is the default in `AppTheme.light` and in every preview. Never use a dark canvas on primary surfaces, and never branch on `Brightness` to pick a colour in component code. The Configuration Matrix in §9 still renders a dark-mode preview so contrast regressions are caught, but the shipped app stays light.

### Typography Tokens 🔴

Use semantic typography roles via `Theme.of(context).textTheme`, never raw font sizes. The scale is Untitled Sans (`displayLarge…labelSmall`). Override colour only (`.copyWith(color: ...)`), never size or weight.

#### Text Scaling 🔴

- **All text must scale** with the user's system text-size preference. No exceptions for body content.
- Never set a fixed text size that ignores `MediaQuery.textScaler`.
- Caps on `textScaler` are only acceptable for tiny, non-content elements (badges, icons) — never for readable text.

### Spacing Tokens 🟡

Use `AppSpacing.*` (4-based scale, defined in `lib/theme/app_spacing.dart`). Never magic numbers.

| Token | Value | Typical use |
|---|---|---|
| `AppSpacing.s1` | 4 | Tight internal separation |
| `AppSpacing.s2` | 8 | Standard internal padding; small radii |
| `AppSpacing.s3` | 12 | Card padding; card corner radius |
| `AppSpacing.s4` | 16 | Standard section / screen edge padding |
| `AppSpacing.s5` | 24 | Section gaps |
| `AppSpacing.s6` | 32 | Major section separation |
| `AppSpacing.s7` | 48 | Button min height; large blocks |
| `AppSpacing.s8` | 64 | Page-level spacing |

Corner radii snap to `s2`/`s3`; pill buttons use `StadiumBorder` (not a raw radius).

- **Never use magic numbers**: `EdgeInsets.all(16)` → `EdgeInsets.all(AppSpacing.s4)`
- **Never compute from screen dimensions**: no `screenWidth * 0.9` for content width. Use `Expanded` / `Flexible` / `ConstrainedBox`.
- **Directional spacing**: use `EdgeInsetsDirectional` (`start`/`end`), not `EdgeInsets` left/right, to support RTL mirroring.
- **Consistent gap**: use `Row`/`Column` with `spacing:` (Flutter 3.27+) or a shared gap widget — not margins on each child.

### Elevation & Shape Tokens 🟡

- Elevation comes from the configured `CardTheme` / component themes — do not pass arbitrary `elevation:` literals.
- Border radius uses the spacing scale (`BorderRadius.circular(AppSpacing.s3)`), never magic numbers like `12`.
- Shadows are subtle on the light canvas — rely on the `CardTheme` elevation + `outlineVariant` borders for definition.

### Animation & Motion Tokens 🟡

Animation durations and easing curves are design tokens, not hardcoded values:

| Token | Typical Value | Usage |
|-------|--------------|-------|
| `duration.fast` | 100–150ms | Micro-interactions (hover, press) |
| `duration.normal` | 200–300ms | State transitions (show/hide, expand) |
| `duration.slow` | 400–500ms | Major transitions (page change, modal) |

- **Reduce-motion**: when `MediaQuery.disableAnimations` (or `MediaQuery.of(context).accessibleNavigation`) is true, set durations to `Duration.zero`.
- **State-driven animation**: animations respond to state changes (use `AnimatedSwitcher`, `AnimatedContainer`), not imperative triggers.

### Project Tokens

This project's tokens are defined in the `les-mills-design-system` skill:
- Colour, type, spacing, elevation, radius values → [`../les-mills-design-system/references/tokens.md`](../les-mills-design-system/references/tokens.md)
- Stack-specific API examples → [`../les-mills-design-system/references/flutter-dart.md`](../les-mills-design-system/references/flutter-dart.md)

Concrete in-repo token sources:
- `lib/theme/app_colors.dart` — named palette constants
- `lib/theme/app_text_styles.dart` — Untitled Sans type scale
- `lib/theme/app_spacing.dart` — 4-based spacing scale
- `lib/theme/app_theme.dart` — `AppTheme.light` assembling `ColorScheme`, `TextTheme`, and component themes

The principles above describe **what** to use; the design-system skill and theme files provide **the values**. Never bypass them — every appearance value in a component must trace back to a token. If a token does not exist yet, add it to the theme files first.

### Token Audit Checklist

- [ ] Zero hardcoded colour literals (hex, `Color(0x...)`, `Colors.*`)
- [ ] Zero hardcoded font sizes or weights
- [ ] Zero magic-number spacings — all from `AppSpacing.*`
- [ ] All text scales with `MediaQuery.textScaler`
- [ ] Component renders correctly in light mode (the shipped mode)
- [ ] Component still renders acceptably in the dark-mode preview (contrast check)
- [ ] Colour read through `Theme.of(context).colorScheme.*` or sanctioned `AppColors.*`
- [ ] Elevation/radius come from component themes / spacing scale
- [ ] Directional spacing uses `EdgeInsetsDirectional`, not left/right

## 6. Internationalisation (i18n)

No i18n library was detected in this project. If the project targets a single locale, centralise any text constants in a dedicated constants file (e.g. `lib/l10n/app_strings.dart`) rather than scattering string literals across components. If multilingual support is added later, run `create-component-library-skill` to regenerate this section with full enforcement rules for the chosen library (Flutter's `flutter_localizations` + `intl` with `gen-l10n`).

Even without an i18n library:
- Keep user-visible copy out of deep widget trees — pass it in or read it from a single strings source.
- Accessible labels (`Semantics(label: ...)`) count as user-visible text — centralise them too.

## 7. Accessibility (Mandatory)

Accessibility is enforced via the standalone **`accessibility`** skill — load it alongside this component library skill for comprehensive, platform-specific guidance (WCAG 2.2 AA, Apple HIG, Material Design guidelines).

**Non-negotiable component requirements (no exceptions):**
- Semantic roles and labels on all interactive and informative elements (`Semantics`, `Tooltip`, `ExcludeSemantics` for decorative)
- Touch/tap targets ≥ 44 × 44 pt (iOS) / 48 × 48 dp (Android) — enforce with `MaterialTapTargetSize.padded` or explicit `SizedBox`/`ConstrainedBox`
- Colour contrast ≥ 4.5:1 body text, ≥ 3:1 large text and UI components
- Focus order follows the visual/logical reading order; no focus traps
- Motion: honour `MediaQuery.disableAnimations` / reduce-motion
- Screen reader: test with VoiceOver / TalkBack; all interactive elements reachable and labelled
- Text scaling: layout must not break at 2× text scale; use relative units and avoid fixed heights on text containers
- RTL: layout mirrors correctly via `EdgeInsetsDirectional` and `Directionality`

For complete platform-specific rules and the full audit checklist, **always load the `accessibility` skill**.

## 8. Data Models & Stubs

How to define the data models components consume and the stub factories used in previews and tests.

### Data Model Design 🔴

#### Principles

1. **Plain data** — models are immutable data containers, not living objects with behaviour
2. **No framework dependencies** — models never import `package:flutter/material.dart` (UI) code; pure Dart only
3. **No side effects** — models don't trigger network calls, write to disk, or navigate
4. **Type-safe state** — use sum types for states (see §4), not optional/nullable fields
5. **Serialisable** — models can be serialised/deserialised without framework coupling

#### Structure

A component model contains:

| Field Type | Purpose | Example |
|-----------|---------|---------|
| Required data | What the component must display | `final String title;`, `final int streakDays;` |
| State enum | Current display mode | `final TimetableState state;` |
| Optional metadata | Extra context when available | `final String? subtitle;` |
| Display helpers | Pre-computed presentation values (as getters) | `String get formattedDuration` |

#### Naming

- Model name matches the component: `MetricCard` → `MetricCardModel`
- Sum-type subclasses named for what they represent: `Loaded`, `Error`, `Empty` — not `Case1`, `State2`
- Associated data named for its content: `TimetableLoaded(this.sessions)`, `TimetableError(this.message)`

### Immutability 🔴

- All model fields are **`final`**
- Annotate with `@immutable`
- Updates produce **new instances** via a `copyWith` method, not mutations
- Implement value equality (`==`/`hashCode`, or use `equatable`/records) so the framework can skip rebuilds when data is unchanged

```dart
@immutable
class MetricCardModel {
  const MetricCardModel({
    required this.label,
    required this.value,
    required this.trend,
  });

  final String label;
  final String value;
  final Trend trend;

  MetricCardModel copyWith({String? label, String? value, Trend? trend}) =>
      MetricCardModel(
        label: label ?? this.label,
        value: value ?? this.value,
        trend: trend ?? this.trend,
      );

  @override
  bool operator ==(Object other) =>
      other is MetricCardModel &&
      other.label == label &&
      other.value == value &&
      other.trend == trend;

  @override
  int get hashCode => Object.hash(label, value, trend);
}
```

### Stub Factories 🔴

Every model exposes **static factory members** for preview/test data. In Dart, use static getters or a dedicated `<name>_stubs.dart` file.

#### Required Stubs

| Stub | What it provides |
|------|-----------------|
| Loaded / happy-path | Realistic data with all fields populated |
| Empty | Valid but empty state (zero items, no content) |
| Error | Error state with realistic message |
| Loading | Loading/in-progress state |
| Long content | Edge case: very long text, many items (tests overflow) |
| List (count) | Multiple varied instances (for list previews) |

```dart
// metric_card_stubs.dart
abstract final class MetricCardStubs {
  static const loaded = MetricCardModel(
    label: 'Classes this month',
    value: '18',
    trend: Trend.up,
  );

  static const longContent = MetricCardModel(
    label: 'Total accumulated workout minutes across all programmes',
    value: '12,480',
    trend: Trend.flat,
  );

  static const list = <MetricCardModel>[
    MetricCardModel(label: 'Streak', value: '6 days', trend: Trend.up),
    MetricCardModel(label: 'Avg. heart rate', value: '142 bpm', trend: Trend.flat),
    MetricCardModel(label: 'Calories', value: '540', trend: Trend.down),
  ];
}
```

#### Rules for Stub Data

1. **Deterministic** — same stub returns identical data every time (no `Random`, no `DateTime.now()`)
2. **Realistic** — use plausible values ("Emily Chen", "BODYPUMP", "540 cal"), not placeholders ("Test", "Lorem ipsum")
3. **Self-contained** — no network, database, or system dependency
4. **Varied** — list stubs use different names, values, states (not N copies of the same item)
5. **Reusable** — previews and unit tests ALL consume the same stubs

#### Placement

Stubs live alongside the model in `<name>_stubs.dart` in the same component folder, or as `static` members on the model type.

### Extensions / Computed Properties 🟡

Add presentation logic as **getters or extensions** on the model — not inside the widget `build` method:

- Formatting: `model.formattedDuration` → "45 min"
- Derived state: `model.isPositive` → `trend == Trend.up`
- Display helpers: `model.trendIcon` → appropriate `IconData`

**Why getters/extensions, not widget logic:** testable in isolation (no `WidgetTester` needed), reusable across components, single source of truth.

### When to Skip a Dedicated Model

| Scenario | Model needed? |
|----------|--------------|
| Atom with 1–2 primitive props (icon, label) | No — use direct parameters |
| Component with 3+ related fields | Yes |
| Component with state enum | Yes — the sum type IS the model |
| List item | Yes — model per item |
| Screen-level data with many sources | Yes — aggregate model |

### Anti-Patterns

| Anti-Pattern | Problem | Fix |
|-------------|---------|-----|
| Mutable model fields | Unpredictable UI | All fields `final` + `@immutable` |
| Model fetches its own data | Couples data layer to presentation | Model is passive data |
| Stubs use `Random`/`DateTime.now()` | Non-deterministic previews and test flakiness | Hard-coded realistic values |
| Stubs import production services | Breaks preview isolation | Stubs are pure data |
| Model contains widget types | Can't unit-test without UI dependency | Plain Dart types only |
| Single stub for all tests | Doesn't exercise edge cases | Dedicated stubs per scenario |

## 9. Previews / Stories

Previews are the primary documentation of a component. They prove it works across all states, themes, and accessibility configurations before it reaches users. **Every component and every screen view in this project ships with previews.**

### Purpose

Previews serve three roles simultaneously:

1. **Documentation** — shows developers every state and variant at a glance
2. **Visual testing** — golden tests can reuse the same stubs and configurations as baselines
3. **Validation** — confirms the component handles edge cases before code review

### State Coverage 🔴

Every component must have previews covering ALL states from its state model:

| State | Preview shows |
|-------|-------------|
| Idle | Initial appearance before any data operation |
| Loading | Skeleton, spinner, or shimmer |
| Loaded / Success | Happy-path data |
| Error | Error message, retry action |
| Empty | Operation succeeded but returned no data |
| Long content | Text overflow, list overflow, very long names |
| All enum variants | Every variant of any display enum (trend up/down/flat) |

**Rule:** if a state exists in the model, it must be visible in a preview. No state may be "code-only."

### Configuration Matrix 🟡

Beyond states, verify visual correctness across system configurations:

| Dimension | Variations |
|-----------|-----------|
| **Theme** | Light (default + shipped) + Dark (contrast check only) |
| **Text scale** | Default (1.0×) + Large (2.0×) |
| **Layout direction** | LTR + RTL |
| **Width** | Standard + Narrow (compact) |

#### Practical approach (manageable preview count)

1. **All states** in default configuration (light, 1×, LTR, standard width)
2. **Happy-path state** in every other configuration (dark, large text, RTL, narrow)
3. **Error/empty states** in dark mode (they're commonly missed)

> Light is the project's default and shipped appearance. The dark-mode preview exists purely to catch contrast/hardcoded-colour regressions — it is not a supported runtime theme.

### Stub Usage 🔴

- Previews consume the **same stubs** defined in the model layer (see §8)
- **Never** create one-off inline data in previews — it drifts from test data
- **Never** use network, database, state-holder, or any live dependency
- Stubs are deterministic → previews render identically on every machine

### Preview Isolation 🔴

Each preview is completely self-contained:

- No app initialisation required
- No navigation stack
- No global state
- No authenticated session
- Theme/locale/accessibility settings injected via the preview's `theme`/`wrapper`, not app bootstrap

### Native Flutter Widget Previews

This project uses **Native Flutter Widget Previews** — top-level (or static) functions annotated with `@Preview()` from `package:flutter/widget_previews.dart`, returning a `Widget`. They live in a co-located `<name>_previews.dart` file and reuse the shared stubs.

```dart
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../theme/app_theme.dart';
import 'metric_card.dart';
import 'metric_card_stubs.dart';

@Preview(name: 'Loaded')
Widget metricCardLoaded() => _wrap(MetricCard(model: MetricCardStubs.loaded));

@Preview(name: 'Long content')
Widget metricCardLongContent() =>
    _wrap(MetricCard(model: MetricCardStubs.longContent));

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget metricCardDark() => _wrap(MetricCard(model: MetricCardStubs.loaded));

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget metricCardLargeText() => _wrap(MetricCard(model: MetricCardStubs.loaded));

// Shared preview scaffold: applies the project theme + padding so each
// preview renders in isolation against the real design tokens.
Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(body: Center(child: Padding(
        padding: const EdgeInsets.all(16), child: child))),
    );
```

For RTL, wrap the child in `Directionality(textDirection: TextDirection.rtl, child: ...)`. For narrow width, constrain with `SizedBox(width: 320, child: ...)`.

→ See [flutter.md](./flutter.md) for the file naming pattern and how to run the preview tool.

### Multi-Preview Strategy

Rather than writing N × M individual previews:

1. **Define stubs** as a collection of all states (see `MetricCardStubs.list`)
2. **Write one `@Preview` per state** plus one per non-default configuration of the happy path
3. **Use the shared `_wrap` helper** to apply theme/scale/direction consistently

### Anti-Patterns

| Anti-Pattern | Problem | Fix |
|-------------|---------|-----|
| Preview only shows loaded state | Misses error/empty/loading rendering issues | Cover all states |
| Preview uses live data/network | Non-deterministic, slow | Use stubs only |
| Preview creates inline stub data | Diverges from test stubs over time | Import shared stubs |
| Only previewing default config | Large-text / RTL / contrast regressions undetected | Include the configuration matrix |
| Preview requires full app bootstrap | Slow, fragile | Inject only theme + locale via `_wrap` |
| Static-only previews | Interactive states untested | Include pressed/disabled where possible |

### Preview Checklist

- [ ] Every model state has a corresponding `@Preview`
- [ ] Happy-path rendered in dark mode (contrast check)
- [ ] Happy-path rendered at 2× text scale
- [ ] Happy-path rendered in RTL
- [ ] Happy-path rendered at narrow width
- [ ] Long-content edge case previewed
- [ ] All previews use shared stubs (not inline data)
- [ ] No network/database/state-holder in previews
- [ ] Preview renders instantly (< 1 second)

## 10. Testing

How to test components thoroughly. Tests validate behaviour, accessibility, visual correctness, and interaction — not implementation details.

### Testing Pyramid

| Level | Volume | What it validates | Speed |
|-------|--------|-------------------|-------|
| **State / Logic** | Many | State transitions, model transformations, computed getters | Instant |
| **Render / Widget** | Moderate | Correct output for each state, accessibility attributes present | Fast |
| **Snapshot / Golden** | Moderate | No unintended visual changes across states and configurations | Fast |
| **Interaction** | Some | User gestures trigger correct callbacks and state changes | Medium |
| **Integration** | Few | Component works correctly within parent (screen-level) | Slower |

### Test Categories

#### 1. State Logic Tests 🔴

Test the state model and its transitions in isolation (no `WidgetTester` needed):

- Every sum-type subclass can be constructed
- Computed getters return correct values for each state
- Extensions format data correctly
- Model equality / hashCode work correctly
- Invalid state combinations are impossible to construct

#### 2. Render Tests 🔴

Verify the component renders the correct structure for each state with `WidgetTester`:

- Each state produces the expected content (text, icons, visibility)
- Loading state shows loading indicator
- Error state shows error message and retry action
- Empty state shows empty message
- Loaded state displays all data fields correctly

#### 3. Accessibility Tests 🔴

Verify accessibility attributes are correct (`flutter_test` `meetsGuideline`):

```dart
final handle = tester.ensureSemantics();
await expectLater(tester, meetsGuideline(textContrastGuideline));
await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
handle.dispose();
```

- Interactive elements have accessibility labels
- Roles are declared
- Touch targets meet minimum size
- State is communicated (disabled, selected)
- Decorative elements are hidden (`ExcludeSemantics`)

#### 4. Snapshot / Golden Tests 🟡

Capture visual output as reference images and detect unintended changes:

- Use the **same stubs** as previews (single source of truth)
- Capture all meaningful states with `matchesGoldenFile`
- Capture dark mode (contrast), large text, RTL variants
- Keep golden files in version control
- Update intentionally (not blindly): `flutter test --update-goldens`

#### 5. Interaction Tests 🟡

Verify user gestures produce the correct outcomes:

- `tap` triggers `onTap` callback with correct data
- Text input updates bound value
- Disabled state blocks interaction (callback NOT fired)
- State changes after interaction produce correct re-render

### Test Query Strategy 🔴

Query elements the way assistive technology does — by semantics, not implementation:

| Priority | Flutter finder | When to use |
|----------|----------------|------------|
| 1 | `find.bySemanticsLabel` | Interactive/labelled elements |
| 2 | `find.text` | Visible text (headings, body) |
| 3 | `find.byTooltip` | Elements with tooltips |
| 4 | `find.byIcon` | Icon-only elements |
| 5 | `find.byKey` | **Escape hatch** — only when semantic queries fail |

**Rule:** if you can't query a component by semantics, the component has an accessibility bug. Fix the component, don't add keys.

### What NOT to Test

- Internal implementation details (private state, internal widget names)
- Flutter framework behaviour (animation timing, layout engine)
- Third-party library correctness (the theme provider works)
- Exact pixel positions (unless layout accuracy is the feature)

### Test Data 🔴

- Reuse the **same stubs** from the model's stub factories (see §8)
- Never create parallel test fixtures that duplicate stub data
- Test realistic data, not "test123"

### Test Identifiers

When a `Key` is needed (the escape hatch):
- Define in a shared constants file — not inline strings
- Use semantic names: `Key('metric-card-retry-button')` not `Key('btn1')`
- Keep in sync between component and test via shared reference

→ See [flutter.md](./flutter.md) for run commands and query priority.

### Anti-Patterns

| Anti-Pattern | Problem | Fix |
|-------------|---------|-----|
| Testing implementation | Brittle tests break on refactor | Test behaviour and output |
| No accessibility tests | A11y bugs ship undetected | `meetsGuideline` in every component test |
| Test uses production services | Slow, flaky | Use stubs, mock boundaries only |
| Duplicated test data | Stubs drift from preview data | Single shared stubs |
| Only happy-path tests | Error/empty states untested | Cover ALL states |
| Key instead of semantic query | Masks accessibility gaps | Fix a11y, then query semantically |
| Snapshot-only testing | Can't tell if behaviour is correct from pixels | Combine with logic + render tests |
| No dark-mode golden | Contrast issues undetected | Include a dark-mode golden |

### Testing Checklist

- [ ] State logic tested: all variants construct correctly, getters work
- [ ] Render tested: each state produces correct output
- [ ] Accessibility tested: labels, roles, targets, grouping (`meetsGuideline`)
- [ ] Interaction tested: callbacks fire correctly, disabled blocks input
- [ ] Golden for all meaningful states
- [ ] Dark-mode + large-text + RTL + narrow-width variants in golden suite
- [ ] All tests use shared stubs (not parallel fixtures)
- [ ] Tests query by semantics (not keys unless unavoidable)
- [ ] No test imports production services or network

## 11. File Structure for This Project

Concrete file-structure trees (directory layout and naming for an example component) are in the stack reference file — see [flutter.md](./flutter.md) `## File Structure`.

## 12. Component Spec Template

When documenting a component (optional but recommended for Organisms and above):

```markdown
# <ComponentName>

**Purpose:** <one-sentence verb statement>
**Atomic level:** Atom | Molecule | Organism | Template | Page
**Layer:** shared (lib/components/) | feature (lib/feature/<feature>/)
**Composition:** <child components>

## Props
| Name | Type | Required | Default | Description |
|---|---|---|---|---|

## States
- Idle / Loading / Loaded / Error / Empty (and others as needed)

## Accessibility
- Role: ...
- Label: ...
- Touch target: ...
- Notable: ...

## Tokens Used
- color: ...
- typography: ...
- spacing: ...

## Edge Cases
- [ ] Long content
- [ ] Empty data
- [ ] Error state
- [ ] 2× text scale
- [ ] RTL
- [ ] Narrow width
- [ ] Dark mode (contrast check)
```

## 13. Self-Audit Checklist

Run before declaring a component done.

1. [ ] Single responsibility — one sentence, one verb
2. [ ] Correct layer — shared component in `lib/components/<name>/`, screen-only widget in `lib/feature/<feature>/`
3. [ ] All params typed; required vs optional explicit; defaults stated; `const` constructor where possible
4. [ ] State modelled with a Dart `sealed class` (or skipped for pure-display Atoms with a one-line note)
5. [ ] All applicable states present: Idle, Loading, Loaded, Error, Empty (+ interaction states)
6. [ ] Zero hardcoded colours, spacing, type, elevation, radius, or motion values
7. [ ] All token access goes through the project's token source (the `les-mills-design-system` skill / `lib/theme/*`)
8. [ ] Zero hardcoded user-visible strings — labels centralised (the platform's string resource mechanism — no i18n lib detected — centralise in a constants file)
9. [ ] Accessibility: role, label, touch target, contrast, focus, motion, text scaling, RTL all verified
10. [ ] Models defined as immutable (`@immutable`, all `final`, `copyWith`, value equality); stubs cover Loaded, Empty, Error, Loading, Long-content, List
11. [ ] Stubs use realistic data — no `test123`, no Lorem ipsum, no `Random`/`DateTime.now()`
12. [ ] Previews (`@Preview`) exist for every state + dark mode + 2× text + RTL + narrow width, using shared stubs
13. [ ] Tests cover render, state transitions, a11y (`meetsGuideline`), interactions — using shared stubs
14. [ ] Test queries prefer semantics (`bySemanticsLabel` / `find.text`); keys only as escape hatch
15. [ ] Files follow snake_case naming + the directory conventions for this stack (see [flutter.md](./flutter.md) §Project Conventions)
16. [ ] No leaf component imports state-management primitives or services directly — data in via parameters, events out via callbacks
17. [ ] Composition: higher-level components reuse smaller shared components, never duplicate

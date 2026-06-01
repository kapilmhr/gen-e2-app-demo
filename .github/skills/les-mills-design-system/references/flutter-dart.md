# Les Mills — Flutter / Dart Reference

Apply these rules to every `.dart` file that contains UI code (widgets, screens, themes).

> Load [tokens.md](./tokens.md) alongside this file. Every value below traces back to a named token there.

The design system is implemented through three palette/definition files plus a single theme:

- `lib/theme/app_colors.dart` — `AppColors` constants (define the palette; used only to assemble `ThemeData`)
- `lib/theme/app_text_styles.dart` — `AppTextStyles` constants (the type scale)
- `lib/theme/app_spacing.dart` — `AppSpacing` constants (the spacing scale)
- `lib/theme/app_theme.dart` — `AppTheme.light` assembles `ThemeData` from the above

In widget code, **read colours and text styles from `Theme.of(context)`**, not from `AppColors`/`AppTextStyles` directly (except for the explicitly unmapped tokens listed below).

---

## Token Mapping — Colors

Every token maps to an `AppColors.[camelCase]` constant defined in `app_colors.dart`.
These constants exist to **define** the palette and assemble `ThemeData` — they are **not** the
access point inside widget trees.

**Theme-first rule (mandatory):** In any widget, colour access must go through
`Theme.of(context).colorScheme.*` whenever the token has a `ColorScheme` slot. Direct
`AppColors.*` references inside widget trees are forbidden for those tokens.

| Token | `AppColors` constant (definition / theme assembly) | `colorScheme.*` slot (widget use) |
|-------|----------------------------------------------------|-----------------------------------|
| `black` | `AppColors.black` | `colorScheme.primary` / `colorScheme.onSurface` |
| `white` | `AppColors.white` | `colorScheme.onPrimary` / `colorScheme.surface` |
| `off-white` | `AppColors.offWhite` | `colorScheme.surfaceContainerLowest` (app background → `Scaffold.backgroundColor`) |
| `secondary-blue` | `AppColors.secondaryBlue` | `colorScheme.secondary` |
| `dark-grey` | `AppColors.darkGrey` | `colorScheme.onSurfaceVariant` |
| `grey` | `AppColors.grey` | `colorScheme.outline` |
| `light-grey` | `AppColors.lightGrey` | `colorScheme.outlineVariant` |
| `error` | `AppColors.error` | `colorScheme.error` |
| `dark-orange` | `AppColors.darkOrange` | `colorScheme.tertiary` |
| `darkest-blue` | `AppColors.darkestBlue` | — (use `AppColors.darkestBlue` directly — accent/overlay) |
| `success` | `AppColors.success` | — (use `AppColors.success` directly — status, no ColorScheme slot) |
| `blue` | `AppColors.blue` | — (use directly — gradient/accent only) |
| `light-blue` | `AppColors.lightBlue` | — (use directly — gradient/accent only) |
| `lightest-blue` | `AppColors.lightestBlue` | — (use directly — gradient/accent only) |
| `light-orange` | `AppColors.lightOrange` | — (use directly — gradient/accent only) |
| `darkest-brown` | `AppColors.darkestBrown` | — (use directly — gradient/accent only) |
| `dark-brown` | `AppColors.darkBrown` | — (use directly — gradient/accent only) |
| `brown` | `AppColors.brown` | — (use directly — gradient/accent only) |
| `light-brown` | `AppColors.lightBrown` | — (use directly — gradient/accent only) |
| `lightest-brown` | `AppColors.lightestBrown` | — (use directly — gradient/accent only) |
| `light-beige` | `AppColors.lightBeige` | — (use directly — warm neutral surface) |
| `beige` | `AppColors.beige` | — (use directly — warm neutral surface) |
| `dark-beige` | `AppColors.darkBeige` | — (use directly — warm neutral border) |
| `neutral-light-blue` | `AppColors.neutralLightBlue` | — (use directly — tinted surface) |
| `neutral-blue` | `AppColors.neutralBlue` | — (use directly — tinted surface) |

### Forbidden / correct patterns

```dart
// ❌ Never — raw colour literal in a widget (or anywhere outside app_colors.dart)
Container(color: Color(0xFFF8F9F9));
Text('Hi', style: TextStyle(color: Color(0xFF000000)));

// ❌ Never — palette constant in widget code when a ColorScheme slot exists
Container(color: AppColors.offWhite);
Text('Hi', style: TextStyle(color: AppColors.black));

// ✅ Correct — theme API for mapped tokens
Text('Hi', style: TextStyle(color: Theme.of(context).colorScheme.onSurface));
final scheme = Theme.of(context).colorScheme;
Container(color: scheme.surface);

// ✅ Correct — palette constant ONLY for tokens with no ColorScheme slot (status / accent / gradient)
Icon(Icons.check_circle, color: AppColors.success);
const LinearGradient(colors: [AppColors.lightBlue, AppColors.darkOrange]); // sparing accent use
```

**`withOpacity()` / `withValues()` rule:** permitted only on status/accent tokens for light-fill
surfaces (e.g. `AppColors.success.withValues(alpha: 0.12)` for a success banner). Forbidden on
`black`, `white`, `off-white`, and the neutral border tokens — use the mapped solid token instead.

---

## Token Mapping — Spacing

Map every spacing value to an `AppSpacing.s[N]` constant in `app_spacing.dart`.

| Token | Flutter equivalent | Value |
|-------|--------------------|-------|
| `space-1` | `AppSpacing.s1` | `4` |
| `space-2` | `AppSpacing.s2` | `8` |
| `space-3` | `AppSpacing.s3` | `12` |
| `space-4` | `AppSpacing.s4` | `16` |
| `space-5` | `AppSpacing.s5` | `24` |
| `space-6` | `AppSpacing.s6` | `32` |
| `space-7` | `AppSpacing.s7` | `48` |
| `space-8` | `AppSpacing.s8` | `64` |

```dart
// ❌ Forbidden — arbitrary value
padding: const EdgeInsets.all(17),
SizedBox(height: 20),

// ✅ Correct
padding: const EdgeInsets.all(AppSpacing.s4),
SizedBox(height: AppSpacing.s5),
```

**BorderRadius snapping rule:** corner radii must snap to the nearest token value
(`AppSpacing.s2` = 8 for cards/inputs, `AppSpacing.s3` = 12 for large cards). Pill buttons use
`StadiumBorder()` rather than a raw radius. Never use an unlisted radius such as `BorderRadius.circular(10)`.

---

## Token Mapping — Typography

Map every text style to an `AppTextStyles.[name]` constant in `app_text_styles.dart`, and consume
through `Theme.of(context).textTheme.*` in widgets.

| Scale | `AppTextStyles` constant | `textTheme.*` slot |
|-------|--------------------------|--------------------|
| `display-large` | `AppTextStyles.displayLarge` | `textTheme.displayLarge` |
| `display-medium` | `AppTextStyles.displayMedium` | `textTheme.displayMedium` |
| `display-small` | `AppTextStyles.displaySmall` | `textTheme.displaySmall` |
| `headline-large` | `AppTextStyles.headlineLarge` | `textTheme.headlineLarge` |
| `headline-medium` | `AppTextStyles.headlineMedium` | `textTheme.headlineMedium` |
| `headline-small` | `AppTextStyles.headlineSmall` | `textTheme.headlineSmall` |
| `title-large` | `AppTextStyles.titleLarge` | `textTheme.titleLarge` |
| `title-medium` | `AppTextStyles.titleMedium` | `textTheme.titleMedium` |
| `title-small` | `AppTextStyles.titleSmall` | `textTheme.titleSmall` |
| `label-large` | `AppTextStyles.labelLarge` | `textTheme.labelLarge` |
| `label-medium` | `AppTextStyles.labelMedium` | `textTheme.labelMedium` |
| `label-small` | `AppTextStyles.labelSmall` | `textTheme.labelSmall` |
| `body-large` | `AppTextStyles.bodyLarge` | `textTheme.bodyLarge` |
| `body-medium` | `AppTextStyles.bodyMedium` | `textTheme.bodyMedium` |
| `body-small` | `AppTextStyles.bodySmall` | `textTheme.bodySmall` |

```dart
// ❌ Forbidden — raw TextStyle / inline font
Text('Title', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500));

// ✅ Correct — named scale via theme
Text('Title', style: Theme.of(context).textTheme.titleLarge);

// ✅ Correct — colour override only (never change size/weight/spacing/height)
Text(
  'Muted',
  style: Theme.of(context).textTheme.bodyMedium
      ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
);
```

Rule: `.copyWith(color:)` only. Never change `fontSize`, `fontWeight`, `letterSpacing`, or `height`
on a named style.

---

## Theme & System Integration

1. **How palette constants are defined** — `AppColors` in `lib/theme/app_colors.dart` holds every
   token as a `static const Color`. This is the **only** file allowed to contain `Color(0xFF…)` literals.
2. **How the theme is assembled** — `AppTheme.light` in `lib/theme/app_theme.dart` builds a single
   `ThemeData` (light, `useMaterial3: true`). It wires the `ColorScheme` from `AppColors`, sets
   `textTheme` from `AppTextStyles`, sets `scaffoldBackgroundColor: AppColors.offWhite`, and configures
   `AppBarTheme`, `CardTheme`, `ChipTheme`, `InputDecorationTheme`, `ElevatedButtonTheme`,
   `OutlinedButtonTheme`, `TextButtonTheme`, and `BottomNavigationBarTheme` once.
3. **How components consume colours** — widgets read from `Theme.of(context).colorScheme.*` and
   `Theme.of(context).textTheme.*`. Palette constants (`AppColors.*`) are used directly in widget code
   **only** for the tokens marked “use directly” above: `darkest-blue`, `success`, the Sunset gradient
   stops, the beiges, and the tinted neutral blues — none of which have a `ColorScheme` slot.

Buttons:
- **Primary action** → `ElevatedButton` / `OutlinedButton` themed with `black` (filled) on light;
  on dark/image backgrounds use the white-on-transparent variant. Configured in `AppTheme`, not inline.
- **Secondary action** → `TextButton` themed with `secondary-blue`.

Do not override `AppBar`, `Chip`, `Card`, `TextField`, or `BottomNavigationBar` colours/styles inline —
change them in `AppTheme`.

---

## Self-Audit Checklist

Before finalizing any Flutter UI file:

1. [ ] No `Color(0xFF…)` literals anywhere outside `app_colors.dart`
2. [ ] Theme-first: every token with a `colorScheme.*` slot is consumed via `Theme.of(context).colorScheme.*` in widgets — never via `AppColors.*`
3. [ ] `AppColors.*` used directly only for the “use directly” tokens (status, Sunset accents/gradients, beiges, tinted blues, `darkest-blue`)
4. [ ] No arbitrary spacing — all `EdgeInsets`/`SizedBox`/`gap` values use `AppSpacing.s[N]`
5. [ ] BorderRadius snaps to a token (`AppSpacing.s2`/`s3`) or uses `StadiumBorder` for pills — no unlisted radii
6. [ ] No raw `TextStyle(...)` construction — only `Theme.of(context).textTheme.*`, with `.copyWith(color:)` overrides only
7. [ ] No inline `AppBar`, `Chip`, `Card`, `TextField`, or `BottomNavigationBar` style overrides — all in `AppTheme`
8. [ ] Sunset/brown/beige colours appear only as accents or gradients, used sparingly — never as a primary surface or body-text colour
9. [ ] Muted/secondary text uses `onSurfaceVariant` (`dark-grey`), never `light-grey`
10. [ ] `withValues(alpha:)`/`withOpacity()` used only on status/accent tokens, never on `black`/`white`/`off-white`/neutral borders

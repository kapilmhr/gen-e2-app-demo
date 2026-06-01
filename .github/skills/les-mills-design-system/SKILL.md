---
name: les-mills-design-system
description: "Use when writing, reviewing, or auditing any UI code for the Les Mills Member App. Enforces the Les Mills Design System: colour tokens (Neutrals, Sunset accents, Status), the Untitled Sans typography scale, 4-based spacing tokens, light-theme surfaces, elevation, and component patterns. Load before creating any screen, widget, or theme. Use when: building screens, updating ThemeData, adding widgets, styling components, reviewing design token usage, auditing for off-palette colours, wrong spacing, or raw TextStyle construction in Flutter."
---

# Les Mills Design System Skill

This skill enforces the Les Mills Design System across all tech stacks used in this project.

## Procedure

Before writing **any** UI code:

1. Identify the tech stack for the file being created or edited.
2. Load the matching reference:
   - **Flutter / Dart** → [flutter-dart.md](./references/flutter-dart.md)
3. Load the universal token table → [tokens.md](./references/tokens.md)
4. Apply the rules from the reference exactly. Do not invent values.
5. After writing code, self-audit using the checklist in the relevant reference.

## Hard Rules (apply to all stacks)

- **Never invent a colour.** Every colour must map to a named token in [tokens.md](./references/tokens.md).
- **Never use arbitrary spacing.** Every spacing value must come from the 4-based token scale.
- **Never use arbitrary font sizes or weights.** Match the Untitled Sans type scale exactly; override colour only.
- **Theme first, palette as fallback.** Read colours through `Theme.of(context).colorScheme.*` and text through `Theme.of(context).textTheme.*`. Use raw `AppColors.*` constants only for tokens with no semantic slot (status colours, Sunset accents/gradients, beiges, tinted neutral blues, `darkest-blue`).
- **Light theme only.** The app canvas is `off-white` (`#F8F9F9`) with `white` cards. Never use a dark canvas on primary surfaces.
- **High-contrast primary actions.** Primary buttons use `black` on light backgrounds and `white` on dark/image backgrounds. Secondary actions are `secondary-blue` (`#4D90D7`) text buttons.
- **Sunset palette is accent-only.** Blues, oranges, browns, and beiges are for accents and gradients, used sparingly (e.g. timetable time-of-day gradients) — never as a primary surface or body-text colour.
- **Muted text is `dark-grey`** (`#505151`), never light grey. Borders use `grey` / `light-grey` depending on the background.

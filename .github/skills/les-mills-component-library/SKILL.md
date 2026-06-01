---
name: les-mills-component-library
description: "Use when building, refactoring, or reviewing any UI component in Les Mills. Enforces component structure, exhaustive state modeling, design tokens, accessibility, previews, models/stubs, and tests for Flutter / Dart. Load before creating any component, widget, screen, or view. Use when: creating components, adding previews, writing component tests, refactoring components, building screens, reviewing component quality."
---

# Les Mills Components Skill

Builds, reviews, and refactors UI components in Les Mills with the project's structure, tokens, accessibility, previews, and tests.

## When to Use

- Building a new component, widget, screen, or view
- Refactoring an existing component
- Adding previews or tests to a component
- Reviewing component quality against the project's standards
- Per-component construction during atomic-UI decomposition (invoked automatically by the `atomic-ui` skill)
- Any request to create or improve a UI component in this project

## Detected Project Context

| Aspect | Value |
|---|---|
| Stack | Flutter / Dart |
| Design-system skill | `les-mills-design-system` |
| Atomic-UI skill | always available (gen-e2-design plugin) |
| Component layers | shared → `lib/components/<name>/`; feature → `lib/feature/<feature_name>/` |
| Preview tool | Native Flutter Widget Previews (`@Preview`) |
| Default theme | Light (`AppTheme.light`) — the only shipped appearance |

Per-stack details (directories, file naming, test framework, preview tool) live in the stack reference file below.

## Stack References

Always load **[component-rules.md](./references/component-rules.md)** (universal principles) alongside this skill, then load the reference for the stack you are working in:

| File context signal | Reference |
|---|---|
| Any `.dart` file / `lib/` directory | [flutter.md](./references/flutter.md) |

**Tokens.** This project uses the [`les-mills-design-system`](../les-mills-design-system/SKILL.md) skill. For colour, type, spacing, elevation, and radius values, load that skill's `references/tokens.md` and `references/flutter-dart.md`. The component rules in this skill enforce that you reach for those tokens; the design-system skill provides the actual values. Light is the only shipped theme — never ship a dark canvas on primary surfaces.

## Atomic-UI Integration

This skill is invoked per-component by the `atomic-ui` skill during screen decomposition. Build atoms first, compose up to molecules and organisms. **Chaining.** The `atomic-ui` skill calls this skill per-component during bottom-up screen decomposition (Atom → Molecule → Organism → Template → Page).

## Procedure

1. **Understand the component.** Confirm purpose (one-sentence verb), atomic level (Atom / Molecule / Organism / Template / Page), the layer (shared `lib/components/` vs feature `lib/feature/<feature>/`), composition children, and the data model it operates on. Load [component-rules.md](./references/component-rules.md) for the full structural rules.

2. **Design the API surface.** Define parameters, callbacks, slots, and composition. Apply this project's snake_case naming and file conventions (see [flutter.md](./references/flutter.md)). See `## 3. Single Responsibility & API Surface` in component-rules.md.

3. **Model the state exhaustively.** Use a Dart `sealed class`. Cover Idle / Loading / Loaded / Error / Empty for data-driven components; pure-display Atoms skip this with a one-line note. See `## 4. Exhaustive State Modeling`.

4. **Create the data model and stubs.** Immutable `@immutable` model + Loaded, Empty, Error, Loading, Long-content, and List stubs. Realistic data only — no `test123` or Lorem ipsum, no `Random`/`DateTime.now()`. See `## 8. Data Models & Stubs`.

5. **Wire design tokens.** Tokens come from the `les-mills-design-system` skill and `lib/theme/*` — read colours via `Theme.of(context).colorScheme.*`, text via `textTheme.*`, spacing via `AppSpacing.*`. Never hardcode colours, spacing, typography, elevation, radius, or motion. See `## 5. Design Tokens`.

6. **Apply accessibility rules.** Roles, labels, touch targets, contrast, motion, focus, screen reader, text-scaling, RTL. Mandatory for every component. See `## 7. Accessibility (Mandatory)` and load the `accessibility` skill.

7. **Build the component, previews, and tests.** Previews (`@Preview`) cover all states + dark mode + 2× text + RTL + narrow width, reusing shared stubs. Tests cover render, state, a11y (`meetsGuideline`), and interactions, using the same stubs. **Every component and view ships with previews and stubs — no exceptions.**

8. **Run the self-audit checklist** at the end of component-rules.md before reporting done.

## Hard Rules

- **Never hardcode appearance values.** All colours, spacing, type, elevation, radius, and motion come from semantic tokens / `lib/theme/*`.
- **Never hardcode user-visible strings.** No i18n library detected — centralise any string constants in a dedicated file rather than scattering literals across components.
- **Always model state exhaustively.** Compiler-checked `sealed class` + exhaustive `switch`. No invalid states possible.
- **Accessibility is mandatory, not optional.** Roles, labels, targets, contrast, motion, focus — from day one.
- **Component layer stays library-agnostic.** Data in via parameters, events out via callbacks. Never reach into global state or services.
- **Use this project's conventions** for directory, naming, file structure, and tooling — as detected and listed above.
- **Previews use shared stubs.** Never inline test data in previews or tests.
- **Light is the only shipped theme.** Dark-mode previews exist only to catch contrast/hardcoded-colour regressions.
- **Test by semantics first.** Query by label / text; keys are an escape hatch.

## Related Skills

Load these alongside this skill for complete quality coverage:

| Skill | When to load |
|---|---|
| `accessibility` | Always — mandatory for every component; provides platform-specific WCAG 2.2, Apple HIG, Material rules |
| `visual-quality` | During design review; when auditing layout, hierarchy, spacing, or contrast |
| `motion-interactions` | When adding any animation, transition, gesture, or press-state feedback |
| `content-design` | When authoring or reviewing any visible copy, labels, errors, or empty states |
| `atomic-ui` | When decomposing a screen into atomic components (invokes this skill automatically per component) |
| `les-mills-design-system` | Always — provides the actual token values this skill enforces |

<!-- Generated by create-component-library-skill v1.0 on 2026-06-01. Stack: Flutter. Design-system: les-mills-design-system. Atomic-UI: gen-e2-design plugin. -->

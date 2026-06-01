# Les Mills Member App (Demo)

A Flutter demo of the Les Mills Member App, built with a token-driven design system and an atomic component library. This repository pairs the Flutter implementation with Gen-e2™ product discovery artefacts (flows and stories) that drive each feature.

## Repository structure

```
.
├── apps/
│   └── lesmills_flutter/     # Flutter application
│       ├── lib/
│       │   ├── components/   # Reusable UI components (atoms → organisms)
│       │   ├── feature/      # Feature screens (home, explore, timetable, …)
│       │   ├── l10n/         # Localisation
│       │   ├── theme/        # Design tokens & ThemeData
│       │   └── main.dart     # App entry point
│       └── test/             # Widget & component tests
├── docs/                     # Gen-e2™ planning artefacts (flows & stories)
└── .github/                  # Copilot instructions & skills
```

## Features

- **Home** — personalised landing experience
- **Explore** — browse classes and content
- **Timetable** — class schedule
- **Progress** — track workouts and milestones
- **Profile** — member account and settings
- **Shell / Splash** — app navigation scaffold and launch screen

## Design system

The app uses a centralised, token-first design system under [apps/lesmills_flutter/lib/theme](apps/lesmills_flutter/lib/theme):

- `app_colors.dart` — colour tokens
- `app_spacing.dart` — 4-based spacing scale
- `app_text_styles.dart` — typography scale
- `app_theme.dart` — assembled `ThemeData`

Components live in [apps/lesmills_flutter/lib/components](apps/lesmills_flutter/lib/components) and follow an atomic structure (`pill_button`, `class_card`, `content_card`, `app_bottom_nav_bar`, …).

## Planning artefacts

Product discovery artefacts are kept in [docs/](docs) per feature, using the Gen-e2™ format:

- `*.gen-e2.flow` — user flows
- `*.gen-e2.story.md` — user stories with acceptance criteria

## Getting started

Prerequisites: [Flutter](https://docs.flutter.dev/get-started/install) with Dart SDK `^3.12.0`.

```bash
cd apps/lesmills_flutter

# Install dependencies
flutter pub get

# Run the app
flutter run

# Run static analysis
flutter analyze

# Run tests
flutter test
```

## Project conventions

- Load the `les-mills-design-system` skill before writing any UI code.
- Load the `les-mills-component-library` skill before creating, refactoring, or reviewing components.
- Use design tokens exclusively — no hardcoded colours, spacing, or text styles.

See [.github/copilot-instructions.md](.github/copilot-instructions.md) for the full tooling and workflow conventions.

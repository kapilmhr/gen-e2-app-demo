# Les Mills — Universal Token Reference

All design tokens used across every tech stack in this project.
**Every implementation must map to one of these tokens. No exceptions.**

Source: Les Mills — Member App Demo (Figma). The palette is organised into three
groups: **Neutrals** (surfaces, text, borders), **Sunset** (accents & gradients,
used sparingly), and **Status** (error/success feedback).

---

## Color Tokens

<!-- Neutrals — surfaces, text, borders -->

| Token name | Value | Role |
|------------|-------|------|
| `white` | `#FFFFFF` | Card / sheet surface; primary text on dark or image backgrounds |
| `black` | `#000000` | Primary text on light; primary (filled/outlined) button colour |
| `off-white` | `#F8F9F9` | Primary app background (main screens) |
| `dark-grey` | `#505151` | Less-emphasised / secondary text |
| `grey` | `#DEDEDE` | Borders & dividers on light/white backgrounds |
| `light-grey` | `#E7E6EC` | Borders & dividers on off-white / grey backgrounds |
| `neutral-light-blue` | `#F5F9FE` | Subtle tinted surface / informational background |
| `neutral-blue` | `#E8F3FA` | Subtle tinted surface / informational background |
| `light-beige` | `#F3F0E6` | Warm neutral surface (accent backgrounds) |
| `beige` | `#EBE5D5` | Warm neutral surface (accent backgrounds) |
| `dark-beige` | `#D1C9B8` | Warm neutral border / divider |

<!-- Sunset — accents & gradients ONLY, used sparingly -->

| Token name | Value | Role |
|------------|-------|------|
| `darkest-blue` | `#002B4D` | Dark accent surface / hero overlay |
| `secondary-blue` | `#4D90D7` | Secondary action (text buttons), links |
| `blue` | `#8EB4CB` | Accent / gradient stop |
| `light-blue` | `#9ECCEE` | Accent / gradient stop |
| `lightest-blue` | `#BED0DA` | Accent / gradient stop |
| `dark-orange` | `#FF804A` | Accent / gradient stop |
| `light-orange` | `#FCA53B` | Accent / gradient stop |
| `darkest-brown` | `#4E3834` | Accent / gradient stop |
| `dark-brown` | `#A9542F` | Accent / gradient stop |
| `brown` | `#D0A47D` | Accent / gradient stop |
| `light-brown` | `#F1D39F` | Accent / gradient stop |
| `lightest-brown` | `#F4EAD0` | Accent / gradient stop |

<!-- Status — feedback -->

| Token name | Value | Role |
|------------|-------|------|
| `error` | `#FC4F60` | Error state / destructive feedback |
| `success` | `#6BC163` | Success / positive confirmation |

These 25 values are the complete palette. Do not use any other color value.

**Semantic notes (from the Colour Usage spec):**
- Main/primary elements use **black** (high contrast) on light, **white** on dark/image backgrounds.
- Secondary actions (text buttons) use **secondary-blue** (`#4D90D7`).
- Most text is **black**; less-emphasised text is **dark-grey** (`#505151`).
- App background is **off-white** (`#F8F9F9`); cards/sheets are **white** (`#FFFFFF`) to create elevation.
- Borders are **grey** (`#DEDEDE`) or **light-grey** (`#E7E6EC`) depending on the background.
- Sunset (blues/oranges/browns) + beiges are **accent & gradient** colours only — used sparingly (e.g. timetable time-of-day gradients).

---

## Spacing Tokens

4-based scale. *(Synthesized — the source does not define an explicit spacing scale;
values inferred from component padding in the Figma frames.)*

| Token | Value |
|-------|-------|
| `space-1` | `4px` |
| `space-2` | `8px` |
| `space-3` | `12px` |
| `space-4` | `16px` |
| `space-5` | `24px` |
| `space-6` | `32px` |
| `space-7` | `48px` |
| `space-8` | `64px` |

Do not use spacing values outside this scale.

---

## Typography Scale

Font family: **Untitled Sans** (Material-3 style scale). Regular = 400, Medium = 500.

| Element | Size | Weight | Line-height | Letter-spacing |
|---------|------|--------|-------------|----------------|
| `display-large` | 57px | 500 | 64px | 2 |
| `display-medium` | 45px | 500 | 52px | 2 |
| `display-small` | 36px | 500 | 44px | 1 |
| `headline-large` | 32px | 400 | 40px | 1 |
| `headline-medium` | 28px | 400 | 36px | 0.5 |
| `headline-small` | 24px | 400 | 32px | 0.5 |
| `title-large` | 22px | 500 | 28px | 0.5 |
| `title-medium` | 16px | 400 | 24px | 0.5 |
| `title-small` | 14px | 400 | 20px | 0.5 |
| `label-large` | 16px | 500 | 24px | 0.5 |
| `label-medium` | 14px | 500 | 20px | 0.25 |
| `label-small` | 12px | 500 | 16px | 0.4 |
| `body-large` | 16px | 400 | 24px | 0 |
| `body-medium` | 14px | 400 | 20px | 0 |
| `body-small` | 12px | 400 | 16px | 0 |

Do not interpolate intermediate sizes.

---

## Elevation

Low-drama elevation. Cards sit on the off-white canvas using a single soft shadow;
bottom sheets rely on the white surface against off-white for separation.

| Level | Value |
|-------|-------|
| `flat` | `none` (surface tone difference only — white card on off-white canvas) |
| `card` | `0 1px 3px rgba(0, 0, 0, 0.08)` |
| `sheet` | `0 -2px 12px rgba(0, 0, 0, 0.10)` |

Do not introduce additional shadow levels or heavier shadows.

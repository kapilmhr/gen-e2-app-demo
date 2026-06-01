import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'app_theme.dart';

/// Shared configuration for all `@Preview`-annotated functions.
///
/// Centralising these values keeps every preview rendering at the same
/// canvas size and theme. Previews should pass [phoneSize] to `size:` and
/// [previewTheme] to `theme:` instead of wrapping their widget in a
/// [MaterialApp] — a nested [MaterialApp] installs its own [MediaQuery] from
/// the real view and ignores the previewer's `size` constraint.

/// Standard mobile preview canvas (iPhone 13/14 logical size).
const Size phoneSize = Size(390, 844);

/// Supplies the Les Mills theme to the previewer for both brightnesses.
///
/// Referenced as a tear-off: `@Preview(theme: previewTheme)`.
PreviewThemeData previewTheme() =>
    PreviewThemeData(materialLight: AppTheme.light, materialDark: AppTheme.light);

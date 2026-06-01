import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../theme/app_theme.dart';
import 'explore_screen.dart';
import 'explore_stubs.dart';

@Preview(name: 'Loaded')
Widget exploreLoaded() =>
    _wrap(const ExploreScreen(initialState: ExploreStubs.loadedState));

@Preview(name: 'Loading')
Widget exploreLoading() =>
    _wrap(const ExploreScreen(initialState: ExploreStubs.loadingState));

@Preview(name: 'Empty')
Widget exploreEmpty() =>
    _wrap(const ExploreScreen(initialState: ExploreStubs.emptyState));

@Preview(name: 'Error')
Widget exploreError() => _wrap(
      ExploreScreen(initialState: ExploreStubs.errorState, onRetry: () {}),
    );

@Preview(name: 'Degraded (one carousel failed)')
Widget exploreDegraded() =>
    _wrap(const ExploreScreen(initialState: ExploreStubs.degradedState));

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget exploreDark() =>
    _wrap(const ExploreScreen(initialState: ExploreStubs.loadedState));

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget exploreLargeText() =>
    _wrap(const ExploreScreen(initialState: ExploreStubs.loadedState));

@Preview(name: 'RTL')
Widget exploreRtl() => _wrap(
      const Directionality(
        textDirection: TextDirection.rtl,
        child: ExploreScreen(initialState: ExploreStubs.loadedState),
      ),
    );

@Preview(name: 'Narrow width')
Widget exploreNarrow() => _wrap(
      const SizedBox(
        width: 320,
        child: ExploreScreen(initialState: ExploreStubs.loadedState),
      ),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: child,
    );

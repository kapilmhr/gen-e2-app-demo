import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../theme/app_theme.dart';
import 'home_screen.dart';
import 'home_stubs.dart';

@Preview(name: 'Loaded')
Widget homeLoaded() =>
    _wrap(const HomeScreen(initialState: HomeStubs.loadedState));

@Preview(name: 'Loading')
Widget homeLoading() =>
    _wrap(const HomeScreen(initialState: HomeStubs.loadingState));

@Preview(name: 'Empty')
Widget homeEmpty() =>
    _wrap(const HomeScreen(initialState: HomeStubs.emptyState));

@Preview(name: 'Error')
Widget homeError() => _wrap(
      HomeScreen(initialState: HomeStubs.errorState, onRetry: () {}),
    );

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget homeDark() =>
    _wrap(const HomeScreen(initialState: HomeStubs.loadedState));

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget homeLargeText() =>
    _wrap(const HomeScreen(initialState: HomeStubs.loadedState));

@Preview(name: 'RTL')
Widget homeRtl() => _wrap(
      const Directionality(
        textDirection: TextDirection.rtl,
        child: HomeScreen(initialState: HomeStubs.loadedState),
      ),
    );

@Preview(name: 'Narrow width')
Widget homeNarrow() => _wrap(
      const SizedBox(
        width: 320,
        child: HomeScreen(initialState: HomeStubs.loadedState),
      ),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: child,
    );

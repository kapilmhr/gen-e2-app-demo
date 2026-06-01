import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../theme/app_theme.dart';
import 'progress_screen.dart';
import 'progress_stubs.dart';

@Preview(name: 'Loaded')
Widget progressLoaded() =>
    _wrap(const ProgressScreen(initialState: ProgressStubs.loadedState));

@Preview(name: 'Loading')
Widget progressLoading() =>
    _wrap(const ProgressScreen(initialState: ProgressStubs.loadingState));

@Preview(name: 'Empty')
Widget progressEmpty() =>
    _wrap(const ProgressScreen(initialState: ProgressStubs.emptyState));

@Preview(name: 'Error')
Widget progressError() => _wrap(
      ProgressScreen(initialState: ProgressStubs.errorState, onRetry: () {}),
    );

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget progressDark() =>
    _wrap(const ProgressScreen(initialState: ProgressStubs.loadedState));

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget progressLargeText() =>
    _wrap(const ProgressScreen(initialState: ProgressStubs.loadedState));

@Preview(name: 'RTL')
Widget progressRtl() => _wrap(
      const Directionality(
        textDirection: TextDirection.rtl,
        child: ProgressScreen(initialState: ProgressStubs.loadedState),
      ),
    );

@Preview(name: 'Narrow width')
Widget progressNarrow() => _wrap(
      const SizedBox(
        width: 320,
        child: ProgressScreen(initialState: ProgressStubs.loadedState),
      ),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: child,
    );

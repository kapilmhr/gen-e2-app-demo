import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../theme/app_theme.dart';
import 'timetable_screen.dart';
import 'timetable_stubs.dart';

@Preview(name: 'Loaded')
Widget timetableLoaded() =>
    _wrap(const TimetableScreen(initialState: TimetableStubs.loadedState));

@Preview(name: 'Loading')
Widget timetableLoading() =>
    _wrap(const TimetableScreen(initialState: TimetableStubs.loadingState));

@Preview(name: 'Empty')
Widget timetableEmpty() =>
    _wrap(const TimetableScreen(initialState: TimetableStubs.emptyState));

@Preview(name: 'Error')
Widget timetableError() => _wrap(
      TimetableScreen(initialState: TimetableStubs.errorState, onRetry: () {}),
    );

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget timetableDark() =>
    _wrap(const TimetableScreen(initialState: TimetableStubs.loadedState));

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget timetableLargeText() =>
    _wrap(const TimetableScreen(initialState: TimetableStubs.loadedState));

@Preview(name: 'RTL')
Widget timetableRtl() => _wrap(
      const Directionality(
        textDirection: TextDirection.rtl,
        child: TimetableScreen(initialState: TimetableStubs.loadedState),
      ),
    );

@Preview(name: 'Narrow width')
Widget timetableNarrow() => _wrap(
      const SizedBox(
        width: 320,
        child: TimetableScreen(initialState: TimetableStubs.loadedState),
      ),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: child,
    );

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../theme/app_theme.dart';
import 'profile_screen.dart';
import 'profile_stubs.dart';

@Preview(name: 'Loaded')
Widget profileLoaded() =>
    _wrap(const ProfileScreen(initialState: ProfileStubs.loadedState));

@Preview(name: 'Loading')
Widget profileLoading() =>
    _wrap(const ProfileScreen(initialState: ProfileStubs.loadingState));

@Preview(name: 'Empty')
Widget profileEmpty() =>
    _wrap(const ProfileScreen(initialState: ProfileStubs.emptyState));

@Preview(name: 'Error')
Widget profileError() => _wrap(
      ProfileScreen(initialState: ProfileStubs.errorState, onRetry: () {}),
    );

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget profileDark() =>
    _wrap(const ProfileScreen(initialState: ProfileStubs.loadedState));

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget profileLargeText() =>
    _wrap(const ProfileScreen(initialState: ProfileStubs.loadedState));

@Preview(name: 'RTL')
Widget profileRtl() => _wrap(
      const Directionality(
        textDirection: TextDirection.rtl,
        child: ProfileScreen(initialState: ProfileStubs.loadedState),
      ),
    );

@Preview(name: 'Narrow width')
Widget profileNarrow() => _wrap(
      const SizedBox(
        width: 320,
        child: ProfileScreen(initialState: ProfileStubs.loadedState),
      ),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: child,
    );

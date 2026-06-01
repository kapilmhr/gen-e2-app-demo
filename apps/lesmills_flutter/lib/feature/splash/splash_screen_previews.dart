import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../theme/app_theme.dart';
import 'splash_screen.dart';
import 'splash_stubs.dart';

@Preview(name: 'Initialising')
Widget splashInitialising() =>
    _wrap(const SplashScreen(state: SplashStubs.initialisingState));

@Preview(name: 'Ready')
Widget splashReady() =>
    _wrap(const SplashScreen(state: SplashStubs.readyState));

@Preview(name: 'Error')
Widget splashError() => _wrap(
      SplashScreen(state: SplashStubs.errorState, onRetry: () {}),
    );

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget splashLargeText() => _wrap(
      SplashScreen(state: SplashStubs.errorState, onRetry: () {}),
    );

@Preview(name: 'RTL')
Widget splashRtl() => _wrap(
      const Directionality(
        textDirection: TextDirection.rtl,
        child: SplashScreen(state: SplashStubs.errorState),
      ),
    );

@Preview(name: 'Narrow width')
Widget splashNarrow() => _wrap(
      const SizedBox(
        width: 320,
        child: SplashScreen(state: SplashStubs.initialisingState),
      ),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: child,
    );

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lesmills_flutter/feature/splash/splash_screen.dart';
import 'package:lesmills_flutter/feature/splash/splash_stubs.dart';
import 'package:lesmills_flutter/theme/app_theme.dart';

Widget _host(Widget child) => MaterialApp(theme: AppTheme.light, home: child);

void main() {
  group('SplashScreen', () {
    testWidgets('shows the brand wordmark while initialising', (tester) async {
      await tester.pumpWidget(
        _host(const SplashScreen(state: SplashStubs.initialisingState)),
      );

      expect(find.text('LES MILLS'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('error state shows a retry action that fires', (tester) async {
      var retries = 0;
      await tester.pumpWidget(
        _host(SplashScreen(
          state: SplashStubs.errorState,
          onRetry: () => retries++,
        )),
      );

      expect(find.text('We couldn’t start the app'), findsOneWidget);
      await tester.tap(find.text('TRY AGAIN'));
      expect(retries, 1);
    });
  });
}

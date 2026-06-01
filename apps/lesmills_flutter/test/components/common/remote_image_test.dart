import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lesmills_flutter/components/common/remote_image.dart';
import 'package:lesmills_flutter/theme/app_theme.dart';

Widget _host(Widget child) => MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(body: Center(child: SizedBox.square(dimension: 100, child: child))),
    );

void main() {
  group('RemoteImage', () {
    testWidgets('renders a decorative placeholder when no source is given',
        (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(_host(const RemoteImage()));

      // A neutral placeholder is shown (no Image widget when there is no source).
      expect(find.byType(Image), findsNothing);
      expect(
        find.descendant(
          of: find.byType(RemoteImage),
          matching: find.byType(ColoredBox),
        ),
        findsOneWidget,
      );

      // The placeholder is decorative — it exposes no semantics node.
      expect(
        find.descendant(
          of: find.byType(RemoteImage),
          matching: find.byType(ExcludeSemantics),
        ),
        findsOneWidget,
      );
      handle.dispose();
    });

    testWidgets('prefers an asset over a remote url', (tester) async {
      await tester.pumpWidget(
        _host(const RemoteImage(assetPath: 'assets/images/x.png', url: 'https://e/x')),
      );

      final image = tester.widget<Image>(find.byType(Image));
      expect(image.image, isA<AssetImage>());
    });
  });
}

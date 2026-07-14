import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:patrol/patrol.dart';

import 'package:lesmills_flutter/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  patrolTest(
    'AI persona session',
    config: const PatrolTesterConfig(settleTimeout: Duration(seconds: 10)),
    ($) async {
      app.main();
      await $.pumpAndSettle();
    },
  );
}

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../theme/app_spacing.dart';
import '../../../theme/app_theme.dart';
import '../progress_model.dart';
import '../progress_stubs.dart';
import 'next_to_unlock_card.dart';

@Preview(name: 'Default')
Widget nextToUnlockDefault() =>
    _wrap(const NextToUnlockCard(badge: ProgressStubs.nextToUnlock));

@Preview(name: 'Almost complete')
Widget nextToUnlockAlmost() => _wrap(
      const NextToUnlockCard(
        badge: NextBadge(
          label: 'Centurion',
          emblem: 'CENTURION',
          current: 98,
          total: 100,
        ),
      ),
    );

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget nextToUnlockDark() =>
    _wrap(const NextToUnlockCard(badge: ProgressStubs.nextToUnlock));

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget nextToUnlockLargeText() =>
    _wrap(const NextToUnlockCard(badge: ProgressStubs.nextToUnlock));

@Preview(name: 'RTL')
Widget nextToUnlockRtl() => _wrap(
      const Directionality(
        textDirection: TextDirection.rtl,
        child: NextToUnlockCard(badge: ProgressStubs.nextToUnlock),
      ),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.s5),
          child: child,
        ),
      ),
    );

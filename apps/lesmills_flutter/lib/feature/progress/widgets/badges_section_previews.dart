import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../theme/app_theme.dart';
import '../progress_stubs.dart';
import 'badges_section.dart';

@Preview(name: 'Default')
Widget badgesSectionDefault() => _wrap(
      BadgesSection(
        badges: ProgressStubs.badges,
        nextToUnlock: ProgressStubs.nextToUnlock,
        onViewAll: () {},
        onBadgeTap: (_) {},
      ),
    );

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget badgesSectionDark() => _wrap(
      BadgesSection(
        badges: ProgressStubs.badges,
        nextToUnlock: ProgressStubs.nextToUnlock,
      ),
    );

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget badgesSectionLargeText() => _wrap(
      BadgesSection(
        badges: ProgressStubs.badges,
        nextToUnlock: ProgressStubs.nextToUnlock,
      ),
    );

@Preview(name: 'RTL')
Widget badgesSectionRtl() => _wrap(
      Directionality(
        textDirection: TextDirection.rtl,
        child: BadgesSection(
          badges: ProgressStubs.badges,
          nextToUnlock: ProgressStubs.nextToUnlock,
        ),
      ),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: child,
        ),
      ),
    );

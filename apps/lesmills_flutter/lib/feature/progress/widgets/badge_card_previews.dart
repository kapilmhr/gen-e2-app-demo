import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../theme/app_spacing.dart';
import '../../../theme/app_theme.dart';
import '../progress_stubs.dart';
import 'badge_card.dart';

@Preview(name: 'Default')
Widget badgeCardDefault() =>
    _wrap(BadgeCard(model: ProgressStubs.badges.first, onTap: () {}));

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget badgeCardDark() => _wrap(BadgeCard(model: ProgressStubs.badges[1]));

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget badgeCardLargeText() => _wrap(BadgeCard(model: ProgressStubs.badges[2]));

@Preview(name: 'RTL')
Widget badgeCardRtl() => _wrap(
      Directionality(
        textDirection: TextDirection.rtl,
        child: BadgeCard(model: ProgressStubs.badges[3]),
      ),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.s5),
            child: child,
          ),
        ),
      ),
    );

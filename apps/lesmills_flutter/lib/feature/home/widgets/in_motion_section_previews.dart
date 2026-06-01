import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../theme/app_spacing.dart';
import '../../../theme/app_theme.dart';
import '../home_stubs.dart';
import 'in_motion_section.dart';

@Preview(name: 'Default')
Widget inMotionDefault() => _wrap(
      InMotionSection(
        items: HomeStubs.loaded.inMotion,
        onCardTap: (_) {},
      ),
    );

@Preview(name: 'Single item')
Widget inMotionSingle() => _wrap(
      InMotionSection(
        items: HomeStubs.loaded.inMotion.take(1).toList(),
        onCardTap: (_) {},
      ),
    );

@Preview(name: 'Empty')
Widget inMotionEmpty() => _wrap(
      const InMotionSection(items: []),
    );

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget inMotionDark() => _wrap(
      InMotionSection(
        items: HomeStubs.loaded.inMotion,
        onCardTap: (_) {},
      ),
    );

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget inMotionLargeText() => _wrap(
      InMotionSection(
        items: HomeStubs.loaded.inMotion,
        onCardTap: (_) {},
      ),
    );

@Preview(name: 'RTL')
Widget inMotionRtl() => _wrap(
      Directionality(
        textDirection: TextDirection.rtl,
        child: InMotionSection(
          items: HomeStubs.loaded.inMotion,
          onCardTap: (_) {},
        ),
      ),
    );

@Preview(name: 'Narrow width')
Widget inMotionNarrow() => _wrap(
      SizedBox(
        width: 320,
        child: InMotionSection(
          items: HomeStubs.loaded.inMotion,
          onCardTap: (_) {},
        ),
      ),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(
        body: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.s5),
            child: child,
          ),
        ),
      ),
    );

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../theme/app_theme.dart';
import 'page_header.dart';

@Preview(name: 'Default')
Widget pageHeaderDefault() => _wrap(const PageHeader(title: 'Progress'));

@Preview(name: 'Long title')
Widget pageHeaderLongTitle() =>
    _wrap(const PageHeader(title: 'Group Fitness Timetable'));

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget pageHeaderDark() => _wrap(const PageHeader(title: 'Progress'));

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget pageHeaderLargeText() => _wrap(const PageHeader(title: 'Progress'));

@Preview(name: 'RTL')
Widget pageHeaderRtl() => _wrap(
      const Directionality(
        textDirection: TextDirection.rtl,
        child: PageHeader(title: 'Explore'),
      ),
    );

@Preview(name: 'Narrow width')
Widget pageHeaderNarrow() => _wrap(
      const SizedBox(width: 320, child: PageHeader(title: 'Profile')),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(body: child),
    );

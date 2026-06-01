import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../theme/app_theme.dart';
import 'section_header.dart';

@Preview(name: 'Title only')
Widget sectionHeaderTitle() => _wrap(const SectionHeader(title: 'In Motion'));

@Preview(name: 'With description')
Widget sectionHeaderDescription() => _wrap(
      const SectionHeader(
        title: 'Activity summary',
        description: 'Just 1 more workout until you hit your goal this week!',
      ),
    );

@Preview(name: 'Long content')
Widget sectionHeaderLongContent() => _wrap(
      const SectionHeader(
        title: 'Explore Group Fitness',
        description:
            'Whether you’re new or experienced with working out, Group '
            'Fitness workouts deliver a results-focused fitness experience.',
      ),
    );

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget sectionHeaderDark() => _wrap(
      const SectionHeader(
        title: 'In Motion',
        description: 'What’s new at your club',
      ),
    );

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget sectionHeaderLargeText() => _wrap(
      const SectionHeader(
        title: 'Activity summary',
        description: 'Just 1 more workout until you hit your goal this week!',
      ),
    );

@Preview(name: 'RTL')
Widget sectionHeaderRtl() => _wrap(
      const Directionality(
        textDirection: TextDirection.rtl,
        child: SectionHeader(
          title: 'In Motion',
          description: 'What’s new at your club',
        ),
      ),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Align(alignment: Alignment.topLeft, child: child),
        ),
      ),
    );

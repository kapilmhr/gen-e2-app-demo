import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../theme/app_spacing.dart';
import '../../../theme/app_theme.dart';
import '../home_stubs.dart';
import 'group_fitness_section.dart';

@Preview(name: 'Default')
Widget groupFitnessDefault() => _wrap(
      GroupFitnessSection(
        description: HomeStubs.loaded.groupFitnessDescription,
        classes: HomeStubs.loaded.classes,
        onClassTap: (_) {},
        onTimetable: () {},
      ),
    );

@Preview(name: 'Single class')
Widget groupFitnessSingle() => _wrap(
      GroupFitnessSection(
        description: HomeStubs.loaded.groupFitnessDescription,
        classes: HomeStubs.loaded.classes.take(1).toList(),
        onClassTap: (_) {},
        onTimetable: () {},
      ),
    );

@Preview(name: 'Empty')
Widget groupFitnessEmpty() => _wrap(
      GroupFitnessSection(
        description: HomeStubs.loaded.groupFitnessDescription,
        classes: const [],
        onTimetable: () {},
      ),
    );

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget groupFitnessDark() => _wrap(
      GroupFitnessSection(
        description: HomeStubs.loaded.groupFitnessDescription,
        classes: HomeStubs.loaded.classes,
        onClassTap: (_) {},
        onTimetable: () {},
      ),
    );

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget groupFitnessLargeText() => _wrap(
      GroupFitnessSection(
        description: HomeStubs.loaded.groupFitnessDescription,
        classes: HomeStubs.loaded.classes,
        onClassTap: (_) {},
        onTimetable: () {},
      ),
    );

@Preview(name: 'RTL')
Widget groupFitnessRtl() => _wrap(
      Directionality(
        textDirection: TextDirection.rtl,
        child: GroupFitnessSection(
          description: HomeStubs.loaded.groupFitnessDescription,
          classes: HomeStubs.loaded.classes,
          onClassTap: (_) {},
          onTimetable: () {},
        ),
      ),
    );

@Preview(name: 'Narrow width')
Widget groupFitnessNarrow() => _wrap(
      SizedBox(
        width: 320,
        child: GroupFitnessSection(
          description: HomeStubs.loaded.groupFitnessDescription,
          classes: HomeStubs.loaded.classes,
          onClassTap: (_) {},
          onTimetable: () {},
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

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../theme/app_spacing.dart';
import '../../../theme/app_theme.dart';
import '../explore_stubs.dart';
import 'explore_group_fitness_section.dart';

final _classes = ExploreStubs.loaded.groupFitnessClasses;

@Preview(name: 'Default')
Widget groupFitnessDefault() =>
    _wrap(ExploreGroupFitnessSection(classes: _classes));

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget groupFitnessDark() =>
    _wrap(ExploreGroupFitnessSection(classes: _classes));

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget groupFitnessLargeText() =>
    _wrap(ExploreGroupFitnessSection(classes: _classes));

@Preview(name: 'RTL')
Widget groupFitnessRtl() => _wrap(
      Directionality(
        textDirection: TextDirection.rtl,
        child: ExploreGroupFitnessSection(classes: _classes),
      ),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.s5),
          child: Align(alignment: Alignment.topCenter, child: child),
        ),
      ),
    );

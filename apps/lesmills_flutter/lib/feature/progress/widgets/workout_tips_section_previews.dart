import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../theme/app_theme.dart';
import '../progress_stubs.dart';
import 'workout_tips_section.dart';

@Preview(name: 'Default')
Widget workoutTipsDefault() =>
    _wrap(WorkoutTipsSection(tips: ProgressStubs.tips, onTipTap: (_) {}));

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget workoutTipsDark() => _wrap(WorkoutTipsSection(tips: ProgressStubs.tips));

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget workoutTipsLargeText() =>
    _wrap(WorkoutTipsSection(tips: ProgressStubs.tips));

@Preview(name: 'RTL')
Widget workoutTipsRtl() => _wrap(
      Directionality(
        textDirection: TextDirection.rtl,
        child: WorkoutTipsSection(tips: ProgressStubs.tips),
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

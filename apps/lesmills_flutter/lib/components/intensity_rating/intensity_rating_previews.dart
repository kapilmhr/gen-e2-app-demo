import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import 'intensity_rating.dart';

@Preview(name: 'High (4 of 5)')
Widget intensityHigh() => _wrap(const IntensityRating(level: 4));

@Preview(name: 'Max (5 of 5)')
Widget intensityMax() => _wrap(const IntensityRating(level: 5));

@Preview(name: 'Low (2 of 5)')
Widget intensityLow() => _wrap(const IntensityRating(level: 2));

@Preview(name: 'None (0 of 5)')
Widget intensityNone() => _wrap(const IntensityRating(level: 0));

@Preview(name: 'On dark image')
Widget intensityOnImage() => _wrap(
      ColoredBox(
        color: AppColors.darkestBlue,
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: IntensityRating(level: 4, color: AppColors.white),
        ),
      ),
    );

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget intensityDark() => _wrap(const IntensityRating(level: 3));

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget intensityLargeText() => _wrap(const IntensityRating(level: 3));

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(body: Center(child: child)),
    );

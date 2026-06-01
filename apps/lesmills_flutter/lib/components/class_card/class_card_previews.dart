import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../theme/app_theme.dart';
import 'class_card.dart';
import 'class_card_stubs.dart';

@Preview(name: 'High intensity')
Widget classCardHigh() =>
    _wrap(ClassCard(model: ClassCardStubs.loaded, onTap: () {}));

@Preview(name: 'Max intensity')
Widget classCardMax() =>
    _wrap(ClassCard(model: ClassCardStubs.maxIntensity, onTap: () {}));

@Preview(name: 'Low intensity')
Widget classCardLow() =>
    _wrap(ClassCard(model: ClassCardStubs.lowIntensity, onTap: () {}));

@Preview(name: 'Long content')
Widget classCardLongContent() =>
    _wrap(ClassCard(model: ClassCardStubs.longContent, onTap: () {}));

@Preview(name: 'List')
Widget classCardList() => _wrap(
      SizedBox(
        height: 300,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: ClassCardStubs.list.length,
          separatorBuilder: (_, _) => const SizedBox(width: 16),
          itemBuilder: (_, i) =>
              ClassCard(model: ClassCardStubs.list[i], onTap: () {}),
        ),
      ),
    );

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget classCardDark() =>
    _wrap(ClassCard(model: ClassCardStubs.loaded, onTap: () {}));

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget classCardLargeText() =>
    _wrap(ClassCard(model: ClassCardStubs.loaded, onTap: () {}));

@Preview(name: 'RTL')
Widget classCardRtl() => _wrap(
      Directionality(
        textDirection: TextDirection.rtl,
        child: ClassCard(model: ClassCardStubs.loaded, onTap: () {}),
      ),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(
        body: Center(
          child: Padding(padding: const EdgeInsets.all(16), child: child),
        ),
      ),
    );

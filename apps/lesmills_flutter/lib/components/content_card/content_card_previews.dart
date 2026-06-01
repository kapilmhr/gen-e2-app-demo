import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../theme/app_theme.dart';
import 'content_card.dart';
import 'content_card_stubs.dart';

@Preview(name: 'Loaded')
Widget contentCardLoaded() =>
    _wrap(ContentCard(model: ContentCardStubs.loaded, onTap: () {}));

@Preview(name: 'Long content')
Widget contentCardLongContent() =>
    _wrap(ContentCard(model: ContentCardStubs.longContent, onTap: () {}));

@Preview(name: 'List')
Widget contentCardList() => _wrap(
      SizedBox(
        height: 260,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: ContentCardStubs.list.length,
          separatorBuilder: (_, _) => const SizedBox(width: 16),
          itemBuilder: (_, i) =>
              ContentCard(model: ContentCardStubs.list[i], onTap: () {}),
        ),
      ),
    );

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget contentCardDark() =>
    _wrap(ContentCard(model: ContentCardStubs.loaded, onTap: () {}));

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget contentCardLargeText() =>
    _wrap(ContentCard(model: ContentCardStubs.loaded, onTap: () {}));

@Preview(name: 'RTL')
Widget contentCardRtl() => _wrap(
      Directionality(
        textDirection: TextDirection.rtl,
        child: ContentCard(model: ContentCardStubs.longContent, onTap: () {}),
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

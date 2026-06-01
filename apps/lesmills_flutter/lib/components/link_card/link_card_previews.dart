import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import 'link_card.dart';
import 'link_card_stubs.dart';

@Preview(name: 'Challenge')
Widget linkCardChallenge() =>
    _wrap(LinkCard(model: LinkCardStubs.loaded, onPressed: () {}));

@Preview(name: 'Refer a friend (light scrim)')
Widget linkCardRefer() => _wrap(
      LinkCard(
        model: LinkCardStubs.referFriend,
        scrim: AppColors.scrimLight,
        onPressed: () {},
      ),
    );

@Preview(name: 'Long content')
Widget linkCardLongContent() =>
    _wrap(LinkCard(model: LinkCardStubs.longContent, onPressed: () {}));

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget linkCardDark() =>
    _wrap(LinkCard(model: LinkCardStubs.loaded, onPressed: () {}));

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget linkCardLargeText() =>
    _wrap(LinkCard(model: LinkCardStubs.loaded, onPressed: () {}));

@Preview(name: 'RTL')
Widget linkCardRtl() => _wrap(
      Directionality(
        textDirection: TextDirection.rtl,
        child: LinkCard(model: LinkCardStubs.loaded, onPressed: () {}),
      ),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(
        body: Padding(padding: const EdgeInsets.all(16), child: child),
      ),
    );

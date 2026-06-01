import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../theme/app_theme.dart';
import '../home_stubs.dart';
import 'home_hero_header.dart';

@Preview(name: 'Default')
Widget heroDefault() => _wrap(
      HomeHeroHeader(
        memberName: HomeStubs.loaded.memberName,
        imageAsset: HomeStubs.loaded.heroImageAsset,
        onScanIn: () {},
      ),
    );

@Preview(name: 'No image (placeholder)')
Widget heroNoImage() => _wrap(
      HomeHeroHeader(
        memberName: HomeStubs.loaded.memberName,
        onScanIn: () {},
      ),
    );

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget heroDark() => _wrap(
      HomeHeroHeader(
        memberName: HomeStubs.loaded.memberName,
        imageAsset: HomeStubs.loaded.heroImageAsset,
        onScanIn: () {},
      ),
    );

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget heroLargeText() => _wrap(
      HomeHeroHeader(
        memberName: HomeStubs.loaded.memberName,
        imageAsset: HomeStubs.loaded.heroImageAsset,
        onScanIn: () {},
      ),
    );

@Preview(name: 'RTL')
Widget heroRtl() => _wrap(
      Directionality(
        textDirection: TextDirection.rtl,
        child: HomeHeroHeader(
          memberName: HomeStubs.loaded.memberName,
          imageAsset: HomeStubs.loaded.heroImageAsset,
          onScanIn: () {},
        ),
      ),
    );

@Preview(name: 'Narrow width')
Widget heroNarrow() => _wrap(
      SizedBox(
        width: 320,
        child: HomeHeroHeader(
          memberName: HomeStubs.loaded.memberName,
          imageAsset: HomeStubs.loaded.heroImageAsset,
          onScanIn: () {},
        ),
      ),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(body: child),
    );

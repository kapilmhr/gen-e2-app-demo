import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../theme/app_spacing.dart';
import '../../../theme/app_theme.dart';
import '../explore_stubs.dart';
import 'discovery_carousel.dart';

final _carousel = ExploreStubs.loaded.discoveryCarousels.first;

@Preview(name: 'Default (New In)')
Widget discoveryDefault() => _wrap(
      DiscoveryCarouselView(label: _carousel.label, items: _carousel.items),
    );

@Preview(name: 'Classes (title only)')
Widget discoveryClasses() {
  final classes = ExploreStubs.loaded.discoveryCarousels[1];
  return _wrap(
    DiscoveryCarouselView(label: classes.label, items: classes.items),
  );
}

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget discoveryDark() => _wrap(
      DiscoveryCarouselView(label: _carousel.label, items: _carousel.items),
    );

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget discoveryLargeText() => _wrap(
      DiscoveryCarouselView(
        label: _carousel.label,
        items: _carousel.items,
        height: 320,
      ),
    );

@Preview(name: 'RTL')
Widget discoveryRtl() => _wrap(
      Directionality(
        textDirection: TextDirection.rtl,
        child:
            DiscoveryCarouselView(label: _carousel.label, items: _carousel.items),
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

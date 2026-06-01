import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../theme/app_theme.dart';
import 'pill_button.dart';

@Preview(name: 'Label only')
Widget pillButtonLabel() =>
    _wrap(PillButton(label: 'Share invite', onPressed: () {}));

@Preview(name: 'With icon')
Widget pillButtonIcon() => _wrap(
      PillButton(
        label: 'Scan in',
        icon: Icons.qr_code_scanner,
        onPressed: () {},
      ),
    );

@Preview(name: 'Disabled')
Widget pillButtonDisabled() => _wrap(const PillButton(label: 'Scan in'));

@Preview(name: 'Long content')
Widget pillButtonLongContent() => _wrap(
      SizedBox(
        width: 200,
        child: PillButton(
          label: 'Explore the 6-week challenge today',
          onPressed: () {},
        ),
      ),
    );

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget pillButtonDark() =>
    _wrap(PillButton(label: 'Scan in', onPressed: () {}));

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget pillButtonLargeText() =>
    _wrap(PillButton(label: 'Share invite', onPressed: () {}));

@Preview(name: 'RTL')
Widget pillButtonRtl() => _wrap(
      Directionality(
        textDirection: TextDirection.rtl,
        child: PillButton(
          label: 'Scan in',
          icon: Icons.qr_code_scanner,
          onPressed: () {},
        ),
      ),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );

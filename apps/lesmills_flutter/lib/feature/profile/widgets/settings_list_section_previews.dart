import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../theme/app_spacing.dart';
import '../../../theme/app_theme.dart';
import '../profile_stubs.dart';
import 'settings_list_section.dart';

@Preview(name: 'App settings')
Widget settingsSection() => _wrap(
      SettingsListSection(
        title: 'App Settings',
        rows: ProfileStubs.loaded.settings,
        onRowTap: (_) {},
      ),
    );

@Preview(name: 'Membership')
Widget membershipSection() => _wrap(
      SettingsListSection(
        title: 'Membership',
        rows: ProfileStubs.loaded.membership,
        onRowTap: (_) {},
      ),
    );

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget settingsSectionDark() => _wrap(
      SettingsListSection(
        title: 'App Settings',
        rows: ProfileStubs.loaded.settings,
      ),
    );

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget settingsSectionLargeText() => _wrap(
      SettingsListSection(
        title: 'App Settings',
        rows: ProfileStubs.loaded.settings,
      ),
    );

@Preview(name: 'RTL')
Widget settingsSectionRtl() => _wrap(
      Directionality(
        textDirection: TextDirection.rtl,
        child: SettingsListSection(
          title: 'App Settings',
          rows: ProfileStubs.loaded.settings,
        ),
      ),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(AppSpacing.s5),
          child: Align(alignment: Alignment.topCenter, child: child),
        ),
      ),
    );

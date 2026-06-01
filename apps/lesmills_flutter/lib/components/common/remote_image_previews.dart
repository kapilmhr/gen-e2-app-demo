import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../theme/app_spacing.dart';
import '../../theme/app_theme.dart';
import 'remote_image.dart';

@Preview(name: 'Neutral placeholder (no source)')
Widget remoteImagePlaceholder() => _wrap(const RemoteImage());

@Preview(name: 'Missing asset falls back')
Widget remoteImageMissingAsset() =>
    _wrap(const RemoteImage(assetPath: 'assets/images/__does_not_exist.png'));

@Preview(name: 'Dark', brightness: Brightness.dark)
Widget remoteImageDark() => _wrap(const RemoteImage());

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.s5),
            child: SizedBox(
              width: 200,
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.s4),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );

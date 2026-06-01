import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../theme/app_spacing.dart';
import '../../theme/app_theme.dart';
import 'list_row.dart';
import 'list_row_stubs.dart';

const _model = ListRowStubs.loaded;

@Preview(name: 'Default')
Widget listRowDefault() => _wrap(ListRow(model: _model, onTap: () {}));

@Preview(name: 'Long title')
Widget listRowLong() => _wrap(
      ListRow(
        model: ListRowStubs.longTitle,
        onTap: () {},
      ),
    );

@Preview(name: 'Dark (contrast check)', brightness: Brightness.dark)
Widget listRowDark() => _wrap(ListRow(model: _model, onTap: () {}));

@Preview(name: 'Large text', textScaleFactor: 2.0)
Widget listRowLargeText() => _wrap(ListRow(model: _model, onTap: () {}));

@Preview(name: 'RTL')
Widget listRowRtl() => _wrap(
      Directionality(
        textDirection: TextDirection.rtl,
        child: ListRow(model: _model, onTap: () {}),
      ),
    );

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(AppSpacing.s5),
          child: Align(
            alignment: Alignment.topCenter,
            child: Builder(
              builder: (context) => Material(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(AppSpacing.s2),
                clipBehavior: Clip.antiAlias,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );

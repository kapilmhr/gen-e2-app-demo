import 'package:flutter/material.dart';

import 'feature/home/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const LesMillsApp());
}

/// Root of the Les Mills member app. Light theme only.
class LesMillsApp extends StatelessWidget {
  const LesMillsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Les Mills',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomeScreen(),
    );
  }
}

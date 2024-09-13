import 'package:flutter/material.dart';
import 'package:hotline_app/flow/home_page/view/home_page.dart';
import 'package:hotline_app/theme/theme.dart';

class HotlineApp extends StatelessWidget {
  const HotlineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme,
      home: const HomePage(),
    );
  }
}

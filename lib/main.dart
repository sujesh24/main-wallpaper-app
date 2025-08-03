import 'package:flutter/material.dart';

import 'package:main_wallpaper_app/pages/bottom_nav.dart';
import 'package:main_wallpaper_app/pages/custom_scroll_behaviour.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: CustomScrollBehaviour(),
      home: const BottomNav(),
      debugShowCheckedModeBanner: false,
      title: 'Wallpaper App',
    );
  }
}

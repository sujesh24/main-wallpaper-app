import 'package:flutter/material.dart';
import 'package:main_wallpaper_app/pages/bottom_nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNav(),
      debugShowCheckedModeBanner: false,
      title: 'Wallpaper App',
    );
  }
}

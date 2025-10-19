import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:main_wallpaper_app/pages/bottom_nav.dart';
import 'package:main_wallpaper_app/pages/custom_scroll_behaviour.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
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

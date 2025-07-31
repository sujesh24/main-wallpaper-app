import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:main_wallpaper_app/pages/category.dart';
import 'package:main_wallpaper_app/pages/home_screen.dart';
import 'package:main_wallpaper_app/pages/search.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;

  late List<Widget> pages;
  late HomeScreen home;
  late Search search;
  late Category category;
  late Widget currentPage;

  @override
  void initState() {
    super.initState();
    home = HomeScreen();
    search = Search();
    category = Category();
    currentPage = HomeScreen();
    pages = [home, search, category];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        color: Color.fromARGB(255, 84, 87, 93),
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
            currentPage = pages[index];
          });
        },
        animationDuration: Duration(milliseconds: 500),
        items: [
          Icon(Icons.home_outlined, color: Colors.white),
          Icon(Icons.search_outlined, color: Colors.white),
          Icon(Icons.category_outlined, color: Colors.white),
        ],
      ),
      body: pages[currentIndex],
    );
  }
}

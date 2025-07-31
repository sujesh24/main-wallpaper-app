import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List wallpaperImage = [
    'images/image1.jpeg',
    'images/image2.jpeg',
    'images/image3.jpeg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(50),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'images/cat.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 100),
                Center(
                  child: Text(
                    'Wallify',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            CarouselSlider.builder(
              itemCount: wallpaperImage.length,
              itemBuilder: (context, index, realIndex) {
                final res = wallpaperImage[index];
                return buildImage(res, index);
              },
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 1.5,
                viewportFraction: 1,
                autoPlay: true,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String res, int index) => SizedBox(
    height: MediaQuery.of(context).size.height / 1.5,
    width: MediaQuery.of(context).size.width,

    child: ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Image.asset(res, fit: BoxFit.cover, width: double.infinity),
    ),
  );
}

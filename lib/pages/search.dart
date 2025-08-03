import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:main_wallpaper_app/models/model.dart';
import 'package:main_wallpaper_app/pages/preview_page.dart';
import 'package:main_wallpaper_app/repo/repository.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  int? selectedCategoryIndex;
  late Future<List<Images>> imagesList;
  Repository repo = Repository();
  int pagenumber = 1;
  TextEditingController searchController = TextEditingController();
  final List<String> categories = [
    'Nature',
    'abstract',
    'Animals',
    'car',
    'bike',
    'Technology',
    'Cities',
    'Food',
    'People',
  ];

  @override
  void initState() {
    super.initState();
    imagesList = repo.getImagesList(pagenumber: pagenumber);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  //by search
  void getImagesByseacrh({required String query}) {
    setState(() {
      imagesList = repo.searchImages(query: query, pagenumber: pagenumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              SizedBox(height: 5),
              //search bar
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: searchController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                  ],
                  onSubmitted: (value) {
                    getImagesByseacrh(query: value);

                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,

                    contentPadding: EdgeInsets.all(15),
                    hintText: 'Search',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        getImagesByseacrh(query: searchController.text);
                      },
                    ),
                  ),
                ),
              ),
              //categories
              SizedBox(height: 20),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        getImagesByseacrh(query: categories[index]);
                        setState(() {
                          selectedCategoryIndex = index;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedCategoryIndex == index
                                ? Colors.blue.withOpacity(
                                    0.1,
                                  ) // Highlighted background
                                : Colors.grey[50], // Normal background
                            border: Border.all(
                              color: selectedCategoryIndex == index
                                  ? Colors
                                        .blue // Highlighted border
                                  : Colors.grey, // Normal border
                              width: selectedCategoryIndex == index
                                  ? 2
                                  : 1, // Thicker border when selected
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                categories[index],
                                style: TextStyle(
                                  color: selectedCategoryIndex == index
                                      ? Colors
                                            .blue // Highlighted text color
                                      : Colors.black, // Normal text color
                                  fontWeight: selectedCategoryIndex == index
                                      ? FontWeight
                                            .bold // Bold when selected
                                      : FontWeight
                                            .normal, // Normal when not selected
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),

              //grid view
              FutureBuilder(
                future: imagesList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error! Something went wrong.'),
                      );
                    }
                    //grid
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: MasonryGridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            crossAxisCount: 2,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              double height = (index % 10 + 1) * 100;
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PreviewPage(
                                        imageUrl: snapshot
                                            .data![index]
                                            .imagePortraitPath,
                                        imageId: snapshot.data![index].imageId,
                                      ),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    height: height > 300 ? 300 : height,
                                    imageUrl:
                                        snapshot.data![index].imagePortraitPath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        //load more
                        SizedBox(height: 10),
                        MaterialButton(
                          onPressed: () {
                            pagenumber++;
                            setState(() {
                              imagesList = repo.searchImages(
                                query: searchController.text,
                                pagenumber: pagenumber,
                              );
                            });
                          },
                          minWidth: double.infinity,
                          color: Colors.blue,
                          textColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text('Load More'),
                        ),
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

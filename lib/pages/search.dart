import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:main_wallpaper_app/models/model.dart';
import 'package:main_wallpaper_app/repo/repository.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late Future<List<Images>> imagesList;
  Repository repo = Repository();
  int pagenumber = 1;
  TextEditingController searchController = TextEditingController();
  final List<String> categories = [
    'Nature',
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
                  onSubmitted: (value) {},
                  decoration: InputDecoration(
                    border: InputBorder.none,

                    contentPadding: EdgeInsets.all(15),
                    hintText: 'Search',
                    suffixIcon: Icon(Icons.search),
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),

                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(child: Text(categories[index])),
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

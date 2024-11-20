import 'package:flutter/material.dart';
import 'package:pexwallpaper/Controller/apicode.dart';
import 'package:pexwallpaper/Model/photomodel.dart';
import 'package:pexwallpaper/Views/Screens/fullscreen.dart';
import 'package:pexwallpaper/Views/Widgets/myappbar.dart';
import 'package:pexwallpaper/Views/Widgets/searchbar.dart';

class Searchscreen extends StatefulWidget {
  final String query;
  const Searchscreen({super.key, required this.query});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  late List<Photomodel> searchResults;
  bool isLoading = true;
  getsearchresult() async {
    searchResults = await Apicode.searchWallpapers(widget.query);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getsearchresult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const MyAppBar(text1: "Pex", text2: "Wallpaper"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Searchbar(),
                  const SizedBox(
                    height: 21,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 400,
                              crossAxisSpacing: 11,
                              mainAxisSpacing: 11),
                      itemCount: searchResults.length,
                      itemBuilder: ((context, index) => GridTile(
                              child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FullScreen(
                                            imgUrl: searchResults[index].imgSrc,
                                            imageId: hashCode,
                                            imageUrl: '',
                                          )));
                            },
                            child: Hero(
                              tag: searchResults[index].imgSrc,
                              child: Container(
                                height: 500,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(21),
                                  color: Colors.blueAccent,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(21),
                                  child: Image.network(
                                      height: 500,
                                      width: 50,
                                      fit: BoxFit.cover,
                                      searchResults[index].imgSrc),
                                ),
                              ),
                            ),
                          ))),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

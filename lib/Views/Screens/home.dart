import 'package:flutter/material.dart';
import 'package:pexwallpaper/Controller/apicode.dart';
import 'package:pexwallpaper/Model/photomodel.dart';
import 'package:pexwallpaper/Views/Screens/fullscreen.dart';

import 'package:pexwallpaper/Views/Widgets/categories.dart';
import 'package:pexwallpaper/Views/Widgets/myappbar.dart';
import 'package:pexwallpaper/Views/Widgets/searchbar.dart';

import '../../Model/categorymodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Photomodel> trendingWallList;
  late List<CategoryModel> catmodList;
  bool isLoading = true;

  getCatdetails() async {
    catmodList = Apicode.getCategoriesList();
    print("GETTTING CAT MOD LIST");
    print(catmodList);
    setState(() {
      catmodList = catmodList;
    });
  }

  gettrandingwallpapers() async {
    trendingWallList = await Apicode.getTrendingWallpapers();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    gettrandingwallpapers();
    getCatdetails();
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
                  SizedBox(
                    height: 75,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: catmodList.length,
                        itemBuilder: ((context, index) => Categories(
                              categoryImgSrc: catmodList[index].cateImgUrl,
                              categoryName: catmodList[index].cateName,
                            ))),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 700,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      },
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 400,
                                crossAxisSpacing: 11,
                                mainAxisSpacing: 11),
                        itemCount: trendingWallList.length,
                        itemBuilder: ((context, index) => GridTile(
                                child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FullScreen(
                                              imgUrl: trendingWallList[index]
                                                  .imgSrc,
                                              imageId: widget.hashCode,
                                              imageUrl: '',
                                            )));
                              },
                              child: Hero(
                                tag: trendingWallList[index].imgSrc,
                                child: Container(
                                  height: 800,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(21),
                                    color: Colors.blueAccent,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(21),
                                    child: Image.network(
                                        height: 800,
                                        width: 50,
                                        fit: BoxFit.cover,
                                        trendingWallList[index].imgSrc),
                                  ),
                                ),
                              ),
                            ))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

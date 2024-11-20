import 'package:flutter/material.dart';
import 'package:pexwallpaper/Controller/apicode.dart';
import 'package:pexwallpaper/Model/photomodel.dart';
import 'package:pexwallpaper/Views/Widgets/myappbar.dart';

import 'fullscreen.dart';

class Categoryscreen extends StatefulWidget {
  final String cateName;
  final String cateImgUrl;
  const Categoryscreen(
      {super.key, required this.cateImgUrl, required this.cateName});

  @override
  State<Categoryscreen> createState() => _CategoryscreenState();
}

class _CategoryscreenState extends State<Categoryscreen> {
  late List<Photomodel> categoryResult;
  bool isLoading = true;
  getCatRelWall() async {
    categoryResult = await Apicode.searchWallpapers(widget.cateName);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCatRelWall();
    super.initState();
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
                  Stack(
                    children: [
                      Image.network(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          widget.cateImgUrl),
                      Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black38,
                      ),
                      Positioned(
                        left: 120,
                        top: 40,
                        child: Column(
                          children: [
                            const Text(
                              "Category",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              widget.cateName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 800,
                    child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 400,
                                crossAxisSpacing: 11,
                                mainAxisSpacing: 11),
                        itemCount: categoryResult.length,
                        itemBuilder: ((context, index) => GridTile(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullScreen(
                                        imgUrl: categoryResult[index].imgSrc,
                                        imageId: hashCode,
                                        imageUrl: '',
                                      ),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: categoryResult[index].imgSrc,
                                  child: Container(
                                    height: 700,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      color: Colors.blueAccent,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(21),
                                      child: Image.network(
                                          height: 700,
                                          width: 50,
                                          fit: BoxFit.cover,
                                          categoryResult[index].imgSrc),
                                    ),
                                  ),
                                ),
                              ),
                            ))),
                  ),
                ],
              ),
            ),
    );
  }
}

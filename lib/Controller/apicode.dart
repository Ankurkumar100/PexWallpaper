import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:pexwallpaper/Model/photomodel.dart';

import '../Model/categorymodel.dart';

class Apicode {
  static List<Photomodel> trendingWallpapers = [];
  static List<Photomodel> searchWallpaperList = [];
  static List<CategoryModel> cateogryModelList = [];
  static Future<List<Photomodel>> getTrendingWallpapers() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated"), headers: {
      "Authorization":
          "kObK2z2eoyLp9DWlU0rHZrr405LAAu56rzBgxGIAPlZ5wguLX5XAho9H"
    }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      for (var element in photos) {
        trendingWallpapers.add(Photomodel.fromAPIApp(element));
      }
    });
    return trendingWallpapers;
  }

  static Future<List<Photomodel>> searchWallpapers(String query) async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
        headers: {
          "Authorization":
              "kObK2z2eoyLp9DWlU0rHZrr405LAAu56rzBgxGIAPlZ5wguLX5XAho9H"
        }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      searchWallpaperList.clear();
      for (var element in photos) {
        searchWallpaperList.add(Photomodel.fromAPIApp(element));
      }
    });
    return searchWallpaperList;
  }

  static List<CategoryModel> getCategoriesList() {
    List cateogryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers"
    ];
    cateogryModelList.clear();
    cateogryName.forEach((cateName) async {
      final random = Random();

      Photomodel photoModel =
          (await searchWallpapers(cateName))[0 + random.nextInt(11 - 0)];
      cateogryModelList.add(
          CategoryModel(cateImgUrl: photoModel.imgSrc, cateName: cateName));
    });

    return cateogryModelList;
  }
}

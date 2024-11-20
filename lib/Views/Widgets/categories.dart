import 'package:flutter/material.dart';

import '../Screens/category.dart';

class Categories extends StatelessWidget {
  final String categoryName;
  final String categoryImgSrc;
  const Categories(
      {super.key, required this.categoryImgSrc, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Categoryscreen(
                    cateImgUrl: categoryImgSrc, cateName: categoryName)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Image.network(
                  height: 50, width: 100, fit: BoxFit.cover, categoryImgSrc),
            ),
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(11)),
            ),
            Positioned(
                left: 25,
                top: 12.5,
                child: Text(
                  categoryName,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}

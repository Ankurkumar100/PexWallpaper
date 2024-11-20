import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pexwallpaper/Views/Screens/search.dart';

class Searchbar extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  Searchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(21),
        boxShadow: const [
          BoxShadow(
            blurRadius: sqrt1_2,
            offset: Offset(1, 1),
            color: Colors.blueAccent,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Search",
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Searchscreen(query: _textEditingController.text)));
            },
            child: const Icon(Icons.search_sharp),
          ),
        ],
      ),
    );
  }
}

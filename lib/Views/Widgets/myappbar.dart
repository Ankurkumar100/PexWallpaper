import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final String text1;
  final String text2;
  const MyAppBar({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text1,
        style: const TextStyle(
            color: Colors.black, fontSize: 21, fontWeight: FontWeight.bold),
        children: [
          TextSpan(
              text: text2,
              style: const TextStyle(
                  color: Colors.red, fontSize: 21, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}

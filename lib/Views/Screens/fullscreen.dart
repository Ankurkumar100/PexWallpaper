import 'package:flutter/material.dart';
import 'package:pexwallpaper/Repository/repository.dart';

class FullScreen extends StatefulWidget {
  final String imageUrl;
  final int imageId;
  final String imgUrl;
  const FullScreen({
    super.key,
    required this.imageId,
    required this.imageUrl,
    required this.imgUrl,
  });

  @override
  State<FullScreen> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<FullScreen> {
  Repository repo = Repository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.imgUrl), fit: BoxFit.cover)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(230, 10, 10, .5),
        foregroundColor: const Color.fromRGBO(255, 255, 255, .8),
        shape: const CircleBorder(),
        onPressed: () {
          repo.downloadImage(
              imageUrl: widget.imageUrl,
              imageId: widget.imageId,
              context: context);
        },
        child: const Icon(Icons.download),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

//           child: const Text("Set Wallpaper")),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: NetworkImage(widget.imgUrl), fit: BoxFit.cover)),
//       ),
//     );
//   }
// }

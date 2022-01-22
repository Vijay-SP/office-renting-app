import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class ShowImage extends StatelessWidget {
  final String imgUrl;
  const ShowImage({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        child: PhotoView(
          imageProvider: NetworkImage(imgUrl),
        )
    );
  }
}

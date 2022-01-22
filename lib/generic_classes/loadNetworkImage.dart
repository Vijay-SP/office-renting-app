import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadNetworkImage extends StatelessWidget {
  final String imgUrl;
  const LoadNetworkImage({Key? key, required this.imgUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        imgUrl,
        errorBuilder: (context, exception, stackTrack) => Container(
          width: 200,
          child: Center(
            child: Column(
              children: [
                Icon(
                  Icons.error,
                  size: 70,
                  color: Theme.of(context).primaryColor,
                ),
                Text("Image cannot be loaded!"),
              ],
            ),
          ),
        ),
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            width: 200,
            child: Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                )),
          );
        },
      ),
    );
  }
}

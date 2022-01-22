import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OurServiceCard extends StatefulWidget {
  final String serviceName;
  final String serviceImage;

  OurServiceCard({required this.serviceImage, required this.serviceName});

  @override
  _OurServiceCardState createState() => _OurServiceCardState();
}

class _OurServiceCardState extends State<OurServiceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
            color: Colors.white,
            elevation: 6.0,
            shadowColor: Theme.of(context).primaryColor,
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.5,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    height: 400.0,
                    width: MediaQuery.of(context).size.width,
                    child: LoadServiceImage(
                      url: widget.serviceImage,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    widget.serviceName,
                    style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class LoadServiceImage extends StatefulWidget {
  final String? url;
  LoadServiceImage({this.url});
  @override
  _LoadServiceImageState createState() => _LoadServiceImageState();
}

class _LoadServiceImageState extends State<LoadServiceImage> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Image.network(
        widget.url ?? '',
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width,
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
              ),
            ),
          );
        },
      ),
    );
  }
}

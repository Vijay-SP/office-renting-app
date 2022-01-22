import 'package:rentify/screens/propertyPage.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PropertyCard extends StatelessWidget {
  final Map<String, dynamic> property;
  const PropertyCard({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: FittedBox(
          child: Material(
            color: Colors.white,
            elevation: 8.0,
            borderRadius: BorderRadius.circular(10),
            shadowColor: Theme.of(context).primaryColor,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ListTile(
                    title: Text(property["prop_name"]),
                    isThreeLine: true,
                    subtitle: Text(
                      property["address"]["city"] +
                          " " +
                          property["address"]["country"] +
                          "\n" +
                          (property["details"]["price"] ?? ""),
                      style: TextStyle(fontSize: 12),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PropertyPage(property: property),
                        ),
                      );
                    },
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.0), topRight: Radius.circular(10.0) ),
                  child: Image.network(
                    property["img_links"][0],
                    fit: BoxFit.contain,
                    width: 150,
                    errorBuilder: (context, exception, stackTrack) => Container(
                      height: 100,
                      width: 150,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error,
                              size: 45,
                              color: Theme.of(context).primaryColor,
                            ),
                            Text(
                              "Image cannot be loaded!",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        width: 150,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            color: Colors.white,
                            width: 150,
                            height: 100,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

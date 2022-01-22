import 'package:ebloffices/screens/propertyPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

class PropertyCardVertical extends StatelessWidget {
  final Map<String, dynamic> property;
  const PropertyCardVertical({Key? key, required this.property})
      : super(key: key);
  String avgRating(Map<String, dynamic> ratings) {
    var numerator = 1 * ratings["1"]["0"] +
        2 * ratings["2"]["0"] +
        3 * ratings["3"]["0"] +
        4 * ratings["4"]["0"] +
        5 * ratings["5"]["0"];
    var denominator = ratings["1"]["0"] +
        ratings["2"]["0"] +
        ratings["3"]["0"] +
        ratings["4"]["0"] +
        ratings["5"]["0"];
    if (denominator != 0)
      return (numerator / denominator).toStringAsFixed(2);
    else
      return "0.00";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Material(
        color: Colors.white,
        elevation: 8.0,
        borderRadius: BorderRadius.circular(10),
        shadowColor: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Image.network(
                    property["img_links"][0],
                    fit: BoxFit.contain,
                    errorBuilder: (context, exception, stackTrack) => Container(
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
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
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
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      property["prop_name"],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      property["address"]["city"] +
                          " " +
                          property["address"]["country"],
                      style: TextStyle(color: Colors.black87),
                    ),
                    trailing: OutlinedButton(
                      child: Text("Show more"),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.blue),
                      ),
                      onPressed: () {
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.moneyBillWave,
                        color: Colors.green,
                      ),
                      label: Text(
                        property["details"]["price"] ?? "",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (avgRating(property["rating"]) != "0.00")
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: FaIcon(
                          FontAwesomeIcons.starHalfAlt,
                          color: Colors.amber,
                        ),
                        label: Text(
                          "Avg. rating " + avgRating(property["rating"]),
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.clock,
                        color: Theme.of(context).primaryColor,
                      ),
                      label: Text(
                        property["updated_on"],
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

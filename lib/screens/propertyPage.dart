import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebloffices/authentication/firebase_auth_service.dart';
import 'package:ebloffices/generic_classes/loadNetworkImage.dart';
import 'package:ebloffices/generic_classes/primaryButton.dart';
import 'package:ebloffices/generic_classes/showImage.dart';
import 'package:ebloffices/screens/bookAppointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class PropertyPage extends StatefulWidget {
  final Map<String, dynamic> property;

  const PropertyPage({Key? key, required this.property}) : super(key: key);

  @override
  _PropertyPageState createState() => _PropertyPageState();
}

class _PropertyPageState extends State<PropertyPage> {
  Widget cardHeader(String text) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 0.6,
          child: Container(color: Colors.blueGrey),
        ),
        SizedBox(height: 5)
      ],
    );
  }

  String avgRating(Map<String, dynamic> ratings) {
    var numerator = 1 * ratings["1"]["0"] + 2 * ratings["2"]["0"] + 3 * ratings["3"]["0"] + 4 * ratings["4"]["0"] + 5 * ratings["5"]["0"];
    var denominator = ratings["1"]["0"] + ratings["2"]["0"] + ratings["3"]["0"] + ratings["4"]["0"] + ratings["5"]["0"];
    if (denominator != 0)
      return (numerator / denominator).toStringAsFixed(2);
    else
      return "0.00";
  }

  @override
  Widget build(BuildContext context) {
    var property = widget.property;
    var userData = Provider.of<Map<String, dynamic>?>(context, listen: false);
    var user = Provider.of<FirebaseAuthService>(context, listen: false).currentUser();
    // var rating = avgRating(property["rating"]);
    return Scaffold(
      appBar: AppBar(
        title: Text(property["prop_name"]),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Images of the property
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: property["img_links"].length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Card(
                        elevation: 10,
                        shadowColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: LoadNetworkImage(imgUrl: property["img_links"][index]),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowImage(imgUrl: property["img_links"][index]),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              // Details Card
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DataTable(
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              "Price",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          DataCell(
                            Text(property["details"]["price"]),
                          ),
                        ],
                      ),
                      if (property["details"]["prop_size"] != null)
                        DataRow(
                          cells: [
                            DataCell(
                              Text(
                                "Size",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            DataCell(
                              Text(property["details"]["prop_size"]),
                            ),
                          ],
                        ),
                      if (property["details"]["prop_type"] != null)
                        DataRow(
                          cells: [
                            DataCell(
                              Text(
                                "Type",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            DataCell(
                              Text(property["details"]["prop_type"].join(',')),
                            ),
                          ],
                        ),
                      if (property["details"]["prop_status"] != null)
                        DataRow(
                          cells: [
                            DataCell(
                              Text("Status", style: TextStyle(fontSize: 16)),
                            ),
                            DataCell(
                              Text(property["details"]["prop_status"]),
                            ),
                          ],
                        ),
                    ],
                    columns: [
                      DataColumn(
                          label: Text(
                        "Details",
                        style: TextStyle(fontSize: 20),
                      )),
                      DataColumn(label: Text("")),
                    ],
                  ),
                ),
              ),

              // Features
              SizedBox(
                height: 275,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      cardHeader("Features"),
                      Text(
                        "Scroll in the box to see more features",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Scrollbar(
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: property["features"].length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        dense: true,
                                        title: Text(property["features"][index]),
                                      ),
                                      SizedBox(
                                        height: 0.6,
                                        child: Container(color: Colors.blueGrey),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Address Details
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DataTable(
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(
                            Text("Address", style: TextStyle(fontSize: 16)),
                          ),
                          DataCell(Text(property["address"]["address"])),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text("City", style: TextStyle(fontSize: 16)),
                          ),
                          DataCell(
                            Text(property["address"]["city"]),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              "Zip/Postal Code",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          DataCell(
                            Text(property["address"]["zip"]),
                          ),
                        ],
                      ),
                    ],
                    columns: [
                      DataColumn(
                          label: Text(
                        "Address",
                        style: TextStyle(fontSize: 20),
                      )),
                      DataColumn(label: Text("")),
                    ],
                  ),
                ),
              ),

              //Rating Card
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cardHeader("Rate this property"),
                      RatingBar.builder(
                        initialRating: 0.0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) async {
                          await FirebaseFirestore.instance.collection("Properties").doc(property["id"]).update({
                            "rating.$rating": FieldValue.increment(1),
                          });
                          Fluttertoast.showToast(msg: "Rating submitted. Thank you!");
                        },
                      ),
                      if (avgRating(property["rating"]) != "0.00")
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text("Avg. Rating: " + avgRating(property["rating"])),
                        )
                    ],
                  ),
                ),
              ),
// Additional Details
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DataTable(
                    rows: [
                      if (property["additional_details"]["coworking_desks"] != null)
                        DataRow(
                          cells: [
                            DataCell(
                              Text("Coworking Desks", style: TextStyle(fontSize: 16)),
                            ),
                            DataCell(Text(property["additional_details"]["coworking_desks"].toString())),
                          ],
                        ),
                      if (property["additional_details"]["meeting_rooms"] != null)
                        DataRow(
                          cells: [
                            DataCell(
                              Text("Meeting Rooms", style: TextStyle(fontSize: 16)),
                            ),
                            DataCell(
                              Text(property["additional_details"]["meeting_rooms"].toString()),
                            ),
                          ],
                        ),
                      if (property["additional_details"]["offices"] != null)
                        DataRow(
                          cells: [
                            DataCell(
                              Text(
                                "Offices",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            DataCell(
                              Text(property["additional_details"]["offices"].toString()),
                            ),
                          ],
                        ),
                      if (property["additional_details"]["private_offices"] != null)
                        DataRow(
                          cells: [
                            DataCell(
                              Text(
                                "Private Offices",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            DataCell(
                              Text(property["additional_details"]["private_offices"].toString()),
                            ),
                          ],
                        ),
                    ],
                    columns: [
                      DataColumn(
                          label: Text(
                        "Add ons",
                        style: TextStyle(fontSize: 20),
                      )),
                      DataColumn(label: Text("")),
                    ],
                  ),
                ),
              ),

              // Description
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    cardHeader("Description"),
                    Text(
                      property["desc"].replaceAll("\n\n", "\n").trim(),
                      softWrap: true,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: userData!["wishlist"].toString().contains(RegExp(property["id"]))
                          ? ElevatedButton.icon(
                              icon: Icon(Icons.favorite_outline),
                              label: Text("Already Added"),
                              onPressed: () async {
                                await FirebaseFirestore.instance.collection("Users").doc(user!.email).update({
                                  "wishlist": FieldValue.arrayRemove([property["id"]]),
                                });
                                Fluttertoast.showToast(msg: "Removed from favourites!");
                              },
                            )
                          : ElevatedButton.icon(
                              icon: Icon(Icons.favorite),
                              label: Text("Add to wishlist"),
                              onPressed: () async {
                                if (user == null) {
                                  Navigator.pushNamed(context, "/auth");
                                } else {
                                  await FirebaseFirestore.instance.collection("Users").doc(user.email).update({
                                    "wishlist": FieldValue.arrayUnion([property["id"]]),
                                  });
                                  Fluttertoast.showToast(msg: "Added to favourites!", toastLength: Toast.LENGTH_LONG);
                                }
                              },
                            ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.map_outlined),
                        label: Text("Open in map"),
                        onPressed: () {
                          var query = MapsLauncher.createQueryUrl(property["map_url"]);
                          MapsLauncher.launchQuery(query);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: PrimaryButton(
                    btnText: "Book an Appointment",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => BookAppointment(
                            propertyName: property["prop_name"],
                          ),
                        ),
                      );
                    }),
              ),
              if (property["floor_plans"].length > 0)
                SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      cardHeader("Floor Plans"),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemCount: property["floor_plans"].length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: Card(
                                elevation: 10,
                                shadowColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                child: LoadNetworkImage(imgUrl: property["floor_plans"][index]),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShowImage(imgUrl: property["floor_plans"][index]),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

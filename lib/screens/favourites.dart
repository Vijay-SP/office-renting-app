import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebloffices/authentication/firebase_auth_service.dart';
import 'package:ebloffices/generic_classes/propertyCardVertical.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

// ignore: camel_case_types
class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseAuthService>(context).currentUser();

    Future<List<Map<String, dynamic>>>? getProperties() async {
      var userDoc = await FirebaseFirestore.instance
          .collection("Users")
          .doc(user!.email)
          .get();
      Map<String, dynamic>? userData = userDoc.data();
      var propertiesID = userData!["wishlist"];
      List<Map<String, dynamic>> myWishlist = [];
      for (var i = 0; i < propertiesID.length; i++) {
        var propRef = await FirebaseFirestore.instance
            .collection("Properties")
            .doc(propertiesID[i])
            .get();
        Map<String, dynamic>? propData = propRef.data();
        propData!["id"] = propRef.id;
        myWishlist.add(propData);
      }

      return myWishlist;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Wishlist"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder(
          future: getProperties(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              var myWishlist = snapshot.data;

              if (myWishlist!.length > 0) {
                return ListView.builder(
                  itemCount: myWishlist.length,
                  itemBuilder: (context, index) {
                    return PropertyCardVertical(
                        property: myWishlist[index]
                    );
                  },
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/noFavouriteFound.jpg",
                        fit: BoxFit.fitWidth,
                      ),
                      Text("No properties added to favourite!"),
                    ],
                  ),
                );
              }
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "OOPS!\n Some error occurred\nCheck your internet connection speed!",
                  textAlign: TextAlign.center,
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

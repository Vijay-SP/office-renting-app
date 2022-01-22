import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentify/generic_classes/loadingPropertyCard.dart';
import 'package:rentify/generic_classes/propertyCard.dart';
import 'package:rentify/generic_classes/propertyCardVertical.dart';
import 'package:rentify/screens/propertyPage.dart';
import 'package:flutter/material.dart';

class PropertiesPage extends StatefulWidget {
  const PropertiesPage({Key? key}) : super(key: key);

  @override
  _PropertiesPageState createState() => _PropertiesPageState();
}

class _PropertiesPageState extends State<PropertiesPage> {
  @override
  Widget build(BuildContext context) {
    final CollectionReference<Map<String, dynamic>> propRef =
        FirebaseFirestore.instance.collection('Properties');
    return Scaffold(
      appBar: AppBar(
        title: Text("Properties"),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       showSearch(context: context, delegate: DataSearch());
        //     },
        //     icon: Icon(Icons.search),
        //   ),
        // ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: propRef.snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasData) {
                    // Get data from docs and convert map to List
                    final List propList = snapshot.data!.docs.map((doc) {
                      var data = doc.data();
                      data["id"] = doc.id;
                      return data;
                    }).toList();

                    return ListView.builder(
                      itemCount: propList.length,
                      itemBuilder: (context, index) {
                        return PropertyCardVertical(property: propList[index]);
                      },
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "OOPS!\n Some error occurred\nCheck your internet connection speed\nSorry for the inconvenience :(",
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        return LoadingPropertyCard();
                      },
                    ),
                    // child: Text("dsf"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    return PropertyPage(property: {});
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    final CollectionReference<Map<String, dynamic>> propRef =
        FirebaseFirestore.instance.collection('Properties');
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: propRef.snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  // Get data from docs and convert map to List
                  final List propList = snapshot.data!.docs.map((doc) {
                    var data = doc.data();
                    data["id"] = doc.id;
                    return data;
                  }).toList();
                  final suggestionList = query.isEmpty
                      ? propList
                      : propList.where((element) {
                          try {
                            return element.toString().contains(
                                  RegExp(
                                    query,
                                    caseSensitive: false,
                                  ),
                                );
                          } catch (e) {
                            return false;
                          }
                        }).toList();
                  return ListView.builder(
                    itemCount: suggestionList.length,
                    itemBuilder: (context, index) {
                      return PropertyCard(property: suggestionList[index]);
                    },
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    "OOPS!\n Some error occured\nCheck your internet connection speed\nSorry for the inconvenience :(",
                    textAlign: TextAlign.center,
                  ));
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

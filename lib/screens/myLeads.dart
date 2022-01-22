import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentify/authentication/firebase_auth_service.dart';
import 'package:rentify/generic_classes/customDialogs.dart';
import 'package:rentify/generic_classes/primaryButton.dart';
import 'package:rentify/screens/editLeads.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyLeads extends StatefulWidget {
  final state = _MyLeadsState();

  @override
  _MyLeadsState createState() => _MyLeadsState();
}

class _MyLeadsState extends State<MyLeads> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseAuthService>(context).currentUser();
    return Scaffold(
      appBar: AppBar(
        title: Text("My Leads"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(user!.email)
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasError) {
            return Center(
              child: Text("Some Error Occured"),
            );
          }
          if (snapshots.hasData) {
            final dynamic docData = snapshots.data;
            final dynamic myLeadsList = docData!["myLeads"];
            return (myLeadsList.length == 0)
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No leads found!",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          PrimaryButton(
                              btnText: "Add Leads",
                              onPressed: () {
                                Navigator.pushNamed(context, "/addLeads");
                              }),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: myLeadsList.length,
                    addAutomaticKeepAlives: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: Material(
                          shadowColor: Theme.of(context).primaryColor,
                          elevation: 5,
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
                                title: Text(
                                  myLeadsList[index]['name'],
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(fontSize: 20),
                                ),
                                subtitle: Text(
                                  myLeadsList[index]['property'],
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                leading:
                                    myLeadsList[index]['isConverted'] == true
                                        ? CircleAvatar(
                                      radius: 18,
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/images/check.png'),
                                            ),
                                          )
                                        : CircleAvatar(
                                      radius: 18,
                                            backgroundColor: Colors.white,
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/images/pend.png'),
                                            ),
                                          ),
                                trailing: TextButton(
                                  onPressed: () {
                                    Dialog dialog = Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: leadDialog(
                                        name: myLeadsList[index]['name'],
                                        property: myLeadsList[index]
                                            ['property'],
                                        contact: myLeadsList[index]['phone'],
                                        email: myLeadsList[index]['email'],
                                        isConverted: myLeadsList[index]['isConverted'],
                                      ),
                                    );
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return dialog;
                                        });
                                  },
                                  child: Text(
                                    "View more",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: double.infinity,
                                child: Container(
                                  height: 0.5,
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        child: TextButton(
                                          onPressed: () {
                                            String no = "tel:+" +
                                                myLeadsList[index]
                                                    ["phoneCode"] +
                                                myLeadsList[index]["phone"];
                                            launch(no);
                                          },
                                          child: Text(
                                            "Call",
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: TextButton(
                                          onPressed: () {
                                            String no = "mailto:" +
                                                myLeadsList[index]["email"] +
                                                "?subject=To " +
                                                myLeadsList[index]["name"] +
                                                "&body=Hi I am ${user.displayName} from EBL offices";
                                            launch(no);
                                          },
                                          child: Text(
                                            "Mail",
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EditLead(
                                                  name: myLeadsList[index]
                                                      ["name"],
                                                  property: myLeadsList[index]
                                                      ["property"],
                                                  email: myLeadsList[index]
                                                      ["email"],
                                                  phone: myLeadsList[index]
                                                      ["phone"],
                                                  index: myLeadsList[index],
                                                  isoCode: myLeadsList[index]
                                                      ["isoCode"],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: TextButton(
                                          onPressed: () {
                                            Dialog dialog = Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                              ),
                                              child: customConfirmDialog(
                                                title: "Delete Lead",
                                                subtitle:
                                                    "Do you really want to delete lead ?",
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                  size: 70,
                                                ),
                                                onYesPressed: () {
                                                  Navigator.pop(context);
                                                  setState(() async {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection("Users")
                                                        .doc(user.email)
                                                        .update({
                                                      "myLeads": FieldValue
                                                          .arrayRemove([
                                                        myLeadsList[index]
                                                      ])
                                                    });
                                                  });
                                                },
                                              ),
                                            );
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return dialog;
                                                });
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentify/authentication/firebase_auth_service.dart';
import 'package:rentify/generic_classes/countryPhone.dart';
import 'package:rentify/generic_classes/customDialogs.dart';
import 'package:rentify/generic_classes/inputWithIcon.dart';
import 'package:rentify/generic_classes/primaryButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddLeads extends StatefulWidget {
  @override
  _AddLeadsState createState() => _AddLeadsState();
}

class _AddLeadsState extends State<AddLeads> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? isoCode = "GB";
  String? phoneCode = "44";

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController property = TextEditingController();
  TextEditingController mobileNo = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    email.dispose();
    property.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add Lead Info"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Image.asset(
                    "assets/images/addLeads.jpg",
                    fit: BoxFit.fitWidth,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                InputWithIcon(
                  btnIcon: Icons.person,
                  hintText: "Name",
                  myController: name,
                  onChange: (String value) {},
                  keyboardType: TextInputType.name,
                  validateFunc: (value) {
                    if (value!.isEmpty) {
                      return "Please mention name!";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                InputWithIcon(
                  btnIcon: Icons.email_outlined,
                  hintText: "Email",
                  myController: email,
                  onChange: (String value) {},
                  validateFunc: (value) {
                    if (value!.isEmpty) {
                      return "Email  is Required";
                    } else if (!value.contains(RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                      return "Enter valid email address";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CountryPhone(
                  onIsoChange: (phCode, iSOCode) {
                    setState(() {
                      phoneCode = phCode;
                      isoCode = iSOCode;
                    });
                  },
                  phoneController: mobileNo,
                ),
                SizedBox(height: 20),
                InputWithIcon(
                  btnIcon: Icons.business,
                  hintText: "Property name",
                  myController: property,
                  onChange: (String value) {},
                  keyboardType: TextInputType.multiline,
                  validateFunc: (value) {
                    if (value!.isEmpty) {
                      return "Please mention property name!";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                PrimaryButton(
                    btnText: 'Add Lead',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> lead = {
                          "name": name.text,
                          "email": email.text,
                          "phone": mobileNo.text,
                          "isoCode": isoCode,
                          "phoneCode": phoneCode,
                          "property": property.text,
                          "isConverted": false
                        };
                        var user = Provider.of<FirebaseAuthService>(context,
                                listen: false)
                            .currentUser();
                        await FirebaseFirestore.instance
                            .collection("Users")
                            .doc(user!.email)
                            .update({
                          "myLeads": FieldValue.arrayUnion([lead]),
                        });
                        Dialog dialog = Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: customOkDialog(
                              title: "Success !",
                              subtitle: "Successfully Added",
                              icon: Icon(
                                Icons.check_circle_outline,
                                size: 70,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.popAndPushNamed(context, "/myLeads");
                              },
                            ));
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return dialog;
                          },
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

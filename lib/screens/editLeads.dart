import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentify/generic_classes/countryPhone.dart';
import 'package:rentify/generic_classes/customDialogs.dart';
import 'package:rentify/generic_classes/inputWithIcon.dart';
import 'package:rentify/generic_classes/primaryButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditLead extends StatefulWidget {
  final String? name;
  final String? phone;
  final String? email;
  final String? property;
  final String? isoCode;
  final dynamic index;

  EditLead(
      {this.email,
      this.property,
      this.name,
      this.phone,
      this.index,
      this.isoCode});
  @override
  _EditLeadState createState() => _EditLeadState();
}

TextEditingController name = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController property = TextEditingController();
TextEditingController mobileNo = TextEditingController();

// ignore: camel_case_types
class _EditLeadState extends State<EditLead> {
  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.name);
    email = TextEditingController(text: widget.email);
    property = TextEditingController(text: widget.property);
    mobileNo = TextEditingController(text: widget.phone);
  }

  String? isoCode = "GB";
  String? phoneCode = "44";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Edit Lead"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    child: Image.asset(
                      "assets/images/editLeads.jpg",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
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
                  initialIsoCode: widget.isoCode,
                  phoneController: mobileNo,
                  onIsoChange: (phCode, iSOCode) {
                    setState(() {
                      phoneCode = phCode;
                      isoCode = iSOCode;
                    });
                  },
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
                    btnText: 'Update Lead',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> lead = {
                          "name": name.text,
                          "email": email.text,
                          "phone": mobileNo.text,
                          "isoCode": isoCode,
                          "phoneCode": phoneCode,
                          "property": property.text,
                        };
                        var user = FirebaseAuth.instance.currentUser;
                        FirebaseFirestore.instance
                            .collection("Users")
                            .doc(user!.email)
                            .update({
                          "myLeads": FieldValue.arrayRemove([widget.index]),
                        }).then((value) => FirebaseFirestore.instance
                                    .collection("Users")
                                    .doc(user.email)
                                    .update({
                                  "myLeads": FieldValue.arrayUnion([lead]),
                                }));
                        Dialog dialog = Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: customOkDialog(
                              title: "Success !",
                              subtitle: "Successfully updated!",
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

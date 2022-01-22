import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentify/authentication/firebase_auth_service.dart';
import 'package:rentify/generic_classes/countryPhone.dart';
import 'package:rentify/generic_classes/customDialogs.dart';
import 'package:rentify/generic_classes/inputWithIcon.dart';
import 'package:rentify/generic_classes/primaryButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookAppointment extends StatefulWidget {
  final String? propertyName;
  BookAppointment({this.propertyName});

  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  bool dialogShown = false;
  String? isoCode = "GB";
  String? phoneCode = "44";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    name.dispose();
    emailId.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseAuthService>(context).currentUser();
    var userData = Provider.of<Map<String, dynamic>?>(context, listen: false);

    if (user != null) {
      name = TextEditingController(text: user.displayName);
      emailId = TextEditingController(text: user.email);
      mobileNo = TextEditingController(text: userData!["phone"]);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Book an appointment"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      child: Image.asset(
                        "assets/images/contactUs.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SizedBox(height: 20),
                    InputWithIcon(
                      btnIcon: Icons.person,
                      hintText: "Name",
                      myController: name,
                      onChange: (String value) {},
                      keyboardType: TextInputType.name,
                      validateFunc: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your name!";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    InputWithIcon(
                      // initialValue: user.email,
                      btnIcon: Icons.email_outlined,
                      hintText: "Email",
                      myController: emailId,
                      onChange: (String value) {},
                      validateFunc: (value) {
                        if (value!.isEmpty) {
                          return "Email Required";
                        } else if (!value.contains(RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                          return "Enter valid email address";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CountryPhone(
                      phoneController: mobileNo,
                      onIsoChange: (phCode, iSOCode) {
                        setState(() {
                          phoneCode = phCode;
                          isoCode = iSOCode;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade300, width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 60,
                            child: Icon(
                              Icons.business,
                              size: 20,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              child: Text(
                                widget.propertyName!,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PrimaryButton(
                      btnText: 'Book Now',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Dialog dialog = Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0)),
                            child: customConfirmDialog(
                              icon: Icon(
                                Icons.query_builder_sharp,
                                color: Colors.white,
                                size: 70,
                              ),
                              title: "Confirm ?",
                              subtitle:
                                  "Are you sure to book appointment for ${widget.propertyName}",
                              onYesPressed: () {
                                FirebaseFirestore.instance
                                    .collection("Appointments")
                                    .add({
                                  "name": name.text,
                                  "email": emailId.text,
                                  "phone": mobileNo.text,
                                  "isoCode": isoCode,
                                  "phoneCode": phoneCode,
                                  "propertyName": widget.propertyName,
                                  "date": DateTime.now(),
                                });
                                Navigator.of(context).pop();
                                Dialog sucDialog = Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0)),
                                  child: customOkDialog(
                                    icon: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 70,
                                    ),
                                    title: "Success",
                                    subtitle:
                                        "Successfully Booked Appointment For ${widget.propertyName}",
                                    onPressed: () {
                                      Navigator.popAndPushNamed(
                                          context, "/home");
                                    },
                                  ),
                                );
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return sucDialog;
                                    });
                              },
                            ),
                          );

                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return dialog;
                              });
                        }
                        //Send to API
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

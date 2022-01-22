import 'package:ebloffices/generic_classes/ourServiceCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OurServices extends StatefulWidget {
  @override
  _OurServicesState createState() => _OurServicesState();
}

class _OurServicesState extends State<OurServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Our Services"),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 1,
        padding: EdgeInsets.all(20),
        crossAxisSpacing: 5,
        mainAxisSpacing: 10,
        children: [
          OurServiceCard(
              serviceImage:
                  "https://res.cloudinary.com/ebl-offices/image/upload/v1626255303/our_services/s1_bad2ns.jpg",
              serviceName: "Property Management"),
          OurServiceCard(
              serviceImage:
                  "https://res.cloudinary.com/ebl-offices/image/upload/v1626255304/our_services/s2_rmqlpw.jpg",
              serviceName: "Capital Improvements"),
          OurServiceCard(
              serviceImage:
                  "https://res.cloudinary.com/ebl-offices/image/upload/v1626255295/our_services/s3_m464w2.jpg",
              serviceName: "Finance Real Estate"),
          OurServiceCard(
              serviceImage:
                  "https://res.cloudinary.com/ebl-offices/image/upload/v1626255294/our_services/s4_yx81a5.jpg",
              serviceName: "Recover Asset Value"),
          OurServiceCard(
              serviceImage:
                  "https://res.cloudinary.com/ebl-offices/image/upload/v1626255297/our_services/s5_oxykhc.jpg",
              serviceName: "Financial Reporting"),
          OurServiceCard(
              serviceImage:
                  "https://res.cloudinary.com/ebl-offices/image/upload/v1626255296/our_services/s6_corrkm.jpg",
              serviceName: "Business Development"),
        ],
      ),
    );
  }
}

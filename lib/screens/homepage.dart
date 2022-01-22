import 'package:rentify/generic_classes/primaryButton.dart';
import 'package:rentify/generic_classes/propertyCardVertical.dart';
import 'package:rentify/screens/aboutAgents.dart';
import 'package:rentify/screens/ourServices.dart';
import 'package:rentify/screens/searchedProperties.dart';
import 'package:rentify/screens/sideBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchCity = "All cities";
  String _searchType = "All types";
  int? _minPrice;
  int? _maxPrice;

  @override
  Widget build(BuildContext context) {
    List a = [
      "https://res.cloudinary.com/ebl-offices/image/upload/v1625663460/partners/mainYard_abaaqv.png",
      "https://res.cloudinary.com/ebl-offices/image/upload/v1625663472/partners/coccon_xuezw1.png",
      "https://res.cloudinary.com/ebl-offices/image/upload/v1625663453/partners/regent_mfxi4i.jpg",
      "https://res.cloudinary.com/ebl-offices/image/upload/v1625663447/partners/regus_sdorgj.png",
      "https://res.cloudinary.com/ebl-offices/image/upload/v1625663442/partners/servcorp_isgcu1.png",
      "https://res.cloudinary.com/ebl-offices/image/upload/v1625663436/partners/techspace_vbo6sz.jpg",
      "https://res.cloudinary.com/ebl-offices/image/upload/v1625663427/partners/tog_wfcxt0.png",
      "https://res.cloudinary.com/ebl-offices/image/upload/v1625663423/partners/wework_zx1btd.jpg",
    ];

    var propList = Provider.of<List<Map<String, dynamic>>?>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("EBL Offices"),
        centerTitle: true,
        brightness: Brightness.dark,
      ),
      backgroundColor: Colors.white,
      drawer: NavDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: WaveClipper(),
              child: Image.asset(
                "assets/images/homePage.jpeg",
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(15.0),
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                    child: DropdownButton<String>(
                      value: _searchCity,
                      isExpanded: true,
                      onChanged: (String? value) {
                        setState(() {
                          _searchCity = value!;
                        });
                      },
                      items: <String>["All cities", "Birmingham", "London", "Manchester"].map<DropdownMenuItem<String>>((city) {
                        return DropdownMenuItem(
                          child: Text(city),
                          value: city,
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                    child: DropdownButton<String>(
                      value: _searchType,
                      isExpanded: true,
                      onChanged: (String? value) {
                        setState(() {
                          _searchType = value!;
                        });
                      },
                      items: <String>["All types", "Coworking", "Meeting Rooms", "Office Space", "Virtual Offices"]
                          .map<DropdownMenuItem<String>>((city) {
                        return DropdownMenuItem(
                          child: Text(city),
                          value: city,
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _minPrice != null ? "£$_minPrice" : "Min Price",
                            onChanged: (String? value) {
                              if (value != null) {
                                if (value == "Min Price")
                                  setState(() {
                                    _minPrice = null;
                                  });
                                else
                                  setState(() {
                                    _minPrice = int.parse(value.replaceAll(RegExp('[^0-9]'), ''));
                                  });
                              }
                            },
                            hint: Text("Min price"),
                            items: <String>["Min Price", "£50", "£100", "£500", "£1000", "£5000", "£10000", "£20000", "£30000"]
                                .map<DropdownMenuItem<String>>((city) {
                              return DropdownMenuItem(
                                child: Text(city),
                                value: city,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _maxPrice != null ? "£$_maxPrice" : "Max Price",
                            onChanged: (String? value) {
                              if (value != null) {
                                if (value == "Max Price")
                                  setState(() {
                                    _maxPrice = null;
                                  });
                                else
                                  setState(() {
                                    _maxPrice = int.parse(value.replaceAll(RegExp('[^0-9]'), ''));
                                  });
                              }
                            },
                            hint: Text("Max price"),
                            items: <String>["Max Price", "£50", "£100", "£500", "£1000", "£5000", "£10000", "£20000", "£30000"]
                                .map<DropdownMenuItem<String>>((city) {
                              return DropdownMenuItem(
                                child: Text(city),
                                value: city,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          child: Text("Search"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchedPropertiesPage(
                                          minPrice: _minPrice,
                                          searchType: _searchType,
                                          searchCity: _searchCity,
                                          maxPrice: _maxPrice,
                                        )));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (propList?.length != 0)
              Column(
                children: [
                  Text(
                    'Featured Properties',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,

              ///
              itemCount: propList!.length,
              itemBuilder: (context, index) {
                return PropertyCardVertical(
                  property: propList[index],
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Our Services',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Explore all of our services. Click below to check various services we provide.',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.justify,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: PrimaryButton(
                        btnText: "Our Services",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OurServices(),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Meet Our Agents',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'EBL Office Spaces is made up of a team of people who are committed to working hard '
                    'and reducing your troubles in finding the right office space.',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.justify,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: PrimaryButton(
                        btnText: "Meet Our Team",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutAgents(),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'Our Partners',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    SizedBox(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: Scrollbar(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext ctx, int index) {
                            return Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                  Image.network(
                                    a[index],
                                    height: 125,
                                    width: 125,
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: a.length,
                        ),
                      ),
                    ),
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

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    final lowPoint = size.height - 20;
    final highPoint = size.height - 60;
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 6, highPoint, size.width / 2, lowPoint);
    path.quadraticBezierTo(3 / 4 * size.width, size.height, size.width, lowPoint);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

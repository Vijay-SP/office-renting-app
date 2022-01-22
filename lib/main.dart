import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebloffices/authentication/firebase_auth_service.dart';
import 'package:ebloffices/generic_classes/theme.dart';
import 'package:ebloffices/screens/aboutUs.dart';
import 'package:ebloffices/screens/addLeads.dart';
import 'package:ebloffices/screens/contactUs.dart';
import 'package:ebloffices/screens/favourites.dart';
import 'package:ebloffices/screens/homepage.dart';
import 'package:ebloffices/screens/loginPage.dart';
import 'package:ebloffices/screens/myLeads.dart';
import 'package:ebloffices/screens/myProfileScreen.dart';
import 'package:ebloffices/screens/ourServices.dart';
import 'package:ebloffices/screens/propertiesPage.dart';
import 'package:ebloffices/screens/setProfilePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(create: (_) => FirebaseAuthService()),
        FutureProvider<bool>(
          create: (context) => FirebaseAuthService().isBroker(),
          initialData: false,
        ),
        FutureProvider<Map<String, dynamic>?>(
          create: (context) async {
            var user = Provider.of<FirebaseAuthService>(context, listen: false)
                .currentUser();
            var userDoc = await FirebaseFirestore.instance
                .collection("Users")
                .doc(user!.email)
                .get();
            return userDoc.data();
          },
          initialData: {},
        ),
        FutureProvider<List<Map<String, dynamic>>?>(
          create: (context) async {
            var snapshot = await FirebaseFirestore.instance
                .collection('Properties')
                .where("isFeatured", isEqualTo: true)
                .get();
            final List<Map<String, dynamic>> propList =
                snapshot.docs.map((doc) {
              var data = doc.data();
              data["id"] = doc.id;
              return data;
            }).toList();
            return propList;
          },
          initialData: [],
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EBL Offices',
        theme: basicTheme(),
        home: HomePage(),
        routes: {
          "/home": (context) => HomePage(),
          "/auth": (context) => LoginPage(),
          "/setProfile": (context) => SetProfilePage(),
          "/myProfile": (context) => MyProfileScreen(),
          "/addLeads": (context) => AddLeads(),
          "/about": (context) => AboutUs(),
          "/contact": (context) => ContactScreen(),
          "/services": (context) => OurServices(),
          "/myLeads": (context) => MyLeads(),
          "/properties": (context) => PropertiesPage(),
          "/myFavourites": (context) => WishlistPage(),
        },
      ),
    );
  }
}

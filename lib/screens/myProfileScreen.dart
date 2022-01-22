import 'package:rentify/authentication/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseAuthService>(context).currentUser();
    final authUser = Provider.of<FirebaseAuthService>(context).getCurrentUser();
    var userData = Provider.of<Map<String, dynamic>?>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      body: Stack(
        children: <Widget>[
          ClipPath(
            child: Container(color: Theme.of(context).primaryColor),
            clipper: ProfileClipper(),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
              child: Column(
                children: <Widget>[
                  user != null
                      ? CircleAvatar(
                          radius: 75,
                          child: ClipOval(
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    user.photoUrl ??
                                        "https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          child: Text("PLease Login"),
                        ),
                  SizedBox(height: 30.0),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius. circular(20),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    color: Colors.white60,
                    child: ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.user,
                        color:Theme.of(context).primaryColor ,
                      ),
                      title: Text(
                        user!.displayName ?? '',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius. circular(20),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    color: Colors.white60,
                    child: ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.envelope,
                        color:Theme.of(context).primaryColor ,
                      ),
                      title: Text(
                        user.email ?? '',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius. circular(20),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    color: Colors.white60,
                    child: ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.phoneAlt,
                        color:Theme.of(context).primaryColor ,
                      ),
                      title: Text(
                        userData!["phone"] ?? "Fetching phone no.",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 50.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: Text(
                        "Logout",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                      onPressed: () {
                        try {
                          authUser.signOutUser();
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/", (Route<dynamic> route) => false);
                        } catch (e) {
                          print(e);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Logout Error"),
                                content: Text(
                                    "Some error occurred!\nYou are still logged In"),
                                actions: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 10, 15, 10),
                                    // ignore: deprecated_member_use
                                    child: FlatButton(
                                      child: Text("Try Again"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Once you Logout, you won't be able to use some of the features, You have to Login again to continue with the app.",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height / 4);
    path.lineTo(size.width + 200, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

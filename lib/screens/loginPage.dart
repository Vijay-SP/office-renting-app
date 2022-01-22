import 'dart:ui';
import 'package:rentify/authentication/firebase_auth_service.dart';
import 'package:rentify/generic_classes/inputWithIcon.dart';
import 'package:rentify/generic_classes/outlineButton.dart';
import 'package:rentify/generic_classes/primaryButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Declaring Necessary Variables
  int _pageState = 0;
  bool forgetPassClick = false;
  final loginFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();
  final nameController = TextEditingController();

  var _backgroundColor = Color(0xFFBFEEFEC);
  var _headingColor = Color(0xFFB1E4155);
  var _arrowColor = Color(0xFFBFEEFEC);

  bool _isLoading = false;

  double _headingTop = 120;
  double _loginYOffset = 0;
  double _registerYOffset = 0;

  double windowWidth = 0;
  double windowHeight = 0;

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Size of the Screen
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    switch (_pageState) {
      case 0:
        _backgroundColor = Color(0xFFFFFFFF);
        _headingColor = Color(0xFF121212);
        _loginYOffset = windowHeight;
        _registerYOffset = windowHeight;
        _headingTop = 60;
        _arrowColor = Color(0xFFFFFFFF);
        break;
      case 1:
        _backgroundColor = Color(0xFF031F4B);
        _headingColor = Colors.white;
        _loginYOffset = 200;
        _registerYOffset = windowHeight;
        _headingTop = 30;
        _arrowColor = Colors.white;
        break;
      case 2:
        _backgroundColor = Color(0xFFB1E4155);
        _headingColor = Colors.white;
        _loginYOffset = 200;
        _registerYOffset = 0;
        _headingTop = 30;
        _arrowColor = Colors.black;
        break;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1000),
            color: _backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        child: SafeArea(
                          child: Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: _arrowColor,
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            if (_pageState == 2) {
                              _pageState = 1;
                            } else {
                              _pageState = 0;
                            }
                          });
                        },
                      ),
                      AnimatedContainer(
                        curve: Curves.fastLinearToSlowEaseIn,
                        duration: Duration(milliseconds: 1000),
                        margin: EdgeInsets.only(top: _headingTop),
                        child: Text(
                          "Rentify",
                          style: TextStyle(
                            color: _headingColor,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 120),
                        child: Text(
                          "Check out the latest Office Spaces",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _headingColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(18),
                        child: Center(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            child: Image.asset(
                              'assets/images/getStarted.jpg',
                              // fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: GestureDetector(
                        child: Container(
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Text(
                              "Get Started",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            if (_pageState != 0) {
                              _pageState = 0;
                            } else {
                              _pageState = 1;
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Login Section
          Form(
            key: loginFormKey,
            child: AnimatedContainer(
              padding: EdgeInsets.all(32),
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 1000),
              transform: Matrix4.translationValues(0, _loginYOffset, 1),
              decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                children: [
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Login To Continue",
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      InputWithIcon(
                        btnIcon: Icons.email_outlined,
                        hintText: "Email",
                        myController: emailController,
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
                      SizedBox(
                        height: 10,
                      ),
                      InputWithIcon(
                        btnIcon: Icons.vpn_key,
                        hintText: "Password",
                        myController: passwordController,
                        obscure: true,
                        keyboardType: TextInputType.visiblePassword,
                        onChange: (String value) {},
                        validateFunc: (value) {
                          if (forgetPassClick) {
                            return null;
                          } else if (value!.isEmpty) {
                            return "Enter Password";
                          } else if (value.length < 6) {
                            return "Password should be atleast 6 characters!";
                          }
                          return null;
                        },
                      ),
                      TextButton(
                        child: Text(
                          'FORGOT PASSWORD?',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            forgetPassClick = true;
                          });
                          if (emailController.text.isEmpty) {
                            Fluttertoast.showToast(
                              msg:
                                  "Enter email and click Forget Password again!",
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                            );
                          } else if (!emailController.text.contains(RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                            Fluttertoast.showToast(
                              msg: "Enter valid email address",
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                            );
                          } else {
                            final authServiceProvider =
                                Provider.of<FirebaseAuthService>(context,
                                    listen: false);
                            await authServiceProvider
                                .sendPasswordResetEmail(emailController.text);
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PrimaryButton(
                        btnText: "Login",
                        onPressed: () async {
                          await validateAndLogin();
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        child: OutlineBtn(
                          imagePath: "assets/images/google_logo.png",
                          btnText: "Sign in with Google",
                        ),
                        onTap: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          final authServiceProvider =
                              Provider.of<FirebaseAuthService>(context,
                                  listen: false);
                          await authServiceProvider.signInWithGoogle(context);
                        },
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // GestureDetector(
                      //   child: OutlineBtn(
                      //     imagePath: "assets/images/apple_logo.png",
                      //     btnText: "Sign in with Apple",
                      //   ),
                      //   onTap: () {},
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      PrimaryButton(
                        btnText: "Create a new account",
                        onPressed: () {
                          setState(() {
                            _pageState = 2;
                            emailController.clear();
                            passwordController.clear();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // SignUp Section
          Form(
            key: signUpFormKey,
            child: AnimatedContainer(
              padding: EdgeInsets.all(32),
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 1000),
              transform: Matrix4.translationValues(0, _registerYOffset, 1),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        child: SafeArea(
                          child: Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: _arrowColor,
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            if (_pageState == 2) {
                              _pageState = 1;
                            } else {
                              _pageState = 0;
                            }
                          });
                        },
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                        child: Text(
                          "Create a New Account",
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  InputWithIcon(
                    btnIcon: Icons.person,
                    hintText: "Name",
                    myController: nameController,
                    onChange: (String value) {},
                    keyboardType: TextInputType.name,
                    validateFunc: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your name!";
                      }
                      return null;
                    },
                  ),
                  InputWithIcon(
                    btnIcon: Icons.email_outlined,
                    hintText: "Email",
                    myController: emailController,
                    onChange: (String value) {},
                    keyboardType: TextInputType.emailAddress,
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
                  InputWithIcon(
                    btnIcon: Icons.vpn_key,
                    hintText: "Password",
                    obscure: true,
                    myController: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    onChange: (String value) {},
                    validateFunc: (value) {
                      if (value!.isEmpty) {
                        return "Enter Password";
                      } else if (value.length < 6) {
                        return "Password should be at least 6 characters!";
                      }
                      return null;
                    },
                  ),
                  InputWithIcon(
                      btnIcon: Icons.vpn_key,
                      hintText: "Confirm Password",
                      obscure: true,
                      myController: confirmPassController,
                      keyboardType: TextInputType.visiblePassword,
                      onChange: (String value) {},
                      validateFunc: (val) {
                        if (val!.isEmpty) return 'Enter Password';
                        if (val != passwordController.text)
                          return 'Passwords do not match!';
                        if (val.isEmpty) return 'Enter Password';
                        if (val != passwordController.text)
                          return 'Passwords do not match!';
                        return null;
                      }),
                  PrimaryButton(
                    btnText: "Create Account",
                    onPressed: () async {
                      await validateAndSignup();
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _pageState = 1;
                        emailController.clear();
                        passwordController.clear();
                      });
                    },
                    child: OutlineBtn(
                      btnText: "Have an account? Login",
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Loading widget
          if (_isLoading)
            Center(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200.withOpacity(0.5)),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
            )
          else
            SizedBox()
        ],
      ),
    );
  }

  // Login function
  Future<void> validateAndLogin() async {
    if (loginFormKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final authServiceProvider =
          Provider.of<FirebaseAuthService>(context, listen: false);

      // Login the user
      var authUser = await authServiceProvider.signInWithEmailPassword(
          emailController.text, passwordController.text);
      setState(() {
        _isLoading = false;
      });
      if (authUser.email != null)
        Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    }
  }

  // Signup function
  Future<void> validateAndSignup() async {
    if (signUpFormKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final authServiceProvider =
          Provider.of<FirebaseAuthService>(context, listen: false);
      // Signup the user
      await authServiceProvider.createUser(
        context,
        emailController.text,
        confirmPassController.text,
        nameController.text,
      );
      setState(() {
        _isLoading = false;
      });
    }
  }
}

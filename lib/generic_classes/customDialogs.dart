import 'package:flutter/material.dart';

// ignore: camel_case_types
class customOkDialog extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final Icon? icon;
  final Function? onPressed;

  customOkDialog({this.icon, this.title, this.subtitle, this.onPressed});

  @override
  _customOkDialogState createState() => _customOkDialogState();
}

// ignore: camel_case_types
class _customOkDialogState extends State<customOkDialog> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Wrap(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    Text(
                      widget.title ?? '',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.subtitle ?? '',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // ignore: deprecated_member_use
                        RaisedButton(
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            "Ok",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            widget.onPressed!();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: -60,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 60,
            child: widget.icon,
          ),
        ),
      ],
    );
  }
}

// ignore: camel_case_types
class customConfirmDialog extends StatefulWidget {
  final void Function()? onYesPressed;
  final String? title;
  final String? subtitle;
  final Icon? icon;

  customConfirmDialog(
      {this.title, this.subtitle, this.icon, this.onYesPressed});

  @override
  _customConfirmDialogState createState() => _customConfirmDialogState();
}

// ignore: camel_case_types
class _customConfirmDialogState extends State<customConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 230,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
            child: Column(
              children: [
                Text(
                  widget.title ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.subtitle ?? '',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ignore: deprecated_member_use
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "Yes",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: widget.onYesPressed,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "No",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
            top: -60,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: 60,
              child: widget.icon,
            )),
      ],
    );
  }
}

// ignore: camel_case_types
class leadDialog extends StatefulWidget {
  final String? name;
  final String? contact;
  final String? email;
  final String? property;
  final bool? isConverted;

  leadDialog(
      {this.email, this.property, this.name, this.contact, this.isConverted});

  @override
  _leadDialogState createState() => _leadDialogState();
}

// ignore: camel_case_types
class _leadDialogState extends State<leadDialog> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Column(
              children: [
                Text(
                  "Lead Data",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                ListTile(
                  title: Text(
                    "Name",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Text(
                    widget.name ?? '',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Property Name",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Text(
                    widget.property ?? '',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Text(
                    widget.email ?? '',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Phone Number",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Text(
                    widget.contact ?? '',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Status",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Text(
                    widget.isConverted == true
                        ? "Congratulations!! Your lead converted Successfully."
                        : "Your lead is not converted yet, Please wait until our agents confirm.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ignore: deprecated_member_use
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "Ok",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

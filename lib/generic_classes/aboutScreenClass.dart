import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:getwidget/getwidget.dart';

//AboutCard class
class AboutCard extends StatefulWidget {
  final String text;
  final String descrip;
  final Image image;
  AboutCard({required this.text, required this.image, required this.descrip});

  @override
  _AboutCardState createState() => _AboutCardState();
}

class _AboutCardState extends State<AboutCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10),
            child: GFAccordion(
              titleChild: Text(
                widget.text,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                textAlign: TextAlign.justify,
              ),
              contentChild: Text(
                widget.descrip,
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
              expandedTitleBackgroundColor: Colors.white,
              collapsedIcon: Icon(
                Icons.keyboard_arrow_down_outlined,
                color: Colors.black38,
              ),
              expandedIcon: Icon(
                Icons.keyboard_arrow_up_outlined,
                color: Colors.black38,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: widget.image,
            ),
          ),
        ],
      ),
    );
  }
}

//AboutAgentCard class
class AboutAgentCard extends StatefulWidget {
  final String image;
  final String agentName;
  final String agentDesign;
  final String agentDesc;
  final void Function() onPressed;

  AboutAgentCard(
      {required this.image,
      required this.agentName,
      required this.agentDesign,
      required this.agentDesc,
      required this.onPressed});
  @override
  _AboutAgentCardState createState() => _AboutAgentCardState();
}

class _AboutAgentCardState extends State<AboutAgentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.white,
        elevation: 60.0,
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          padding: EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.image),
                radius: 80.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                widget.agentName,
                style: TextStyle(
                  color: Color(0xFF03639F),
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                widget.agentDesign,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Center(
                  child: Text(
                    widget.agentDesc,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: widget.onPressed,
                child: Text("View Profile"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//AboutAgentDetailScreen class
class AboutAgentDetailScreen extends StatefulWidget {
  final String agentName;
  final String agentDesig;
  final String agentImage;
  final String agentDescrip;
  AboutAgentDetailScreen(
      {required this.agentName,
      required this.agentDesig,
      required this.agentDescrip,
      required this.agentImage});
  @override
  _AboutAgentDetailScreenState createState() => _AboutAgentDetailScreenState();
}

class _AboutAgentDetailScreenState extends State<AboutAgentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.agentName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 12.0,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(widget.agentImage),
                radius: 130.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                widget.agentName,
                style: TextStyle(
                  color: Color(0xFF03639F),
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                widget.agentDesig,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Divider(
                thickness: 2.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              // ignore: deprecated_member_use
              FlatButton(
                height: 50.0,
                minWidth: 150.0,
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  setState(() {
                    String mail =
                        "mailto:support@ebloffices.com?subject=To EBL Offices&body=Hi EBL Offices Team,";
                    launch(mail);
                  });
                },
                child: Text(
                  "Send Email",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                // ignore: deprecated_member_use
                child: FlatButton(
                  height: 50.0,
                  minWidth: 150.0,
                  onPressed: () {
                    setState(() {
                      String no = "tel:+44 02077121712";
                      launch(no);
                    });
                  },
                  child: Text(
                    "Call Now",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 18.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 3.0,
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "About ${widget.agentName}",
                          style: TextStyle(
                            fontSize: 23.0,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            widget.agentDescrip,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 2.0,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "Find ${widget.agentName} on :",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: FaIcon(
                                        FontAwesomeIcons.facebook,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: FaIcon(
                                        FontAwesomeIcons.instagram,
                                        color: Colors.pink,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: FaIcon(
                                        FontAwesomeIcons.twitter,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: FaIcon(
                                        FontAwesomeIcons.linkedin,
                                        color: Color(0xFF031F4B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:ebloffices/generic_classes/aboutScreenClass.dart';
import 'package:ebloffices/generic_classes/primaryButton.dart';
import 'package:ebloffices/screens/aboutAgents.dart';
import 'package:ebloffices/screens/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: WaveClipper(),
                  child: Opacity(
                    opacity: 0.6,
                    child: Container(
                      height: 400.0,
                      width: width,
                      child: Image(
                        image: AssetImage("assets/images/london.gif"),
                        fit: BoxFit.cover,
                        width: width,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 160),
                            child: Container(
                              child: SizedBox(
                                child: Image.asset(
                                  "assets/images/ebl_blue_logo.png",
                                ),
                                height: 125,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 12.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Text(
                        "The space where your business operates shapes your company’s culture. "
                        "Every firm wants their employees to be comfortable and excited to work at "
                        "their work place and having the right office space helps to attain that. "
                        "It is believed that companies are able to hire quality employees who become "
                        "more productive if they operate in a well-designed space.\n\n"
                        "However, finding a reliable office space at times where every other firm wants to have the best "
                        "option is quite overwhelming. The property market is highly competitive "
                        "and saturated with options therefore it become important to seek advice from "
                        "experts while searching for that perfect working space. This is where we come "
                        "into the picture- to make your life easier by doing the work and research for you.\n ",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    AboutCard(
                      text: "Professional Advice",
                      descrip: "From providing professional advice on the best suitable "
                          "places for you to helping you establish a high functioning, co-working space, "
                          "we at EBL Office Spaces, have you covered. \n\n"
                          "Our innovative, state of the art office "
                          "spaces are developed to accommodate teams of different sizes so that every individual "
                          "gives out his best output at work.\n\n"
                          "We have all kinds of options available for your "
                          "convenience. You can move into ready-to-use spaces or customize the setup and furnishings "
                          "to mirror your business culture. All the catalogued workspaces consist of ergonomic furniture "
                          "and simple, practical décor for optimum corporate functioning. But we know how important it is "
                          "to create a space that feels like your own. We understand the importance of authenticity, "
                          "personalization and creative flow needed to achieve a company’s vision. Therefore we "
                          "take it upon ourselves to give you the best options that will fit right in with your own idea "
                          "of the best work place- a place you can call ‘your office’. \n\n"
                          "Our option of a customized office "
                          "allows you to mould your layout and furniture choices that helps to project "
                          "your unique business and culture on your work space.\n",
                      image: Image(
                        image: AssetImage("assets/images/ab2.jpg"),
                      ),
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
                    Container(
                      width: width,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        gradient: LinearGradient(
                          colors: [Color(0xFF009ffd), Color(0xFF2a2a72)],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Drop your query in the contact box and one of our team members will "
                          "get in touch with you shortly or you can just call us right away. "
                          "We look forward to becoming your go-to agents for everything business space related.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PrimaryButton(
                              btnText: "Contact us",
                              onPressed: () {
                                Navigator.pushNamed(context, "/contact");
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PrimaryButton(
                                btnText: "Our Services",
                                onPressed: () {
                                  Navigator.pushNamed(context, "/services");
                                }),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

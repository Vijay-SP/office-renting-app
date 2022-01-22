import 'package:rentify/generic_classes/aboutScreenClass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutAgents extends StatefulWidget {
  @override
  _AboutAgentsState createState() => _AboutAgentsState();
}

class _AboutAgentsState extends State<AboutAgents> {
  @override
  Widget build(BuildContext context) {
    double height = 420;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Meet Our Team"),
        brightness: Brightness.dark,
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 1,
        padding: EdgeInsets.all(20),
        crossAxisSpacing: 5,
        mainAxisSpacing: 10,
        childAspectRatio: (width / height),
        children: [
          AboutAgentCard(
            image:
                "https://res.cloudinary.com/ebl-offices/image/upload/v1628055292/agents/ankush_tsvm4g.jpg",
            agentName: "Ankush Thakur",
            agentDesign: "Agent",
            agentDesc:
                "A dynamic, powerful and charming personality with experience of working with Regus over 4...",
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    animation = CurvedAnimation(
                        parent: animation, curve: Curves.elasticInOut);
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return AboutAgentDetailScreen(
                      agentName: "Ankush Thakur",
                      agentDesig: "Agent",
                      agentDescrip:
                          "A dynamic, powerful and charming personality with experience "
                          "of working with Regus over 4 years, Ankush understands his clients better "
                          "than anyone else and he will help you to find the best availability that suits "
                          "your budget and requirement.",
                      agentImage:
                          "https://res.cloudinary.com/ebl-offices/image/upload/v1628055292/agents/ankush_tsvm4g.jpg",
                    );
                  },
                ),
              );
            },
          ),
          AboutAgentCard(
            image:
                "https://res.cloudinary.com/ebl-offices/image/upload/v1628055292/agents/faisal_a90dg0.jpg",
            agentName: "Faisal Ayub",
            agentDesign: "Sales Head",
            agentDesc:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut...",
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    animation = CurvedAnimation(
                        parent: animation, curve: Curves.elasticInOut);
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return AboutAgentDetailScreen(
                      agentName: "Faisal Ayub",
                      agentDesig: "Sales Head",
                      agentDescrip:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor "
                          "incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation "
                          "ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                      agentImage:
                          "https://res.cloudinary.com/ebl-offices/image/upload/v1628055292/agents/faisal_a90dg0.jpg",
                    );
                  },
                ),
              );
            },
          ),
          AboutAgentCard(
            image:
                "https://res.cloudinary.com/ebl-offices/image/upload/v1628055292/agents/maceik_v1ma8h.jpg",
            agentName: "Maceik Pogodzik",
            agentDesign: "Agent",
            agentDesc:
                "His experience gained in managing centres for one of the world’s greatest office providers...",
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    animation = CurvedAnimation(
                        parent: animation, curve: Curves.elasticInOut);
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return AboutAgentDetailScreen(
                      agentName: "Maceik Pogodzik",
                      agentDesig: "Agent",
                      agentDescrip:
                          "His experience gained in managing centres for one of the world’s greatest office"
                          " providers motivated him to use his skills and knowledge to taking up a challenge of finding "
                          "the most suited office options for yourselves.\n\nOnce he is finished finding your dreamed office "
                          "he enjoys spending his free time in the kitchen, experimenting on new gourmet dishes and "
                          "pairing some great wine with them.",
                      agentImage:
                          "https://res.cloudinary.com/ebl-offices/image/upload/v1628055292/agents/maceik_v1ma8h.jpg",
                    );
                  },
                ),
              );
            },
          ),
          AboutAgentCard(
            image:
                "https://res.cloudinary.com/ebl-offices/image/upload/v1628055293/agents/rajvir_pce1bf.jpg",
            agentName: "Rajvir Josh",
            agentDesign: "Agent",
            agentDesc:
                "Ambitious Property negotiator within the heart of the city of London. I apply myself...",
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    animation = CurvedAnimation(
                        parent: animation, curve: Curves.elasticInOut);
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return AboutAgentDetailScreen(
                      agentName: "Rajvir Josh",
                      agentDesig: "Agent",
                      agentDescrip:
                          "Ambitious Property negotiator within the heart of the city of London. "
                          "I apply myself to tasks and ensure it’s completion to the clients satisfaction. "
                          "With a client eccentric approach and an extensive knowledge for re-development finance.",
                      agentImage:
                          "https://res.cloudinary.com/ebl-offices/image/upload/v1628055293/agents/rajvir_pce1bf.jpg",
                    );
                  },
                ),
              );
            },
          ),
          AboutAgentCard(
            image:
                "https://res.cloudinary.com/ebl-offices/image/upload/v1628055292/agents/shivani_g2j5zg.jpg",
            agentName: "Shivani Pandey",
            agentDesign: "Agent",
            agentDesc:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed...",
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    animation = CurvedAnimation(
                        parent: animation, curve: Curves.elasticInOut);
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return AboutAgentDetailScreen(
                      agentName: "Shivani Pandey",
                      agentDesig: "Agent",
                      agentDescrip:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent "
                          "libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. "
                          "Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa.",
                      agentImage:
                          "https://res.cloudinary.com/ebl-offices/image/upload/v1628055292/agents/shivani_g2j5zg.jpg",
                    );
                  },
                ),
              );
            },
          ),
          AboutAgentCard(
            image:
                "https://res.cloudinary.com/ebl-offices/image/upload/v1628055292/agents/usama_yr0u6b.jpg",
            agentName: "Usama Babar",
            agentDesign: "Agent",
            agentDesc:
                "Working with dynamic team in EBL Investments doing a fantastic job helping clients with...",
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    animation = CurvedAnimation(
                        parent: animation, curve: Curves.elasticInOut);
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return AboutAgentDetailScreen(
                      agentName: "Usama Babar",
                      agentDesig: "Agent",
                      agentDescrip:
                          "Working with dynamic team in EBL Investments doing a fantastic job helping "
                          "clients with there dream property to come true, I work primarily with overseas market, "
                          "my main need is to reach my customers.",
                      agentImage:
                          "https://res.cloudinary.com/ebl-offices/image/upload/v1628055292/agents/usama_yr0u6b.jpg",
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

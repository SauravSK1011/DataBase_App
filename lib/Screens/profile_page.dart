import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mongoapp/Screens/locationscreen.dart';
import 'package:mongoapp/Screens/login_page.dart';
import 'package:mongoapp/Screens/update.dart';
import 'package:mongoapp/Screens/userprofile.dart';
import 'package:mongoapp/Screens/widgets/header_widget.dart';
import 'package:mongoapp/models/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.user}) : super(key: key);
  final UsersModel user;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var initialindex = 0;
  var currentindex = 0;

  var items = [
    Icon(
      Icons.account_circle,
      color: Colors.white,
    ),
    Icon(Icons.location_on, color: Colors.white),
  ];

  @override
  Widget build(BuildContext context) {
    var screens = [
      UserProfile(
        user: widget.user,
      ),
      LocationScreen(
        user: widget.user,
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor,
              ])),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              top: 16,
              right: 16,
            ),
            child: Stack(
              children: <Widget>[
                InkWell(
                  child: const Icon(Icons.edit),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => UpdatePage(user: widget.user)),
                        (Route<dynamic> route) => false);
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 16,
              right: 16,
            ),
            child: Stack(
              children: <Widget>[
                InkWell(
                  child: const Icon(Icons.logout),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                ),
              ],
            ),
          ),
          
        ],
      ),
      body: screens[currentindex],

      bottomNavigationBar:
          // Container(
          // decoration:  BoxDecoration(
          //         gradient:  LinearGradient(
          //             colors: [
          //               Theme.of(context).primaryColor.withOpacity(0.4),
          //               Theme.of(context).accentColor.withOpacity(0.4),
          //             ],
          //             begin: const FractionalOffset(0.0, 0.0),
          //             end: const FractionalOffset(1.0, 0.0),
          //             stops: [0.0, 1.0],
          //             tileMode: TileMode.clamp
          //         ),
          //       ),
          // child:
          Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
            animationCurve: Curves.bounceOut,
            color: HexColor("#0cbaa6"),
            index: initialindex,
            height: 50,
            buttonBackgroundColor: HexColor("#2f9ebd"),
            backgroundColor: Colors.transparent,
            items: items,
            onTap: (index) {
              setState(() {
                currentindex = index;
              });
            }),
      ),
      // )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mongoapp/Screens/widgets/header_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double _drawerIconSize = 24;
  double _drawerFontSize = 17;
  @override
  Widget build(BuildContext context) {
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
                const Icon(Icons.notifications),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: const Text(
                      '5',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      // body: SingleChildScrollView(
      //   child: Stack(
      //     children: [
      //       Container(
      //         height: 100,
      //         child: HeaderWidget(100, false, Icons.house_rounded),
      //       ),
      //       Container(
      //         alignment: Alignment.center,
      //         margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
      //         padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      //         child: Column(
      //           children: [
      //             Container(
      //               padding: EdgeInsets.all(10),
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(100),
      //                 border: Border.all(width: 5, color: Colors.white),
      //                 color: Colors.white,
      //                 boxShadow: const [
      //                   BoxShadow(
      //                     color: Colors.black12,
      //                     blurRadius: 20,
      //                     offset: Offset(5, 5),
      //                   ),
      //                 ],
      //               ),
      //               child: Icon(
      //                 Icons.person,
      //                 size: 80,
      //                 color: Colors.grey.shade300,
      //               ),
      //             ),
      //             const SizedBox(
      //               height: 20,
      //             ),
      //             const Text(
      //               'Mr. Donald Trump',
      //               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      //             ),
      //             const SizedBox(
      //               height: 20,
      //             ),
      //             const Text(
      //               'Former President',
      //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      //             ),
      //             const SizedBox(
      //               height: 10,
      //             ),
      //             Container(
      //               padding: EdgeInsets.all(10),
      //               child: Column(
      //                 children: <Widget>[
      //                   Container(
      //                     padding:
      //                         const EdgeInsets.only(left: 8.0, bottom: 4.0),
      //                     alignment: Alignment.topLeft,
      //                     child: const Text(
      //                       "User Information",
      //                       style: TextStyle(
      //                         color: Colors.black87,
      //                         fontWeight: FontWeight.w500,
      //                         fontSize: 16,
      //                       ),
      //                       textAlign: TextAlign.left,
      //                     ),
      //                   ),
      //                   Card(
      //                     child: Container(
      //                       alignment: Alignment.topLeft,
      //                       padding: const EdgeInsets.all(15),
      //                       child: Column(
      //                         children: <Widget>[
      //                           Column(
      //                             children: <Widget>[
      //                               ...ListTile.divideTiles(
      //                                 color: Colors.grey,
      //                                 tiles: [
      //                                   const ListTile(
      //                                     leading: Icon(Icons.email),
      //                                     title: Text("Email"),
      //                                     subtitle:
      //                                         Text("donaldtrump@gmail.com"),
      //                                   ),
      //                                   const ListTile(
      //                                     leading: Icon(Icons.phone),
      //                                     title: Text("Phone"),
      //                                     subtitle: Text("99--99876-56"),
      //                                   ),
      //                                 ],
      //                               ),
      //                             ],
      //                           )
      //                         ],
      //                       ),
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             )
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      body: const Center(
        child: Text(
          'Welcome',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

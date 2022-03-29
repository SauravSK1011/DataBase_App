import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mongoapp/Screens/login_page.dart';
import 'package:mongoapp/Screens/registration_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool selected = false;
  bool visible = false;
  @override
  void initState() {
    super.initState();
    settimer2();
    settimer();
  }

  settimer2() async {
    var duration = const Duration(seconds: 1);
    return Timer(duration, settrue);
  }

  settrue() {
    setState(() {
      selected = true;
      visible = true;
    });
  }

  settimer() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, secondpage);
  }

  secondpage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).accentColor,
            Theme.of(context).primaryColor
          ],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnimatedOpacity(
        opacity: visible ? 1.0 : 0,
        duration: Duration(milliseconds: 1200),
        child: Center(
          child: Container(
            height: 140.0,
            width: 140.0,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(150),
                child: Image.asset(
                  "assets/Icon.jpg",
                  fit: BoxFit.fill,
                )),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 2.0,
                    offset: Offset(5.0, 3.0),
                    spreadRadius: 2.0,
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

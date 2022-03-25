import 'package:flutter/material.dart';
import 'package:mongoapp/Screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'MongoApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor:Colors.green
      ),
      home: const SplashScreen(),
    );
  }
}
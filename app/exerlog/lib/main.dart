import 'package:flutter/material.dart';
// import '/UI/login_page.dart';
import 'UI/test.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginForm('0'),
      color: Colors.blue,
    );
  }
}


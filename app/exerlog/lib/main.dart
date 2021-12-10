// @dart = 2.9
import 'package:exerlog/Bloc/user_bloc.dart';
import 'package:exerlog/Bloc/workout_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/workout_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'UI/global.dart';
// import '/UI/login_page.dart';
import 'Models/user.dart';
import 'UI/test.dart';

String userID = "KGjuifVkeop9CFHmTIHU";
UserClass user;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget { 
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: WorkoutPage(),//LoginForm('1'),
            color: Colors.blue,
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );
  }
}


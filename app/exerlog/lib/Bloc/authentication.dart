import 'package:exerlog/Bloc/user_bloc.dart';
import 'package:exerlog/Bloc/workout_bloc.dart';
import 'package:exerlog/Models/user.dart';
import 'package:exerlog/UI/login_screen/login_page.dart';
import 'package:exerlog/UI/workout/workout_page.dart';
import 'package:exerlog/main.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  static Future<FirebaseApp> initializeFirebase({
    required BuildContext context,
  }) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    // FirebaseAuth.instance.currentUser?.delete();
    // User? user;
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      print("USER EXISTS");
      print(user.uid);
      userID = user.uid;
      //replaceWorkouts();
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => WorkoutPage(
      //     ),
      //   ),
      // );
    }

    return firebaseApp;
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = await FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          showDialog(
            context: context,
            builder: ErrorDialog(
              context,
              "A different account exists with the same credentials",
            ),
          );
        } else if (e.code == 'invalid-credential') {
          showDialog(
            context: context,
            builder: ErrorDialog(
              context,
              "Invalid credentials",
            ),
          );
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: ErrorDialog(
            context,
            e.toString(),
          ),
        );
      }
    }
    return user;
  }
}

ErrorDialog(BuildContext context, String error) {
  return AlertDialog(
    title: Text("Error"),
    content: Text(error),
    actions: <Widget>[
      ElevatedButton(onPressed: () => Navigator.pop(context), child: Text("Ok"))
    ],
  );
}

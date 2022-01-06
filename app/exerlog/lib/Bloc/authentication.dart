import 'package:exerlog/Bloc/user_bloc.dart';
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
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      print("USER EXISTS");
      userID = user.uid;
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

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken
      );

      try {
        final UserCredential userCredential = await auth.signInWithCredential(credential);
        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        }
        else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }
    return user;
  }
}
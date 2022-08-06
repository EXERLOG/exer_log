import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Models/user.dart';
import '../core/error_handling/error.dart';
import 'user_bloc.dart';

class EmailSignup {
  static Future<Either<User?, ErrorModel>> registerWithEmail(
      String email, String password) async {
    FirebaseAuth auth = await FirebaseAuth.instance;
    User? user;
    try {
      user = (await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      if (user != null) {
        createUser(
            new UserClass('', 0, 0, 0, email, '', '', 'metric', ''), user.uid);
      }
      return Left(user);
    } on FirebaseAuthException catch (e) {
      String? errorMessage;
      if (e.code == "ERROR_EMAIL_ALREADY_IN_USE" ||
          e.code == "account-exists-with-different-credential" ||
          e.code == "email-already-in-use") {
        errorMessage = "Email already in use";
      }
      return Right(ErrorModel(
          code: e.code, errorMessage: errorMessage ?? e.message.toString()));
    } catch (e) {
      return Right(ErrorModel(errorMessage: e.toString()));
    }
  }

  static Future<Either<User?, ErrorModel>> signInWithEmailAndPassword(
      String email, String password) async {
    FirebaseAuth auth = await FirebaseAuth.instance;
    User? user;

    try {
      user = (await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      if (user != null) {
        createUser(
            new UserClass('', 0, 0, 0, email, '', '', 'metric', ''), user.uid);
      }
      return Left(user);
    } on FirebaseAuthException catch (e) {
      String? errorMessage;
      if (e.code == "ERROR_USER_NOT_FOUND" || e.code == "user-not-found") {
        errorMessage = "No user found with this email.";
      } else if (e.code == "ERROR_WRONG_PASSWORD" ||
          e.code == "wrong-password") {
        errorMessage = "Enter correct password";
      }
      return Right(ErrorModel(
          code: e.code, errorMessage: errorMessage ?? e.message.toString()));
    } catch (e) {
      return Right(ErrorModel(errorMessage: e.toString()));
    }
  }
}

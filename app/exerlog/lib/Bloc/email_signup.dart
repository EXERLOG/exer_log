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
      return Right(
          ErrorModel(code: e.code, errorMessage: e.message.toString()));
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
      return Right(
          ErrorModel(code: e.code, errorMessage: e.message.toString()));
    } catch (e) {
      return Right(ErrorModel(errorMessage: e.toString()));
    }
  }
}

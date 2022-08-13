
import 'package:exerlog/Bloc/authentication.dart';
import 'package:exerlog/Bloc/user_bloc.dart';
import 'package:exerlog/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailSignup {
  static Future<User?> registerWithEmail(String email, String password) async {
    FirebaseAuth auth = await FirebaseAuth.instance;
    User? user;
    user = (await 
        auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
    ).user;
    if (user != null) {
      createUser(new UserClass('', 0, 0, 0, email, '', '', 'metric', ''), user.uid);
    }
    return user;
  }

  static Future<User?> signInWithEmailAndPassword(String email, String password) async {
    FirebaseAuth auth = await FirebaseAuth.instance;
    User? user;
    user = (await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    )).user;
    if (user != null) {
      createUser(new UserClass('', 0, 0, 0, email, '', '', 'metric', ''), user.uid);
    }
    return user;
  }
}
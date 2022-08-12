import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class Dependency {
  static Provider<FirebaseAuth> get firebaseAuth => _firebaseAuthProvider;
  static Provider<GoogleSignIn?> get googleSignIn => _googleSignInProvider;
}

final _firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final _googleSignInProvider = Provider<GoogleSignIn?>((ref) {
  return GoogleSignIn();
});
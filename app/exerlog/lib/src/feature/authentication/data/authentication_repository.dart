import 'package:exerlog/src/dependency.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final _authRepoProvider = Provider((ref) => AuthenticationRepository(ref.read));

class AuthenticationRepository {
  AuthenticationRepository(this.reader) {
    _firebaseAuth = reader(Dependency.firebaseAuth);
  }

  final Reader reader;
  late FirebaseAuth _firebaseAuth;

  static Provider<AuthenticationRepository> get provider => _authRepoProvider;

  Future signIn({required String email, password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signUp({required String email, password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signInWithGoogle() async {
    if (kIsWeb) {
      final GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      await _firebaseAuth.signInWithRedirect(googleAuthProvider);
    } else {
      final GoogleSignInAccount? googleUser =
          await reader(Dependency.googleSignIn)?.signIn();

      final GoogleSignInAuthentication? googleSignInAuth =
          await googleUser?.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth?.accessToken,
        idToken: googleSignInAuth?.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
    }
  }

  Future<void> signOut() async {
    await reader(Dependency.googleSignIn)?.signOut();
    await _firebaseAuth.signOut();
  }
}

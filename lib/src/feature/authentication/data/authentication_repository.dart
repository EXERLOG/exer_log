import 'package:exerlog/src/dependency.dart';
import 'package:exerlog/src/exceptions/firebase_exceptions.dart';
import 'package:exerlog/src/utils/logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';

final _authRepoProvider = Provider((ref) {
  final firebaseAuth = ref.watch(Dependency.firebaseAuth);
  final googleSignIn = ref.watch(Dependency.googleSignIn);
  return AuthenticationRepository(firebaseAuth, googleSignIn);
});

class AuthenticationRepository {
  AuthenticationRepository(this._firebaseAuth, this._googleSignIn);

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  static Provider<AuthenticationRepository> get provider => _authRepoProvider;

  TaskEither<FirebaseApiException, User> signUp({
    required String email,
    required String password,
  }) {
    return TaskEither.tryCatch(
      () async {
        await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return _getCurrentUserOrThrow();
      },
      (error, stackTrace) => _handleFirebaseAuthException(error),
    );
  }

  TaskEither<FirebaseApiException, User> signIn({
    required String email,
    required String password,
  }) {
    return TaskEither.tryCatch(
      () async {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return _getCurrentUserOrThrow();
      },
      (error, stackTrace) => _handleFirebaseAuthException(error),
    );
  }

  TaskEither<FirebaseApiException, User> signInWithGoogle() {
    return TaskEither.tryCatch(
      () async {
        if (kIsWeb) {
          final GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
          await _firebaseAuth.signInWithRedirect(googleAuthProvider);
        } else {
          final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
          final GoogleSignInAuthentication? googleSignInAuth =
              await googleUser?.authentication;
          final OAuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuth?.accessToken,
            idToken: googleSignInAuth?.idToken,
          );
          await _firebaseAuth.signInWithCredential(credential);
        }
        return _getCurrentUserOrThrow();
      },
      (error, stackTrace) => _handleFirebaseAuthException(error),
    );
  }

  User _getCurrentUserOrThrow() {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return user;
    } else {
      throw AuthException(message: 'user is null');
    }
  }

  AuthException _handleFirebaseAuthException(Object error) {
    if (error is FirebaseAuthException) {
      final firebaseError = error;
      return AuthException(errorCode: firebaseError.code);
    } else {
      return AuthException(message: error.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
    } catch (e) {
      Log.error(e.toString());
    }
  }
}

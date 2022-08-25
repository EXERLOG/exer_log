import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class Dependency {
  static Provider<FirebaseAuth> get firebaseAuth => _firebaseAuthProvider;

  static Provider<GoogleSignIn?> get googleSignIn => _googleSignInProvider;

  static StreamProvider<ConnectivityResult> get connectivityResult =>
      _onConnectivityChangedStreamProvider;
}

final _firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final _googleSignInProvider = Provider<GoogleSignIn?>((ref) {
  return GoogleSignIn();
});

/// Connectivity
final _connectivityProvider = Provider<Connectivity>((ref) {
  return Connectivity();
});

final _onConnectivityChangedStreamProvider =
    StreamProvider<ConnectivityResult>((ref) {
  return ref.read(_connectivityProvider).onConnectivityChanged;
});

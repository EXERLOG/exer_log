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

final Provider<FirebaseAuth> _firebaseAuthProvider =
    Provider<FirebaseAuth>((ProviderRef<FirebaseAuth> ref) => FirebaseAuth.instance);

final Provider<GoogleSignIn?> _googleSignInProvider = Provider<GoogleSignIn?>((ProviderRef<GoogleSignIn?> ref) => GoogleSignIn());

/// Connectivity
final Provider<Connectivity> _connectivityProvider = Provider<Connectivity>((ProviderRef<Connectivity> ref) => Connectivity());

final StreamProvider<ConnectivityResult> _onConnectivityChangedStreamProvider = StreamProvider<ConnectivityResult>(
    (StreamProviderRef<ConnectivityResult> ref) => ref.read(_connectivityProvider).onConnectivityChanged,);

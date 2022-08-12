import 'package:exerlog/src/core/base/base_state.dart';
import 'package:exerlog/src/core/base/constants/shared_pref_key.dart';
import 'package:exerlog/src/core/base/shared_pref_wrapper.dart';
import 'package:exerlog/src/dependency.dart';
import 'package:exerlog/src/feature/authentication/data/authentication_repository.dart';
import 'package:exerlog/src/utils/logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateProvider = StreamProvider<User?>(
  (ref) => ref.watch(Dependency.firebaseAuth).authStateChanges(),
);

final authenticationProvider = StateNotifierProvider(
  (ref) => AuthenticationController(ref: ref),
);

class AuthenticationController extends StateNotifier<BaseState> {
  AuthenticationController({this.ref}) : super(InitialState()) {
    _repository = ref!.watch(AuthenticationRepository.provider);
  }

  final Ref? ref;
  late AuthenticationRepository _repository;
  late User user;

  static StateNotifierProvider<AuthenticationController, dynamic>
      get controller => authenticationProvider;

  Future<void> signIn({required String email, password}) async {
    try {
      state = LoadingState();
      await _repository.signIn(email: email, password: password);
      authStateChangeStatus();
    } on FirebaseAuthException catch (e) {
      state = ErrorState(message: e.message);
    }
  }

  Future<void> signUp({required String email, password}) async {
    try {
      state = LoadingState();
      await _repository.signUp(email: email, password: password);
      authStateChangeStatus();
    } on FirebaseAuthException catch (e) {
      Log.error(e.code);
      Log.error(e.message);
      state = ErrorState(message: e.message);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      state = LoadingState();
      await _repository.signInWithGoogle();
      authStateChangeStatus();
    } on FirebaseAuthException catch (e) {
      Log.error(e.code);
      Log.error(e.message);
      state = ErrorState(message: e.message);
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      state = ErrorState(message: "Something went wrong");
    }
  }

  void authStateChangeStatus() {
    ref!.read(authStateProvider).whenData(
      (user) {
        if (user != null) {
          this.user = user;
          try {
            setValue(USER_UID, this.user.uid);
            print(this.user.uid);
          } catch (e, stackTrace) {
            Log.error(e.toString());
            Log.error(stackTrace.toString());
            state = ErrorState(message: e.toString());
          }
          return state = SuccessState();
        } else {
          state = ErrorState(message: "Something went wrong");
        }
      },
    );
  }

  Future<void> signOut() async => await _repository.signOut();
}

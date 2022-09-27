import 'package:exerlog/src/core/base/base_state.dart';
import 'package:exerlog/src/core/base/shared_preference/shared_preference_b.dart';
import 'package:exerlog/src/dependency.dart';
import 'package:exerlog/src/feature/authentication/data/authentication_repository.dart';
import 'package:exerlog/src/utils/logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AutoDisposeStateNotifierProvider<AuthenticationController, BaseState> _authenticationProvider =
    StateNotifierProvider.autoDispose<AuthenticationController, BaseState>(
  (AutoDisposeStateNotifierProviderRef<AuthenticationController, BaseState> ref) => AuthenticationController(ref: ref),
);

class AuthenticationController extends StateNotifier<BaseState> {
  AuthenticationController({this.ref}) : super(const InitialState()) {
    _repository = ref!.watch(AuthenticationRepository.provider);
  }

  final Ref? ref;
  late AuthenticationRepository _repository;
  late User user;

  static AutoDisposeStateNotifierProvider<AuthenticationController, BaseState>
      get provider => _authenticationProvider;

  static AutoDisposeProviderBase<AuthenticationController> get controller =>
      _authenticationProvider.notifier;

  Future<void> signIn() async {
    try {
      state = const LoadingState();
      await _repository.signIn(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
      );
      authStateChangeStatus();
    } on FirebaseAuthException catch (e) {
      Log.error(e.code);
      Log.error(e.message);
      state = ErrorState(message: e.message);
    }
  }

  Future<void> signUp() async {
    try {
      state = const LoadingState();
      await _repository.signUp(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
      );
      authStateChangeStatus(isSignUp: true);
    } on FirebaseAuthException catch (e) {
      Log.error(e.code);
      Log.error(e.message);
      state = ErrorState(message: e.message);
    }
  }

  /// TODO: Need to decide if it's signIn / signUp
  Future<void> signInWithGoogle() async {
    try {
      state = const LoadingState();
      await _repository.signInWithGoogle();
      authStateChangeStatus();
    } on FirebaseAuthException catch (exception) {
      Log.error(exception.code);
      Log.error(exception.message);
      state = ErrorState(message: exception.message);
    } catch (exception, stackTrace) {
      Log.error(exception.toString(), stackTrace: stackTrace);

      state = const ErrorState(message: 'Something went wrong');
    }
  }

  Future<void> authStateChangeStatus({bool isSignUp = false}) async {
    User? user = ref!.read(Dependency.firebaseAuth).currentUser;
    if (user != null) {
      this.user = user;

      SharedPref.setValue(USER_UID, this.user.uid);
      SharedPref.setValue(IS_LOGGED_IN, true);

      Log.info(this.user.uid);

      if (isSignUp) {
        state = const SignUpSuccessState();
      } else {
        state = const LoginSuccessState();
      }
    } else {
      state = const ErrorState(message: 'Something went wrong');
    }
  }

  Future<void> signOut() async => await _repository.signOut();

  /// Text Editing Controllers
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  void clearTextFields() {
    emailTextEditingController.clear();
    passwordTextEditingController.clear();
    confirmPasswordTextEditingController.clear();
  }

  bool isSamePassword() =>
      passwordTextEditingController.text ==
      confirmPasswordTextEditingController.text;

  @override
  void dispose() {
    clearTextFields();
    super.dispose();
  }
}

/// States
class LoginSuccessState extends BaseState {
  const LoginSuccessState();
}

class SignUpSuccessState extends BaseState {
  const SignUpSuccessState();
}

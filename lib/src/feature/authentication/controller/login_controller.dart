import 'package:exerlog/src/core/base/shared_preference/shared_pref_key.dart';
import 'package:exerlog/src/core/base/shared_preference/shared_pref_wrapper.dart';
import 'package:exerlog/src/feature/authentication/controller/authentication_state.dart';
import 'package:exerlog/src/feature/authentication/data/authentication_repository.dart';
import 'package:exerlog/src/utils/logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final provideLoginController =
    StateNotifierProvider.autoDispose<LoginController, AuthenticationState>(
        (ref) {
  final repository = ref.watch(AuthenticationRepository.provider);
  return LoginController(repository);
});

class LoginController extends StateNotifier<AuthenticationState> {
  LoginController(this._repository) : super(AuthenticationState.initial());

  final AuthenticationRepository _repository;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    state = AuthenticationState.loading();
    final result = await _repository
        .signIn(
          email: emailController.text,
          password: passwordController.text,
        )
        .run();
    state = result.match(
      (error) => AuthenticationState.error(message: error.toString()),
      (user) => _setUserSignedIn(user),
    );
  }

  void loginWithGoogle() async {
    state = AuthenticationState.loading();
    final result = await _repository.signInWithGoogle().run();
    state = result.match(
      (error) => AuthenticationState.error(message: error.toString()),
      (user) => _setUserSignedIn(user),
    );
  }

  AuthenticationState _setUserSignedIn(User user) {
    Log.info(user.uid);
    SharedPref.setValue(USER_UID, user.uid);
    SharedPref.setValue(IS_LOGGED_IN, true);
    return AuthenticationState.success();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.clear();
    passwordController.clear();
  }
}

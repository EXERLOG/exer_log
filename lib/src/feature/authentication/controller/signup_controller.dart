import 'package:exerlog/src/core/base/shared_preference/shared_pref_wrapper.dart';
import 'package:exerlog/src/feature/authentication/controller/authentication_state.dart';
import 'package:exerlog/src/feature/authentication/data/authentication_repository.dart';
import 'package:exerlog/src/utils/logger/logger.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/base/shared_preference/shared_preference_b.dart';

final provideSignUpController =
    StateNotifierProvider.autoDispose<SignUpController, AuthenticationState>(
        (ref) {
  final repository = ref.watch(AuthenticationRepository.provider);
  return SignUpController(repository);
});

class SignUpController extends StateNotifier<AuthenticationState> {
  SignUpController(this._repository) : super(AuthenticationState.initial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final AuthenticationRepository _repository;

  //TODO Here we probably also want to create the Firestore User (UserBloc)?
  void signUp() async {
    if (!_isSamePassword()) {
      state = AuthenticationState.error(message: 'Passwords should match');
    }
    state = AuthenticationState.loading();
    final result = await _repository
        .signUp(
          email: emailController.text,
          password: passwordController.text,
        )
        .run();
    state = result.match(
      (error) => AuthenticationState.error(message: error.toString()),
      (user) {
        Log.info(user.uid);
        SharedPref.setValue(USER_UID, user.uid);
        SharedPref.setValue(IS_LOGGED_IN, true);
        return AuthenticationState.success();
      },
    );
  }

  bool _isSamePassword() =>
      passwordController.text == confirmPasswordController.text;
}

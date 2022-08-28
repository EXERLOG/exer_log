import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/core/base/extensions/context_extension.dart';
import 'package:exerlog/src/feature/authentication/controller/authentication_state.dart';
import 'package:exerlog/src/feature/authentication/controller/landing_page_button_events.dart';
import 'package:exerlog/src/feature/authentication/controller/login_controller.dart';
import 'package:exerlog/src/feature/authentication/controller/signup_controller.dart';
import 'package:exerlog/src/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LandingPageButton extends ConsumerWidget {
  const LandingPageButton({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(provideLoginController);
    final signUpState = ref.watch(provideSignUpController);
    final buttonNotifier = ref.watch(landingButtonEventsProvider.notifier);
    return RaisedGradientButton(
      width: context.width * .65,
      child: Text(
        index == 0 ? 'Sign In' : 'Sign Up',
        style: buttonText,
      ),
      isLoading: loginState is Loading || signUpState is Loading,
      onPressed: () {
        print('updated state');
        buttonNotifier.state = index == 0
            ? LandingButtonEvents.login
            : LandingButtonEvents.signUp;
        buttonNotifier.state = LandingButtonEvents.none;
      },
    );
  }
}

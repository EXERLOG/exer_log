import 'package:exerlog/UI/workout/workout_page.dart';
import 'package:exerlog/src/core/base/extensions/context_extension.dart';
import 'package:exerlog/src/feature/authentication/controller/authentication_state.dart';
import 'package:exerlog/src/feature/authentication/controller/signup_controller.dart';
import 'package:exerlog/src/feature/authentication/controller/landing_page_button_events.dart';
import 'package:exerlog/src/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../widgets/text_field.dart';

class SignupForm extends HookConsumerWidget {
  SignupForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final controller = ref.watch(provideSignUpController.notifier);
    ref.listen(
      provideSignUpController,
      (_, AuthenticationState state) => state.maybeWhen(
        success: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => WorkoutPage(null))),
        error: (message) => context.showSnackBar(message.toString()),
        orElse: () {},
      ),
    );
    ref.listen(landingButtonEventsProvider, (previous, next) {
      if (next == LandingButtonEvents.signUp) {
        if (formKey.currentState!.validate()) {
          controller.signUp();
        }
      }
    });
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedTextField(
            hinText: "Email",
            leadingIcon: Icons.email,
            validator: (value) => Validators.requiredField(value),
            textEditingController: controller.emailController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
          ),
          OutlinedTextField(
            hinText: "Password",
            leadingIcon: Icons.lock,
            validator: (value) => Validators.requiredField(value),
            textEditingController: controller.passwordController,
            obscureText: true,
            textInputAction: TextInputAction.next,
          ),
          OutlinedTextField(
            hinText: "Repeat Password",
            leadingIcon: Icons.lock,
            validator: (value) => Validators.requiredField(value),
            textEditingController: controller.confirmPasswordController,
            obscureText: true,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}

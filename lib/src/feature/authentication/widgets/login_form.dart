import 'package:exerlog/src/core/base/extensions/context_extension.dart';
import 'package:exerlog/src/feature/authentication/controller/authentication_state.dart';
import 'package:exerlog/src/feature/authentication/controller/login_controller.dart';
import 'package:exerlog/src/feature/authentication/controller/landing_page_button_events.dart';
import 'package:exerlog/src/feature/authentication/widgets/google_signin_button.dart';
import 'package:exerlog/src/feature/calendar/view/calendar_screen.dart';
import 'package:exerlog/src/utils/validators.dart';
import 'package:exerlog/src/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginForm extends HookConsumerWidget {
  const LoginForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final controller = ref.watch(provideLoginController.notifier);
    ref.listen(
      provideLoginController,
      (_, AuthenticationState state) => state.maybeWhen(
        success: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => CalendarScreen())),
        error: (message) => context.showSnackBar(message.toString()),
        orElse: () {},
      ),
    );
    ref.listen(landingButtonEventsProvider, (previous, next) {
      print('should login.. $next');
      if (next == LandingButtonEvents.login) {
        if (formKey.currentState!.validate()) {
          controller.login();
        }
      }
    });
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Spacer(),
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
            textInputAction: TextInputAction.done,
          ),
          Spacer(),
          GoogleSignInButton(onPressed: () => controller.loginWithGoogle())
        ],
      ),
    );
  }
}

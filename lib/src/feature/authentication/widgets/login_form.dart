import 'package:exerlog/src/feature/authentication/controller/authentication_controller.dart';
import 'package:exerlog/src/feature/authentication/widgets/google_signin_button.dart';
import 'package:exerlog/src/utils/validators.dart';
import 'package:exerlog/src/widgets/text_field.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm(this.controller, {Key? key}) : super(key: key);

  final AuthenticationController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Spacer(),
        OutlinedTextField(
          hinText: 'Email',
          leadingIcon: Icons.email,
          validator: (value) => Validators.requiredField(value),
          textEditingController: controller.emailTextEditingController,
        ),
        OutlinedTextField(
          hinText: 'Password',
          leadingIcon: Icons.lock,
          validator: (value) => Validators.requiredField(value),
          textEditingController: controller.passwordTextEditingController,
          obscureText: true,
        ),
        Spacer(),
        GoogleSignInButton(onPressed: controller.signInWithGoogle)
      ],
    );
  }
}

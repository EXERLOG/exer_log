import 'package:exerlog/src/feature/authentication/controller/authentication_controller.dart';
import 'package:exerlog/src/utils/validators.dart';
import 'package:flutter/material.dart';

import '../../../widgets/text_field.dart';

class SignupForm extends StatelessWidget {
  const SignupForm(this.controller, {Key? key}) : super(key: key);

  final AuthenticationController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        OutlinedTextField(
          hinText: 'Email',
          leadingIcon: Icons.email,
          validator: (String? value) => Validators.requiredField(value),
          textEditingController: controller.emailTextEditingController,
        ),
        OutlinedTextField(
          hinText: 'Password',
          leadingIcon: Icons.lock,
          validator: (String? value) => Validators.requiredField(value),
          textEditingController: controller.passwordTextEditingController,
          obscureText: true,
        ),
        OutlinedTextField(
          hinText: 'Repeat Password',
          leadingIcon: Icons.lock,
          validator: (String? value) => Validators.requiredField(value),
          textEditingController:
              controller.confirmPasswordTextEditingController,
          obscureText: true,
        ),
      ],
    );
  }
}

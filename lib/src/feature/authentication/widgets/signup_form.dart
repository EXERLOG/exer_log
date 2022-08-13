import 'package:exerlog/src/feature/authentication/controller/authentication_controller.dart';
import 'package:exerlog/src/utils/validators.dart';
import 'package:flutter/material.dart';

import '../../../widgets/text_field.dart';

class SignupForm extends StatelessWidget {
  SignupForm(this.controller);

  final AuthenticationController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedTextField(
          hinText: "Email",
          leadingIcon: Icons.email,
          validator: (value) => Validators.requiredField(value),
          textEditingController: controller.emailTextEditingController,
        ),
        OutlinedTextField(
          hinText: "Password",
          leadingIcon: Icons.lock,
          validator: (value) => Validators.requiredField(value),
          textEditingController: controller.passwordTextEditingController,
          obscureText: true,
        ),
        OutlinedTextField(
          hinText: "Repeat Password",
          leadingIcon: Icons.lock,
          validator: (value) => Validators.requiredField(value),
          textEditingController:
              controller.confirmPasswordTextEditingController,
          obscureText: true,
        ),
      ],
    );
  }
}

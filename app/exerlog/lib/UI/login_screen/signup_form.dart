import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/feature/authentication/controller/authentication_controller.dart';
import 'package:exerlog/src/utils/validators.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatelessWidget {
  SignupForm(this.controller);

  final AuthenticationController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: EdgeInsets.all(1),
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            border: Border.all(color: greenTextColor),
            borderRadius: BorderRadius.circular(30),
            color: backgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 40,
                child: Icon(
                  Icons.mail,
                  color: greenTextColor,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: TextFormField(
                  controller: controller.emailTextEditingController,
                  validator: (value) => Validators.requiredField(value),
                  style: mediumTitleStyleWhite,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "email",
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(1),
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            border: Border.all(color: greenTextColor),
            borderRadius: BorderRadius.circular(30),
            color: backgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 40,
                child: Icon(
                  Icons.lock,
                  color: greenTextColor,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: TextFormField(
                  controller: controller.passwordTextEditingController,
                  validator: (value) => Validators.requiredField(value),
                  obscureText: true,
                  style: mediumTitleStyleWhite,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "password",
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(1),
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            border: Border.all(color: greenTextColor),
            borderRadius: BorderRadius.circular(30),
            color: backgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 40,
                child: Icon(
                  Icons.lock,
                  color: greenTextColor,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: TextFormField(
                  controller: controller.confirmPasswordTextEditingController,
                  validator: (value) => Validators.requiredField(value),
                  obscureText: true,
                  style: mediumTitleStyleWhite,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "repeat password",
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

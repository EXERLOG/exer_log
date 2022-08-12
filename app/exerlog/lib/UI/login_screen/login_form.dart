import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/login_screen/google_signin_button.dart';
import 'package:exerlog/UI/login_screen/login_data.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final LoginData loginData;

  const LoginForm(this.loginData);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: greenTextColor,
            ),
            child: Container(
              margin: EdgeInsets.all(1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: backgroundColor,
              ),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 40,
                      child: Icon(
                        Icons.mail,
                        color: greenTextColor,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: TextField(
                        onChanged: (value) {
                          widget.loginData.email = value;
                        },
                        style: mediumTitleStyleWhite,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "email/username",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 30.0),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: greenTextColor,
            ),
            child: Container(
              margin: EdgeInsets.all(1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: backgroundColor,
              ),
              child: Container(
                padding: EdgeInsets.only(left: 10),
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
                      child: TextField(
                        onChanged: (value) {
                          widget.loginData.password = value;
                        },
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
            ),
          ),
        ),
        const SizedBox(height: 30.0),
        GoogleSignInButton()
      ],
    );
  }
}

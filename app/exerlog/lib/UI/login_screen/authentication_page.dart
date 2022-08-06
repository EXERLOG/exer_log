import 'package:dartz/dartz.dart' show Either;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Bloc/email_signup.dart';
import '../../core/error_handling/error.dart';
import '../../core/validators/auth_validators.dart';
import '../../core/validators/validator.dart';
import '../global.dart';
import '../gradient_button.dart';
import '../workout/workout_page.dart';
import 'auth_data.dart';
import 'login_form.dart';
import 'signup_form.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({
    Key? key,
  }) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  AuthData loginData = AuthData(email: '', password: '');
  bool login = true;
  int index = 0;
  List<Tab> tabs = <Tab>[
    Tab(
      child: Text(
        "Login",
        style: loginOptionTextStyle,
      ),
    ),
    Tab(
        child: Text(
      "Sign up",
      style: loginOptionTextStyle,
    )),
  ];
  int id = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
        ),
        child: Center(
          child: Container(
            height: height * 0.42,
            decoration: BoxDecoration(
              color: Color(0xFF2E2C42),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  offset: Offset(0, 3),
                  blurRadius: 10,
                  spreadRadius: 10,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 30,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    flexibleSpace: TabBar(
                        tabs: tabs,
                        controller: controller,
                        onTap: ((value) => setState(() {
                              index = value;
                            }))),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: TabBarView(
                    controller: controller,
                    children: [
                      LoginForm(loginData),
                      SignupForm(loginData),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 0, 60, 16),
                  child: RaisedGradientButton(
                    radius: 30,
                    child: Text(
                      index > 0 ? "Sign up" : "Login",
                      style: buttonText,
                    ),
                    gradient: LinearGradient(
                      colors: <Color>[Color(0xFF34D1C2), Color(0xFF31A6DC)],
                    ),
                    onPressed: () async {
                      // TODO: Separate Logical Part from UI
                      if (index == 0) {
                        // Validating for login
                        GroupValidator validation = GroupValidator(validators: [
                          EmailValidator.set(loginData.email),
                          PasswordValidator.set(loginData.password)
                        ]);
                        if (!validation.isValid) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(validation.error.message!),
                            backgroundColor: Colors.red,
                          ));
                          return;
                        }

                        // login with email and password
                        final Either<User?, ErrorModel> results =
                            await EmailSignup.signInWithEmailAndPassword(
                          loginData.email,
                          loginData.password,
                        );
                        results.fold((user) {
                          if (user == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("User not found"),
                              backgroundColor: Colors.red,
                            ));
                            return;
                          }
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => WorkoutPage(null),
                            ),
                          );
                        },
                            (error) => ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(error.errorMessage.toString()),
                                  backgroundColor: Colors.red,
                                )));
                      } else {
                        // Validating for register
                        GroupValidator validation = GroupValidator(validators: [
                          EmailValidator.set(loginData.email),
                          PasswordValidator.set(loginData.password),
                          ConfirmPasswordValidator.set(loginData.password,
                              loginData.confirmPassword ?? '')
                        ]);
                        if (!validation.isValid) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(validation.error.message!),
                            backgroundColor: Colors.red,
                          ));
                          return;
                        }

                        // signup with email and password
                        final Either<User?, ErrorModel> results =
                            await EmailSignup.registerWithEmail(
                          loginData.email,
                          loginData.password,
                        );
                        results.fold((user) {
                          if (user == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Registration Failed"),
                              backgroundColor: Colors.red,
                            ));
                            return;
                          }
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => WorkoutPage(null),
                            ),
                          );
                        },
                            (error) => ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(error.errorMessage.toString()),
                                  backgroundColor: Colors.red,
                                )));
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//   child: DefaultTabController(
//   length: tabs.length,
//   initialIndex: 0,
//     child: TabBar(
//       indicatorColor: textColorBlue,
//       tabs:tabs
//       ),
// ),
// )

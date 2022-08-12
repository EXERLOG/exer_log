import 'package:exerlog/Bloc/email_signup.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/gradient_button.dart';
import 'package:exerlog/UI/login_screen/login_data.dart';
import 'package:exerlog/UI/login_screen/login_form.dart';
import 'package:exerlog/UI/login_screen/signup_form.dart';
import 'package:exerlog/UI/workout/workout_page.dart';
import 'package:exerlog/main.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  LoginData loginData = LoginData('', '');
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

  @override
  void initState() {
    super.initState();
    controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: _buildElevatedCentredContainer(
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40,
              margin: EdgeInsets.only(bottom: 15),
              child: TabBar(
                tabs: tabs,
                controller: controller,
              ),
            ),
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
                child: Text(
                  index > 0 ? "Sign up" : "Login",
                  style: buttonText,
                ),
                onPressed: () async {
                  if (index == 0) {
                    // login with email and password
                    if (loginData.password != '' && loginData.email != '') {
                      final user = await EmailSignup.signInWithEmailAndPassword(
                        loginData.email,
                        loginData.password,
                      );

                      if (user != null) {
                        print("USER IS NOT NULL");

                        userID = user.uid;
                        the_user = user;

                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => WorkoutPage(null),
                          ),
                        );
                      }
                    }
                  } else {
                    // signup with email and password
                    if (loginData.password != '' && loginData.email != '') {
                      final user = await EmailSignup.registerWithEmail(
                        loginData.email,
                        loginData.password,
                      );

                      if (user != null) {
                        print("USER IS NOT NULL");

                        userID = user.uid;
                        the_user = user;

                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => WorkoutPage(null),
                          ),
                        );
                      }
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildElevatedCentredContainer(Widget child) {
    final height = MediaQuery.of(context).size.height;

    return Center(
      child: Container(
        height: height * 0.50,
        margin: EdgeInsets.symmetric(horizontal: 30),
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
        child: child,
      ),
    );
  }
}

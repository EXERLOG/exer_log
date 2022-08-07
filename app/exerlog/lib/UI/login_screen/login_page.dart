import 'package:exerlog/Bloc/email_signup.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/gradient_button.dart';
import 'package:exerlog/UI/login_screen/login_data.dart';
import 'package:exerlog/UI/login_screen/login_form.dart';
import 'package:exerlog/UI/login_screen/signup_form.dart';
import 'package:exerlog/UI/workout/workout_page.dart';
import 'package:exerlog/main.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final String title;

  const LoginPage({
    Key? key,
    this.title = "0",
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late TabController controller;

  LoginData loginData = LoginData('', '');
  bool login = true;
  int tabIndex = 0;
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
    controller.addListener(() {
      if (controller.indexIsChanging)
        setState(() {
          tabIndex = controller.index;
        });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
                    flexibleSpace: TabBar(tabs: tabs, controller: controller),
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
                      tabIndex == 0 ? "Login" : "Sign up",
                      style: buttonText,
                    ),
                    gradient: LinearGradient(
                      colors: <Color>[Color(0xFF34D1C2), Color(0xFF31A6DC)],
                    ),
                    onPressed: () async {
                      if (tabIndex == 0) {
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

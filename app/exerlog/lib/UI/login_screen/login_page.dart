import 'package:exerlog/Bloc/authentication.dart';
import 'package:exerlog/Bloc/email_signup.dart';
import 'package:exerlog/Bloc/user_bloc.dart';
import 'package:exerlog/Bloc/workout_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/Models/user.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/login_screen/google_signin_button.dart';
import 'package:exerlog/UI/login_screen/login_data.dart';
import 'package:exerlog/UI/login_screen/login_form.dart';
import 'package:exerlog/UI/login_screen/signup_form.dart';
import 'package:exerlog/UI/workout/workout_builder.dart';
import 'package:exerlog/UI/workout/workout_page.dart';
import 'package:exerlog/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../gradient_button.dart';
import '../global.dart';
import '../maxes/max_builder.dart';

class LoginPage extends StatefulWidget {
  LoginPage(this.title, {Key? key}) : super(key: key);
  String title = "0";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginData loginData = new LoginData('', '');
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
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor,
        body: Container(
          padding: EdgeInsets.only(top: height*0.25, bottom: height*0.3, left: 30, right: 30),
          child: Container(
            child: Stack(children: [
              Container(
                height: height*0.42,
                decoration: BoxDecoration(
                    color: Color(0xFF2E2C42),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.2),
                          offset: Offset(0, 3),
                          blurRadius: 10,
                          spreadRadius: 10)
                    ]),
                child: DefaultTabController(
                    length: tabs.length,
                    // The Builder widget is used to have a different BuildContext to access
                    // closest DefaultTabController.
                    child: Builder(builder: (BuildContext context) {
                      final TabController tabController =
                          DefaultTabController.of(context)!;
                      tabController.addListener(() {
                        if (!tabController.indexIsChanging) {
                          setState(() {
                            index = tabController.index;
                            print(index);
                          });
                          // Your code goes here.
                          // To get index of current tab use tabController.index
                        }
                      });
                      return Column(
                        children: [
                          Container(
                            height: 30,
                            child: AppBar(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              flexibleSpace: TabBar(
                                tabs: tabs,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            height: height*0.34,
                            child: TabBarView(
                              children: [
                                LoginForm(loginData),
                                SignupForm(loginData)
                              ],
                            ),
                          ),
                        ],
                      );
                    })),
              ),
              Positioned(
                child: RaisedGradientButton(
                  radius: 30,
                  child: Text(index > 0 ? "Sign up" : "Login", style: buttonText),
                  gradient: LinearGradient(
                    colors: <Color>[Color(0xFF34D1C2), Color(0xFF31A6DC)],
                  ),
                  onPressed: () async {
                    if (index == 0) {
                      // login with email and password
                      if (loginData.password != '' && loginData.email != '') {
                        User? user = await EmailSignup.signInWithEmailAndPassword(loginData.email, loginData.password).then((value) {
                          userID = value?.uid;
                          return value;
                        });
                       
                
                if (user != null) {
                  print("USER IS NOT NULL");
                  userID = user.uid;
                  the_user = user;
                  setState(() {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WorkoutPage(null
                      ),
                    ),
                  );
                  });                 
                }
                      }
                    }
                    else {
                      // signup with email and password
                      if (loginData.password != '' && loginData.email != '') {
                        User? user = await EmailSignup.registerWithEmail(loginData.email, loginData.password).then((value) {
                          userID = value?.uid;
                          return value;
                        });
                       
                
                if (user != null) {
                  print("USER IS NOT NULL");
                  userID = user.uid;
                  the_user = user;
                  setState(() {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WorkoutPage(null
                      ),
                    ),
                  );
                  });                 
                }
                      }
                    }
                  },
                ),
                right: 60,
                left: 60,
                bottom: 0,
              )
            ]),
          ),
        ));
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

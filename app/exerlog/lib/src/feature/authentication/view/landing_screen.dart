import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/gradient_button.dart';
import 'package:exerlog/UI/login_screen/login_form.dart';
import 'package:exerlog/UI/login_screen/signup_form.dart';
import 'package:exerlog/UI/workout/workout_page.dart';
import 'package:exerlog/src/core/base/base_state.dart';
import 'package:exerlog/src/feature/authentication/controller/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingScreen extends ConsumerStatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LandingScreenState();
}

class _LandingScreenState extends ConsumerState<LandingScreen>
    with SingleTickerProviderStateMixin {
  /// Form Keys
  final _loginFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();

  /// Tab
  late TabController _tabController;
  int _tabIndex = 0;
  List<Tab> tabs = <Tab>[
    Tab(
      child: Text(
        "Login",

        /// TODO: Handle text style properly (applies everywhere)
        style: loginOptionTextStyle,
      ),
    ),
    Tab(
      child: Text(
        "Sign up",
        style: loginOptionTextStyle,
      ),
    ),
  ];

  void _tabSwitchListener(int value) {
    setState(() {
      _tabIndex = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      _tabSwitchListener(_tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _controller = ref.read(AuthenticationController.controller);

    ref.listen(AuthenticationController.provider, (_, state) {
      if (state is SuccessState) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => WorkoutPage(null),
          ),
        );
      } else if (state is ErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong"),
          ),
        );
      }
    });
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
                controller: _tabController,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Form(key: _loginFormKey, child: LoginForm(_controller)),
                  Form(key: _signUpFormKey, child: SignupForm(_controller)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 0, 60, 16),
              child: RaisedGradientButton(
                child: Text(
                  _tabIndex > 0 ? "Sign up" : "Login",
                  style: buttonText,
                ),
                onPressed: () async {
                  if (_tabIndex == 0) {
                    if (_loginFormKey.currentState!.validate()) {
                      await _controller.signIn();
                    }
                  } else {
                    if (_signUpFormKey.currentState!.validate()) {
                      if (_controller.isSamePassword()) {
                        await _controller.signUp();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Password should match"),
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

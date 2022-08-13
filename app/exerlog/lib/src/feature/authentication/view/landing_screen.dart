import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/workout/workout_page.dart';
import 'package:exerlog/src/core/base/base_state.dart';
import 'package:exerlog/src/core/base/extensions/context_extension.dart';
import 'package:exerlog/src/feature/authentication/controller/authentication_controller.dart';
import 'package:exerlog/src/feature/authentication/widgets/elevated_container.dart';
import 'package:exerlog/src/feature/authentication/widgets/google_signin_button.dart';
import 'package:exerlog/src/feature/authentication/widgets/login_form.dart';
import 'package:exerlog/src/feature/authentication/widgets/signup_form.dart';
import 'package:exerlog/src/widgets/gradient_button.dart';
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
      body: ElevatedContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 40,
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

            /// Google Sign In button
            if (_tabIndex == 0) ...[
              GoogleSignInButton(
                onPressed: () async {
                  await _controller.signInWithGoogle();
                },
              ),
            ],
            SizedBox(height: 20),

            /// Login / Sign up button
            RaisedGradientButton(
              child: Text(
                _tabIndex > 0 ? "Sign up" : "Login",
                style: buttonText,
              ),
              width: context.width * .65,
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
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

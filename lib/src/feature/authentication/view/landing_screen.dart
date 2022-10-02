import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/workout/workout_page.dart';
import 'package:exerlog/src/core/base/base_state.dart';
import 'package:exerlog/src/core/base/extensions/context_extension.dart';
import 'package:exerlog/src/core/theme/app_theme.dart';
import 'package:exerlog/src/feature/authentication/controller/authentication_controller.dart';
import 'package:exerlog/src/feature/authentication/widgets/elevated_container.dart';
import 'package:exerlog/src/feature/authentication/widgets/login_form.dart';
import 'package:exerlog/src/feature/authentication/widgets/signup_form.dart';
import 'package:exerlog/src/feature/calendar/view/calendar_screen.dart';
import 'package:exerlog/src/widgets/gradient_button.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingScreen extends ConsumerStatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LandingScreenState();
}

class _LandingScreenState extends ConsumerState<LandingScreen> with SingleTickerProviderStateMixin {
  /// Form Keys
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  /// Tab
  late TabController _tabController;
  int _tabIndex = 0;
  List<Tab> tabs = <Tab>[
    Tab(
      child: Text(
        'Login',

        /// TODO: Handle text style properly (applies everywhere)
        style: loginOptionTextStyle,
      ),
    ),
    Tab(
      child: Text(
        'Sign up',
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
    final AuthenticationController authController = ref.read(AuthenticationController.controller);

    ref.listen(AuthenticationController.provider, (_, BaseState? state) {
      if (state is SignUpSuccessState) {
        _navigateToWorkoutScreen();
      } else if (state is LoginSuccessState) {
        _navigateToCalendarScreen();
      } else if (state is ErrorState) {
        context.showSnackBar('Something went wrong');
      }
    });

    return ThemeProvider(
      builder: (BuildContext context, AppTheme theme) {
        return Scaffold(
          backgroundColor: theme.colorTheme.backgroundColorVariation,
          body: ElevatedContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
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
                    children: <Widget> [
                      Form(key: _loginFormKey, child: LoginForm(authController)),
                      Form(key: _signUpFormKey, child: SignupForm(authController)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                /// Login / Sign up button
                RaisedGradientButton(
                  width: context.width * .65,
                  onPressed: () async {
                    if (_tabIndex == 0) {
                      if (_loginFormKey.currentState!.validate()) {
                        await authController.signIn();
                      }
                    } else {
                      if (_signUpFormKey.currentState!.validate()) {
                        if (authController.isSamePassword()) {
                          await authController.signUp();
                        } else {
                          context.showSnackBar('Password should match');
                        }
                      }
                    }
                  },
                  child: Text(
                    _tabIndex > 0 ? 'Sign up' : 'Login',
                    style: buttonText,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToCalendarScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const CalendarScreen(),
      ),
    );
  }

  Future<dynamic> _navigateToWorkoutScreen() {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => WorkoutPage(null),
      ),
    );
  }
}

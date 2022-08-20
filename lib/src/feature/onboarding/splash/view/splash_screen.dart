import 'dart:async';

import 'package:exerlog/UI/calendar/view/calendar_page.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/main.dart';
import 'package:exerlog/src/core/base/shared_preference/shared_preference_b.dart';
import 'package:exerlog/src/feature/authentication/view/landing_screen.dart';
import 'package:exerlog/src/utils/assets.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 2000), () {
      if (SharedPref.getBoolAsync(IS_LOGGED_IN, defaultValue: false)) {
        /// TODO: Remove later
        userID = SharedPref.getStringAsync(USER_UID);
        if (mounted) _navigateToCalendarScreen();
      } else {
        if (mounted) _navigateToLandingScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      builder: (context, theme) {
        return Scaffold(
          backgroundColor: theme.colorTheme.backgroundColorVariation,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  Assets.appLogoWhite,
                  height: 300,
                  width: 300,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToLandingScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LandingScreen(),
      ),
    );
  }

  void _navigateToCalendarScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => CalendarPage(),
      ),
    );
  }
}

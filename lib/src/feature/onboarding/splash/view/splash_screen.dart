import 'dart:async';

import 'package:exerlog/src/core/base/shared_preference/shared_preference_b.dart';
import 'package:exerlog/src/core/theme/app_theme.dart';
import 'package:exerlog/src/feature/authentication/view/landing_screen.dart';
import 'package:exerlog/src/feature/calendar/view/calendar_screen.dart';
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
    Timer(const Duration(milliseconds: 2000), () {
      if (SharedPref.getBoolAsync(IS_LOGGED_IN, defaultValue: false)) {
        if (mounted) _navigateToCalendarScreen();
      } else {
        if (mounted) _navigateToLandingScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      builder: (BuildContext context, AppTheme theme) {
        return Scaffold(
          backgroundColor: theme.colorTheme.backgroundColorVariation,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
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
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const LandingScreen(),
      ),
    );
  }

  void _navigateToCalendarScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const CalendarScreen(),
      ),
    );
  }
}

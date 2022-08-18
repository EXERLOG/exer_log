import 'package:exerlog/UI/calendar/view/calendar_page.dart';
import 'package:exerlog/main.dart';
import 'package:exerlog/src/core/base/shared_preference/shared_preference_b.dart';
import 'package:exerlog/src/feature/authentication/controller/authentication_controller.dart';
import 'package:exerlog/src/feature/onboarding/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'landing_screen.dart';

class AuthenticationWrapper extends ConsumerWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (user) {
        if (user != null) {
          SharedPref.setValue(USER_UID, user.uid);

          /// TODO: Remove later
          userID = SharedPref.getStringAsync(USER_UID);
          return CalendarPage();
        }
        return LandingScreen();
      },
      error: (e, stackTrace) {
        /// TODO: Use a generic error screen
        return SizedBox.shrink();
      },
      loading: () {
        return SplashScreen();
      },
    );
  }
}

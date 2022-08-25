// @dart = 2.9
import 'package:exerlog/src/core/theme/theme_color.dart';
import 'package:exerlog/src/feature/onboarding/splash/view/splash_screen.dart';
import 'package:exerlog/src/utils/logger/logger.dart';
import 'package:exerlog/src/utils/logger/riverpod_logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/core/base/shared_preference/shared_preference_b.dart';

/// TODO: Remove global instances and use shared pref keys
@Deprecated('Use `USER_UID` instead. Will be removed soon')
String userID = '';
@Deprecated('Should be removed')
User the_user;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Device orientation locked to portrait up
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  /// Initialize shared preference
  try {
    await SharedPref.initializeSharedPreference();
  } catch (e, stackTrace) {
    Log.error(e.toString(), stackTrace: stackTrace);
    throw ErrorDescription(e);
  }

  /// Initialize firebase
  await Firebase.initializeApp();

  /// A widget that stores the state of providers.
  /// All Flutter applications using Riverpod must contain a [ProviderScope] at
  /// the root of their widget tree
  runApp(
    ProviderScope(
      observers: [RiverpodLogger()],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'EXERLOG',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          snackBarTheme: SnackBarThemeData(
              backgroundColor: ThemeColor.red,
              contentTextStyle: TextStyle(color: ThemeColor.secondary)),
          scaffoldBackgroundColor: ThemeColor.darkBlueVariation,
          dialogBackgroundColor: ThemeColor.darkBlueVariation,
          appBarTheme: AppBarTheme(
              backgroundColor: ThemeColor.darkBlue.withOpacity(0.75)),
          colorScheme: ColorScheme.light().copyWith(
            primary: ThemeColor.primary,
            secondary: ThemeColor.secondary,
            error: ThemeColor.red,
            background: ThemeColor.darkBlueVariation,
          )),
      darkTheme: ThemeData(),
      home: SplashScreen(),
    );
  }
}

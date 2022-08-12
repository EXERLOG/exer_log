// @dart = 2.9
import 'package:exerlog/UI/calendar/view/calendar_page.dart';
import 'package:exerlog/src/feature/authentication/controller/authentication_controller.dart';
import 'package:exerlog/src/utils/logger/logger.dart';
import 'package:exerlog/src/utils/logger/riverpod_logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/feature/authentication/view/landing_screen.dart';
import 'src/core/base/shared_preference/shared_preference_b.dart';

/// TODO: Remove global instances and use shared pref keys

@Deprecated('Use `USER_UID` instead. Will be removed soon')
String userID = '';
@Deprecated('Should be removed')
User the_user;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /// Device orientation locked to portrait up
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  /// A widget that stores the state of providers.
  /// All Flutter applications using Riverpod must contain a [ProviderScope] at
  /// the root of their widget tree
  runApp(ProviderScope(observers: [RiverpodLogger()], child: MyApp()));
}

final _firebaseInitProvider = FutureProvider<FirebaseApp>((ref) async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  return firebaseApp;
});

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<FirebaseApp> firebase = ref.watch(_firebaseInitProvider);

    return MaterialApp(
      title: 'EXERLOG',
      debugShowCheckedModeBanner: false,
      home: firebase.when(
        data: (data) {
          AsyncValue<User> authState = ref.watch(authStateProvider);
          return authState.when(
            data: (user) {
              if (user != null) {
                setValue(USER_UID, user.uid);
                return CalendarPage();
              }
              return user != null ? CalendarPage() : LandingScreen();
            },
            error: (e, stackTrace) {
              /// TODO: Use a generic error screen
              return SizedBox.shrink();
            },
            loading: () {
              /// TODO: Use a generic loading screen / welcome screen
              return const CircularProgressIndicator();
            },
          );
        },
        error: (e, stackTrace) {
          Log.error(e);
          Log.error(stackTrace.toString());
          return SizedBox.shrink();
        },
        loading: () {
          /// TODO: Use a splash screen
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

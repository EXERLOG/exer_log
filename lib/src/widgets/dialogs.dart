import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/core/base/shared_preference/shared_preference_b.dart';
import 'package:exerlog/src/feature/authentication/view/landing_screen.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

mixin Dialogs<T extends StatefulWidget> on State<T> {
  // Made to adjust according to decided design in the future.
  Widget _dialog({
    required String title,
    required String description,
    required List<Widget> actions,
  }) {
    return ThemeProvider(
      builder: (context, theme) => AlertDialog(
        backgroundColor: theme.colorTheme.backgroundColorVariation,
        title: Text(
          title,
          style: dialogTitleStyle,
        ),
        content: Text(
          description,
          style: dialogDescriptionStyle,
        ),
        actions: actions,
      ),
    );
  }

  Future<void> signOutConfirmationDialog() async {
    void _navigateToLandingScreen(BuildContext context) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LandingScreen()),
        (route) => false,
      );
    }

    await showDialog(
      context: context,
      builder: (context) => _dialog(
        title: 'Sign Out',
        description:
            'Are you sure you want to sign out?',
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              SharedPref.setValue(IS_LOGGED_IN, false);
              await FirebaseAuth.instance.signOut();
              _navigateToLandingScreen(context);
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}

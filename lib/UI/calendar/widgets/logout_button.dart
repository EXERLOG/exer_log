import 'package:exerlog/src/feature/authentication/view/landing_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: InkWell(
        onTap: () async {
          if (!_isLoading) {
            setState(() => _isLoading = true);
            await FirebaseAuth.instance.signOut();
            setState(() => _isLoading = false);
            _navigateToLandingScreen(context);
          }
        },
        child: _isLoading
            ? Center(child: CircularProgressIndicator(strokeWidth: 2))
            : Icon(Icons.logout),
      ),
    );
  }

  void _navigateToLandingScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LandingScreen()),
      (route) => false,
    );
  }
}

import 'package:exerlog/Mixins/dialogs.dart';
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

class _LogoutButtonState extends State<LogoutButton> with Dialogs {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: InkWell(
        onTap: _isLoading ? showSignoutConfirmationDialog : null,
        child: _isLoading
            ? Center(child: CircularProgressIndicator(strokeWidth: 2))
            : Icon(Icons.logout),
      ),
    );
  }
}

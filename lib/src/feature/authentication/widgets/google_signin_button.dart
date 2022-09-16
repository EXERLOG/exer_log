import 'dart:async';

import 'package:exerlog/src/core/base/extensions/context_extension.dart';
import 'package:exerlog/src/utils/assets.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class GoogleSignInButton extends StatefulWidget {
  GoogleSignInButton({Key? key, required this.onPressed}) : super(key: key);

  final FutureOr Function() onPressed;

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      builder: (context, theme) {
        return SizedBox(
          height: 50,
          width: context.width * .65,
          child: OutlinedButton(
            onPressed: _onPressed,
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(theme.colorTheme.white),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage(Assets.googleLogo),
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Sign in with Google',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(theme.colorTheme.white),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  void _onPressed() async {
    setState(() => _isLoading = true);
    await widget.onPressed();
    setState(() => _isLoading = false);
  }
}

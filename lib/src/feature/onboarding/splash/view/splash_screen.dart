import 'dart:async';
import 'package:exerlog/src/feature/authentication/view/authentication_wrapper.dart';
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
      if (mounted) _navigateToAuthWrapper();
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

  void _navigateToAuthWrapper() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AuthenticationWrapper(),
      ),
    );
  }
}

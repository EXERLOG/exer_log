import 'dart:async';

import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class RaisedGradientButton extends StatefulWidget {
  const RaisedGradientButton({
    required this.onPressed,
    required this.child,
    Key? key,
    this.width = double.infinity,
    this.height = 50.0,
    this.radius = 30,
    this.gradient,
  }) : super(key: key);

  final FutureOr Function() onPressed;
  final Widget child;
  final double width;
  final double height;
  final double radius;
  final Gradient? gradient;

  @override
  RaisedGradientButtonState createState() => RaisedGradientButtonState();
}

class RaisedGradientButtonState extends State<RaisedGradientButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      builder: (context, theme) {
        return SizedBox(
          height: widget.height,
          width: widget.width,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: widget.gradient ??
                  LinearGradient(
                    colors: <Color>[
                      theme.colorTheme.primaryColor,
                      theme.colorTheme.secondaryColor,
                    ],
                  ),
              borderRadius: BorderRadius.circular(widget.radius),
            ),
            child: TextButton(
              onPressed: _onPressed,
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : widget.child,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onPressed() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    await widget.onPressed();
    setState(() => _isLoading = false);
  }
}

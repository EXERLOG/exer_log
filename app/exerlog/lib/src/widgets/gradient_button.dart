import 'dart:async';

import 'package:flutter/material.dart';

class RaisedGradientButton extends StatefulWidget {
  RaisedGradientButton({
    required this.onPressed,
    required this.child,
    this.width = double.infinity,
    this.height = 50.0,
    this.radius = 30,
    this.gradient,
  });

  final FutureOr Function() onPressed;
  final Widget child;
  final double width;
  final double height;
  final double radius;
  final Gradient? gradient;

  @override
  _RaisedGradientButtonState createState() => _RaisedGradientButtonState();
}

class _RaisedGradientButtonState extends State<RaisedGradientButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: widget.gradient ??
              LinearGradient(
                colors: <Color>[
                  Color(0xFF34D1C2),
                  Color(0xFF31A6DC),
                ],
              ),
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        child: TextButton(
          onPressed: _onPressed(),
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : widget.child,
        ),
      ),
    );
  }

  void Function()? _onPressed() {
    return _isLoading
        ? null
        : () async {
            setState(() => _isLoading = true);
            await widget.onPressed();
            setState(() => _isLoading = false);
          };
  }
}

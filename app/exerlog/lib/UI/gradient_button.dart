import 'package:flutter/material.dart';
import 'global.dart';

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;
  final double radius;
  final double borderSize;

  const RaisedGradientButton({
    required this.child,
    required this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    required this.onPressed,
    required this.radius,
    required this.borderSize
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: radius*2,
      decoration: BoxDecoration(gradient: gradient, boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.2),
          offset: Offset(0, 3),
          blurRadius: 5,
          spreadRadius: 5
        ),
        
      ],
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(width: borderSize, color: backgroundColor)
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed(),
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
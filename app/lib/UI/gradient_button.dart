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

  final Function onPressed;
  final Widget child;
  final double width;
  final double height;
  final double radius;
  final Gradient? gradient;

  @override
  _RaisedGradientButtonState createState() => _RaisedGradientButtonState();
}

class _RaisedGradientButtonState extends State<RaisedGradientButton> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
        onPressed: () {
          widget.onPressed();
        },
        child: widget.child,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius),
            ),
          ),
        ),
      ),
    );
  }
}

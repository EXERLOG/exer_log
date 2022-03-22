
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RaisedGradientButton extends StatefulWidget {
  Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;
  final double radius;
  RaisedGradientButton({
    required this.child,
    required this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    required this.onPressed,
    required this.radius,
  });
  @override
  _RaisedGradientButtonState createState() => _RaisedGradientButtonState();

}

class _RaisedGradientButtonState extends State<RaisedGradientButton> {
  @override
  Widget build(BuildContext context) {
    return 
      DecoratedBox(
        decoration: BoxDecoration(
            gradient: widget.gradient,
            borderRadius: BorderRadius.circular(widget.radius)
          ),
        child: TextButton(
          onPressed: () {widget.onPressed();}, 
          child: widget.child,
          style: ButtonStyle(
            //backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                //side: BorderSide(width: widget.borderSize)
                
              )
            )
          ),
          ),
      );
  }

}
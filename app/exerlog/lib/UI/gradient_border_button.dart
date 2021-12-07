
import 'package:exerlog/UI/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientBorderButton extends StatefulWidget {
  Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;
  final double radius;
  final double borderSize;
  GradientBorderButton({
    required this.child,
    required this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    required this.onPressed,
    required this.radius,
    required this.borderSize,
  });
  @override
  _GradientBorderButtonState createState() => _GradientBorderButtonState();

}

class _GradientBorderButtonState extends State<GradientBorderButton> {
  @override
  Widget build(BuildContext context) {
    return 
      DecoratedBox(
        decoration: BoxDecoration(
            gradient: widget.gradient,
            borderRadius: BorderRadius.circular(widget.radius)
          ),
        child: Container(
          padding: EdgeInsets.all(widget.borderSize),
          child: TextButton(
            onPressed: () {widget.onPressed();}, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 30,
                ),
                widget.child,
                Container(
                  width: 30,
                  height: 30,
                  padding: EdgeInsets.all(widget.borderSize),
                  decoration: BoxDecoration(
                    gradient: widget.gradient,
                    borderRadius: BorderRadius.circular(widget.radius/2)
                  ),
                  child: Container(
                    child: Center(child: Icon(Icons.add, color: greenTextColor, size: 20,)),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(widget.radius)),
                  )
                )
              ],
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(backgroundColor),
              //backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.radius),
                  side: BorderSide(width: 0)
                  
                )
              )
            ),
            ),
        ),
      );
  }

}
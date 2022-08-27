import 'package:flutter/material.dart';

// @todo: write constructors
// @todo: delete everything from calender_screen.dart
// @todo: box-shadows -> only sample-one for now
// @todo: used predefined colors

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton(
      {Color? backgroundColor,
      Color? iconColor,
      IconData? icon,
      double? size,
      Key? key})
      : backgroundColor = Colors.black,
        iconColor = Colors.white,
        icon = Icons.add,
        size = 40.0,
        super(key: key);

  final Color? backgroundColor;
  final Color? iconColor;
  final IconData? icon;
  final double? size;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(size!),
          boxShadow: [
            BoxShadow(
              color: Colors.black87,
              blurRadius: 10,
              spreadRadius: 1,
              offset: Offset(2, 2),
            ),
            BoxShadow(
              color: Colors.white,
              blurRadius: 10,
              spreadRadius: 1,
              offset: Offset(-2, -2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => {print('tapped')},
            borderRadius: BorderRadius.circular(size!),
            child: Container(
              width: size,
              height: size,
              child: Center(
                child: Icon(
                  icon,
                  color: iconColor,
                  size: size! * 0.8,
                ),
              ),
            ),
          ),
        ),
      );
}

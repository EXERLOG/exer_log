import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton(
      {Color? backgroundColor, double? size, Key? key})
      : backgroundColor = Colors.white,
        size = 40.0,
        super(key: key);

  final Color? backgroundColor;
  final double? size;

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(size!)),
      );
}

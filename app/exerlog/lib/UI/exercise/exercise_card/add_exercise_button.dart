import 'package:exerlog/UI/global.dart';
import 'package:flutter/material.dart';

class AddExerciseButton extends StatelessWidget {
  final double size;
  final VoidCallback onTapped;

  const AddExerciseButton({
    required this.size,
    required this.onTapped,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            gradient: mainGradiant,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.add,
            color: Colors.black,
            size: size * 0.6,
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTapped,
              borderRadius: BorderRadius.circular(size / 2),
            ),
          ),
        ),
      ],
    );
  }
}

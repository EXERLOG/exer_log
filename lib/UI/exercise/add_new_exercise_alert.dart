import 'package:exerlog/UI/exercise/add_exercise_widget.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/gradient_button.dart';
import 'package:flutter/material.dart';

class AddExerciseAlert extends StatelessWidget {
  ExerciseNameSelectionWidget nameWidget;
  RaisedGradientButton addExercise;
  AddExerciseAlert(this.addExercise, this.nameWidget);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(15),
        height: screenHeight * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "New Exercise",
              style: mediumTitleStyleWhite,
              textAlign: TextAlign.center,
            ),
            Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: nameWidget),
            Container(
              height: screenHeight * 0.05,
              width: screenWidth * 0.5,
              child: addExercise,
            ),
          ],
        ),
      ),
    );
  }
}

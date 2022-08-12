import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/widgets/gradient_button.dart';
import 'package:exerlog/UI/workout/workout_name_selection_widget.dart';
import 'package:flutter/material.dart';

class AddWorkoutAlert extends StatelessWidget {
  WorkoutTemplateSelectionWidget nameWidget;
  RaisedGradientButton addWorkout;
  AddWorkoutAlert(this.addWorkout, this.nameWidget);
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
              "New Workout",
              style: mediumTitleStyleWhite,
              textAlign: TextAlign.center,
            ),
            // new or template
            Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: nameWidget),
            Container(
              height: screenHeight * 0.05,
              width: screenWidth * 0.5,
              child: addWorkout,
            ),
          ],
        ),
      ),
    );
  }
}

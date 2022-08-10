import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/gradient_button.dart';
import 'package:flutter/material.dart';

class DeleteWorkoutAlert extends StatefulWidget {
  RaisedGradientButton deleteWorkoutButton;
  RaisedGradientButton cancelWorkoutButton;
  DeleteWorkoutAlert(this.deleteWorkoutButton, this.cancelWorkoutButton);
  @override
  _DeleteWorkoutAlertState createState() => _DeleteWorkoutAlertState();
}

class _DeleteWorkoutAlertState extends State<DeleteWorkoutAlert> {
  //ExerciseNameSelectionWidget nameWidget;
  String name = '';
  bool? template;

  @override
  void initState() {
    template = false;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(15),
        height: screenHeight * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Are you sure you want to delete this workout?",
              style: mediumTitleStyleWhite,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.30,
                  child: widget.cancelWorkoutButton,
                ),
                Container(
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.3,
                  child: widget.deleteWorkoutButton,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

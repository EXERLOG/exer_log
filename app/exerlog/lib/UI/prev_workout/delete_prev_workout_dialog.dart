import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/widgets/gradient_button.dart';
import 'package:flutter/material.dart';

class DeleteWorkoutAlert extends StatefulWidget {
  RaisedGradientButton deleteWorkoutButton;
  DeleteWorkoutAlert(this.deleteWorkoutButton);
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
        height: screenHeight * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Are you sure you want to delete this workout?",
              style: mediumTitleStyleWhite,
              textAlign: TextAlign.center,
            ),
            Container(
              height: screenHeight * 0.05,
              width: screenWidth * 0.5,
              child: widget.deleteWorkoutButton,
            ),
          ],
        ),
      ),
    );
  }
}

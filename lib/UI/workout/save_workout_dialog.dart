import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/widgets/gradient_button.dart';
import 'package:flutter/material.dart';

class SaveWorkoutAlert extends StatefulWidget {
  Function(String, bool) setWorkout;
  RaisedGradientButton saveWorkout;
  SaveWorkoutAlert(this.saveWorkout, this.setWorkout);
  @override
  _SaveWorkoutAlertState createState() => _SaveWorkoutAlertState();
}

class _SaveWorkoutAlertState extends State<SaveWorkoutAlert> {
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
              "Save Workout",
              style: mediumTitleStyleWhite,
              textAlign: TextAlign.center,
            ),
            Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  style: setStyle,
                  onChanged: (value) {
                    name = value;
                    widget.setWorkout(name, template!);
                  },
                  decoration: InputDecoration(
                    hintText: 'name your workout',
                    hintStyle: setHintStyle,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: greenTextColor),
                      //  when the TextFormField in unfocused
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: greenTextColor),
                      //  when the TextFormField in focused
                    ),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: greenTextColor)),
                  ),
                )),
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        'Save as template',
                        style: mediumTitleStyleWhite,
                      ),
                    ),
                    Checkbox(
                      fillColor:
                          MaterialStateProperty.all<Color>(greenTextColor),
                      value: this.template,
                      onChanged: (bool? value) {
                        setState(() {
                          print(value);
                          template = value;
                          widget.setWorkout(name, template!);
                        });
                      },
                    ),
                  ]),
            ),
            Container(
              height: screenHeight * 0.05,
              width: screenWidth * 0.5,
              child: widget.saveWorkout,
            ),
          ],
        ),
      ),
    );
  }
}

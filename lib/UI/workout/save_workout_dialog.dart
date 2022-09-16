import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/utils/logger/logger.dart';
import 'package:exerlog/src/widgets/gradient_button.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class SaveWorkoutAlert extends StatefulWidget {
  final Function(String, bool) setWorkout;
  final RaisedGradientButton saveWorkout;

  const SaveWorkoutAlert(
    this.saveWorkout,
    this.setWorkout,
  );
  @override
  _SaveWorkoutAlertState createState() => _SaveWorkoutAlertState();
}

class _SaveWorkoutAlertState extends State<SaveWorkoutAlert> {
  String name = '';
  bool? template;

  @override
  void initState() {
    template = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      builder: (context, theme) {
        return Dialog(
          backgroundColor: theme.colorTheme.backgroundColorVariation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(15),
            height: screenHeight * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Save Workout',
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
                          borderSide: BorderSide(color: theme.colorTheme.primaryColor),
                          //  when the TextFormField in unfocused
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: theme.colorTheme.primaryColor),
                          //  when the TextFormField in focused
                        ),
                        border: UnderlineInputBorder(borderSide: BorderSide(color: theme.colorTheme.primaryColor)),
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
                        fillColor: MaterialStateProperty.all<Color>(theme.colorTheme.primaryColor),
                        value: this.template,
                        onChanged: (bool? value) {
                          setState(() {
                            Log.info(value.toString());
                            template = value;
                            widget.setWorkout(name, template!);
                          });
                        },
                      ),
                    ],
                  ),
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
      },
    );
  }
}

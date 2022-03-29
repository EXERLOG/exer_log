import 'package:exerlog/Bloc/workout_bloc.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/global.dart';
import 'package:flutter/material.dart';

class WorkoutTemplateSelectionWidget extends StatefulWidget {
  Function(Workout) setWorkout;
  List workoutList;

  WorkoutTemplateSelectionWidget({
    required this.setWorkout,
    required this.workoutList
  }) {
    setWorkout = this.setWorkout;
  }
  @override
  _WorkoutNameSelectionWidgetState createState() =>
      _WorkoutNameSelectionWidgetState();
}

class _WorkoutNameSelectionWidgetState
    extends State<WorkoutTemplateSelectionWidget> {
  String? dropDownValue;
  Map workoutMap = {};
  @override
  Widget build(BuildContext context) {
    return 
       Center(
              child: Theme(
                data: ThemeData(
                    // backgroundColor: backgroundColor,
                    // cardColor: backgroundColor,
                    // focusColor: backgroundColor,
                    // highlightColor: backgroundColor,
                    // hoverColor: backgroundColor,
                    // selectedRowColor: backgroundColor,
                    // dialogBackgroundColor: backgroundColor,
                    inputDecorationTheme: new InputDecorationTheme(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: greenTextColor),
                          //  when the TextFormField in unfocused
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: greenTextColor),
                          //  when the TextFormField in focused
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: greenTextColor))),
                    textTheme: TextTheme(
                      subtitle1: setStyle,
                    )),
                child: Container(
                  width: screenWidth * 0.5,
                  child: DropdownButton<String>(
                    value: dropDownValue,
                    onChanged: (String? value) {
                      setState(() {
                        dropDownValue = value!;
                        print(value);
                      });
                      widget.setWorkout(workoutMap[dropDownValue]);
                      Navigator.pop(context);
                    },
                    items:
                        widget.workoutList.map<DropdownMenuItem<String>>((element) {
                      dropDownValue = element.name;
                      workoutMap[element.name] = element;
                      print("NAME " + element.name);
                      return DropdownMenuItem<String>(
                        value: element.name,
                        child: Text(element.name),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
  }
}

import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/core/theme/app_theme.dart';
import 'package:exerlog/src/utils/logger/logger.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class WorkoutTemplateSelectionWidget extends StatefulWidget {

  WorkoutTemplateSelectionWidget(
      {required this.setWorkout, required this.workoutList, Key? key,})
      : super(key: key) {
    setWorkout = this.setWorkout;
  }
  Function(Workout) setWorkout;
  List <dynamic>workoutList;
  @override
  WorkoutNameSelectionWidgetState createState() => WorkoutNameSelectionWidgetState();
}

class WorkoutNameSelectionWidgetState extends State<WorkoutTemplateSelectionWidget> {
  String? dropDownValue;
  Map<String, dynamic> workoutMap = <String, dynamic>{};
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      builder: (BuildContext context, AppTheme theme) {
        return Center(
          child: Theme(
            data: ThemeData(
              inputDecorationTheme: InputDecorationTheme(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: theme.colorTheme.primaryColor),
                  //  when the TextFormField in unfocused
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: theme.colorTheme.primaryColor),
                  //  when the TextFormField in focused
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: theme.colorTheme.primaryColor),
                ),
              ),
              textTheme: TextTheme(
                subtitle1: setStyle,
              ),
            ),
            child: Container(
              width: screenWidth * 0.5,
              child: DropdownButton<String>(
                value: dropDownValue,
                onChanged: (String? value) {
                  setState(() {
                    dropDownValue = value!;
                    Log.info(value);
                  });
                  widget.setWorkout(workoutMap[dropDownValue]);
                  Navigator.pop(context);
                },
                items: widget.workoutList.map<DropdownMenuItem<String>>((dynamic element) {
                  dropDownValue = element.name;
                  workoutMap[element.name] = element;
                  Log.info('NAME ${element.name}');
                  return DropdownMenuItem<String>(
                    value: element.name,
                    child: Text(element.name),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

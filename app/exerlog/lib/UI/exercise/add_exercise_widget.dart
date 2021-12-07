import 'package:exerlog/Bloc/exercise_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ExerciseNameSelectionWidget extends StatefulWidget {
  Exercise exercise;
  Function(String) setExercisename;

  ExerciseNameSelectionWidget({required this.setExercisename, required this.exercise,}) {
    exercise = this.exercise;
    setExercisename = this.setExercisename;
  }
  @override
  _ExerciseNameSelectionWidgetState createState() => _ExerciseNameSelectionWidgetState();

}

class _ExerciseNameSelectionWidgetState extends State<ExerciseNameSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getExerciseNames(),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          } else {
            return Center(
              child: Autocomplete<String>(
                onSelected: (value) {
                  widget.setExercisename(value);
                },
                optionsBuilder: (TextEditingValue textEditingValue) 
                { 
                    widget.setExercisename(textEditingValue.text);
                  return snapshot.data!.where((String name) => name.toLowerCase()
                  .startsWith(textEditingValue.text.toLowerCase())
                  );
                 },
                ),
            );
          }
        }
      },
    );
  }

}
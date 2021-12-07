import 'package:exerlog/Bloc/user_bloc.dart';
import 'package:exerlog/Bloc/workout_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/exercise/add_exercise_widget.dart';
import 'package:exerlog/UI/exercise/exercise_card.dart';
import 'package:exerlog/UI/gradient_border_button.dart';
import 'package:flutter/material.dart';
import 'gradient_button.dart';
import 'global.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage();

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  Workout workout = new Workout([], '', '', 0, '', '');
  List<Widget> exerciseWidgets = [];
  Exercise exercise = new Exercise('', [], []);

  @override
  Widget build(BuildContext context) {
    exerciseWidgets = exerciseWidgets;
    return Material(
      child: Container(
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Container(
              height: 500,
              child: ListView(
                children: exerciseWidgets,
              ),
            ),
            Container(
              height: 50,
              width: 350,
              child: GradientBorderButton(
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFF34D1C2), Color(0xFF31A6DC)],
                ),
                radius: 30,
                borderSize: 3,
                onPressed: () { 
                  // create new exercise
                  print("Length: " + exerciseWidgets.length.toString());
                  showAlertDialog(context);
                 },
                child: Container(
                  height: 50,
                  width: 200,
                  child: Center(child: Text("Add New Exercise", style: greenButtonTextThin,)),
                ),
              ),
            ),
            Container(
              height: 40,
              width: 350,
              margin: EdgeInsets.only(bottom: 30),
              child: RaisedGradientButton(
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFF34D1C2), Color(0xFF31A6DC)],
                ),
                radius: 30,
                borderSize: 0,
                onPressed: () { 
                  saveWorkout(workout);
                 },
                child: Container(
                  height: 50,
                  width: 200,
                  child: Center(child: Text("Save", style: buttonText,)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  addExercise(exercise) {
    for (Exercise existingExercise in workout.exercises) {
      if (existingExercise.name == exercise.name) {
        existingExercise  = exercise;
        return;
      }
    }
    workout.exercises.add(exercise);
  }

  setExercisename(name) {
    exercise = new Exercise(name, [], []);
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("add"),
      onPressed: () {
        if (exercise.name != '') {
          setState(() {
            workout.exercises.add(exercise);
            exerciseWidgets.add(new ExerciseCard(name: exercise.name, addExercise: addExercise));
          });
          Navigator.pop(context);
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Add new exercise"),
      content: ExerciseNameSelectionWidget(exercise: exercise, setExercisename: setExercisename),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
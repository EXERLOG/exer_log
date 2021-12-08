import 'package:exerlog/Bloc/user_bloc.dart';
import 'package:exerlog/Bloc/workout_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/sets.dart';
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
  WorkoutData workoutData = new WorkoutData(new Workout([], '', '', 0, '', ''));
  String exerciseName = '';

  @override
  Widget build(BuildContext context) {
    for (Exercise exercise in workoutData.workout.exercises) {
      print("Name " + exercise.name);
    }
    workoutData = new WorkoutData(workoutData.workout);
    return Material(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          color: backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Container(
                height: 500,
                child: ListView(
                  children: workoutData.exerciseWidgets,
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
                    showAlertDialog(context);
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    child: Center(
                        child: Text(
                      "Add New Exercise",
                      style: greenButtonTextThin,
                    )),
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
                    Sets sets = workoutData.workout.exercises[0].sets[0];
                    if (sets.reps > 0) {
                      saveWorkout(workoutData.workout);
                      setState(() {
                        workoutData =
                            new WorkoutData(new Workout([], '', '', 0, '', ''));
                      });
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    child: Center(
                        child: Text(
                      "Save",
                      style: buttonText,
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  setExercisename(name) {
    exerciseName = name;
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("add"),
      onPressed: () {
        if (exerciseName != '') {
          setState(() {
            workoutData.addExercise(new Exercise(exerciseName, [], []));
            workoutData.setExerciseWidgets();
          });
          Navigator.pop(context);
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Add new exercise"),
      content: ExerciseNameSelectionWidget(setExercisename: setExercisename),
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

class WorkoutData {
  Workout workout;
  List<ExerciseCard> exerciseWidgets = [];

  WorkoutData(this.workout) {
    workout = this.workout;
    setExerciseWidgets();
  }

  List<ExerciseCard> setExerciseWidgets() {
    exerciseWidgets = [];
    for (Exercise exercise in workout.exercises) {
      exerciseWidgets.add(new ExerciseCard(
          name: exercise.name,
          exercise: exercise,
          addExercise: addExercise,
          updateExisitingExercise: updateExisitingExercise));
    }
    return exerciseWidgets;
  }

  updateExisitingExercise(exercise) {
    for (Exercise oldexercise in workout.exercises) {
      if (oldexercise.name == exercise.name) {
        oldexercise = exercise;
      }
    }
  }

  addExercise(exercise) {
    for (Exercise existingExercise in workout.exercises) {
      if (existingExercise.name == exercise.name) {
        existingExercise = exercise;
        return;
      }
    }
    if (exercise.name != '') {
      workout.exercises.add(exercise);
    }
  }
}

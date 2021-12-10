import 'package:exerlog/Bloc/user_bloc.dart';
import 'package:exerlog/Bloc/workout_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/exercise/add_exercise_widget.dart';
import 'package:exerlog/UI/exercise/exercise_card.dart';
import 'package:exerlog/UI/exercise/totals_widget.dart';
import 'package:exerlog/UI/gradient_border_button.dart';
import 'package:exerlog/UI/workout/workout_toatals_widget.dart';
import 'package:flutter/material.dart';
import 'gradient_button.dart';
import 'global.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage();

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  late WorkoutTotalsWidget workoutTotalsWidget;
  late WorkoutData workoutData;
  String exerciseName = '';

  @override
  void initState() {
    // TODO: implement initState
    workoutData = new WorkoutData(new Workout([], '', '', 0, '', ''), new WorkoutTotals(0, 0, 0, 0, 0), updateTotals);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    workoutData = new WorkoutData(workoutData.workout, workoutData.totals, updateTotals);
    workoutTotalsWidget = new WorkoutTotalsWidget(totals: workoutData.totals);
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
              WorkoutTotalsWidget(totals: workoutData.totals,),
              Container(
                height: screenHeight * 0.5,
                child: ListView(
                  children: workoutData.exerciseWidgets,
                ),
              ),
              Container(
                height: screenHeight*0.065,
                width: screenWidth*0.9,
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
                    width: screenWidth*0.6,
                    child: Center(
                        child: Text(
                      "Add New Exercise",
                      style: greenButtonTextThin,
                    )),
                  ),
                ),
              ),
              Container(
                height: screenHeight*0.065,
                width: screenWidth*0.9,
                margin: EdgeInsets.only(bottom: 30),
                child: RaisedGradientButton(
                  gradient: LinearGradient(
                    colors: <Color>[Color(0xFF34D1C2), Color(0xFF31A6DC)],
                  ),
                  radius: 30,
                  borderSize: 0,
                  onPressed: () {
                    for (Exercise exercise in workoutData.workout.exercises) {
                      for (Sets sets in exercise.sets) {
                        if (sets.reps == 0) {
                          exercise.sets.remove(sets);
                        }
                      }
                      if (exercise.sets.length == 0) {
                        workoutData.workout.exercises.remove(exercise);
                      }
                    }
                    if (workoutData.workout.exercises.length > 0) {
                      saveWorkout(workoutData.workout);
                      setState(() {
                        workoutData =
                            new WorkoutData(new Workout([], '', '', 0, '', ''), new WorkoutTotals(0, 0, 0, 0, 0), updateTotals);
                      });
                    }
                  },
                  child: Container(
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

  updateTotals() {
    setState(() {
      
    });
  }

  showAlertDialog(BuildContext context) {

    ExerciseNameSelectionWidget exerciseNameSelectionWidget = new ExerciseNameSelectionWidget(setExercisename: setExercisename,);
    // set up the button
    RaisedGradientButton okButton = RaisedGradientButton(
      gradient: LinearGradient(
                    colors: <Color>[Color(0xFF34D1C2), Color(0xFF31A6DC)],
                  ),
                  radius: 30,
                  borderSize: 0,
      child: Text("ADD", style: buttonTextSmall,),
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
    AddExerciseAlert alert = AddExerciseAlert(okButton, exerciseNameSelectionWidget);

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
  Function() updateTotals;
  Workout workout;
  WorkoutTotals totals;
  List<ExerciseCard> exerciseWidgets = [];

  WorkoutData(this.workout, this.totals, this.updateTotals) {
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
    updateTotals();
    return exerciseWidgets;
  }

  updateExisitingExercise(exercise) {
    totals = new WorkoutTotals(0, 0, 0, 0, 0);
    for (Exercise oldexercise in workout.exercises) {
      totals.exercises++;
      if (oldexercise.name == exercise.name) {
        oldexercise = exercise;
      }
      for (Sets sets in oldexercise.sets) {
        totals.sets += sets.sets;
        int reps_set = sets.sets * sets.reps;
        totals.weight += reps_set * sets.weight;
        totals.reps += reps_set;
      }
    totals.avgKgs = (totals.weight / totals.reps).roundToDouble();
    }
    print("UPDATE!");
    print(totals.sets);
    print(exercise.sets[0].sets);
    updateTotals();
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

class AddExerciseAlert extends StatelessWidget {
  ExerciseNameSelectionWidget nameWidget;
  RaisedGradientButton addExercise;
  AddExerciseAlert(this.addExercise, this.nameWidget);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Container(
        padding: EdgeInsets.all(15),
        height: screenHeight*0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("New Exercise",
              style: mediumTitleStyleWhite,
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: nameWidget
            ),
            Container(
              height: screenHeight*0.05,
              width: screenWidth*0.5,
              child: addExercise,
            ),
          ],
        ),
      ),
    );
  }
}

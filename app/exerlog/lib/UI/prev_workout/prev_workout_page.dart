
import 'package:exerlog/Bloc/exercise_bloc.dart';
import 'package:exerlog/Bloc/user_bloc.dart';
import 'package:exerlog/Bloc/workout_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/prev_workout_data.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/Models/workout_data.dart';
import 'package:exerlog/UI/calendar/calendar_page.dart';
import 'package:exerlog/UI/exercise/add_exercise_widget.dart';
import 'package:exerlog/UI/exercise/add_new_exercise_alert.dart';
import 'package:exerlog/UI/exercise/exercise_card.dart';
import 'package:exerlog/UI/exercise/totals_widget.dart';
import 'package:exerlog/UI/gradient_border_button.dart';
import 'package:exerlog/UI/workout/add_new_workout_alert.dart';
import 'package:exerlog/UI/workout/redo_workout_alert.dart';
import 'package:exerlog/UI/workout/save_workout_dialog.dart';
import 'package:exerlog/UI/workout/workout_name_selection_widget.dart';
import 'package:exerlog/UI/workout/workout_page.dart';
import 'package:exerlog/UI/workout/workout_toatals_widget.dart';
import 'package:flutter/material.dart';
import '../gradient_button.dart';
import '../global.dart';

class PrevWorkoutPage extends StatefulWidget {
  Workout workout;
  PrevWorkoutPage(this.workout);

  @override
  _PrevWorkoutPageState createState() => _PrevWorkoutPageState();
}

class _PrevWorkoutPageState extends State<PrevWorkoutPage> {
  late WorkoutTotalsWidget workoutTotalsWidget;
  late PrevWorkoutData workoutData;
  String exerciseName = '';
  late bool firstLoad;
  late Workout workout;

  @override
  void initState() {
    print("init");
    firstLoad = true;
    workout = new Workout(
      [],
      '',
      '',
      0,
      '',
      '',
      false,
    );
    // TODO: implement initState
    workoutData = new PrevWorkoutData(
        workout, new WorkoutTotals(0, 0, 0, 0, 0), updateTotals, addNewSet);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (firstLoad) {
      Future.delayed(Duration.zero, () => showAlertDialogWorkout(context));
    }
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    //workoutData.workout = workout;
    workoutTotalsWidget = new WorkoutTotalsWidget(totals: workoutData.totals);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CalendarPage(
                        ),
                      ),
                    );
          },
          color: greenTextColor
        ), 
      ),
      body: firstLoad
          ? Container(
              color: backgroundColor,
            )
          : GestureDetector(
              child: Container(
                color: backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    WorkoutTotalsWidget(
                      totals: workoutData.totals,
                    ),
                    Container(
                      height: screenHeight * 0.5,
                      child: ListView(
                        addAutomaticKeepAlives: true,
                        children: workoutData.exerciseWidgets,
                      ),
                    ),
                    Container(
                      height: screenHeight * 0.065,
                      width: screenWidth * 0.9,
                      margin: EdgeInsets.only(bottom: 30),
                      
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

  setWorkout(name, template) {
    workoutData.workout.name = name;
    workoutData.workout.template = template;
  }

  updateTotals(new_workout) {
    setState(() {
      firstLoad = false;
      //workoutData.workout = new_workout;
      //workout = new_workout;
      //print(workoutData.exerciseWidgets[0].setList.length);
    });
  }

  showAlertDialogExercise(BuildContext context) {
    ExerciseNameSelectionWidget exerciseNameSelectionWidget =
        new ExerciseNameSelectionWidget(
      setExercisename: setExercisename,
    );
    // set up the button
    RaisedGradientButton okButton = RaisedGradientButton(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFF34D1C2), Color(0xFF31A6DC)],
      ),
      radius: 30,
      child: Text(
        "ADD",
        style: buttonTextSmall,
      ),
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
    AddExerciseAlert alert =
        AddExerciseAlert(okButton, exerciseNameSelectionWidget);

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  addNewSet(exercise, newSet, id) {
    workoutData.addSet(exercise, newSet, id);
  }

  createNewSet(sets, id) {}

  showSaveWorkoutAlertDialog(BuildContext context) {
    RaisedGradientButton okButton = RaisedGradientButton(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFF34D1C2), Color(0xFF31A6DC)],
      ),
      radius: 30,
      child: Text(
        "SAVE",
        style: buttonTextSmall,
      ),
      onPressed: () {
        saveWorkout(workoutData.workout);
        setState(() {
          firstLoad = true;
          workoutData = new PrevWorkoutData(
              new Workout([], '', '', 0, '', '', false),
              new WorkoutTotals(0, 0, 0, 0, 0),
              updateTotals,
              addNewSet);
        });
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    SaveWorkoutAlert alert = SaveWorkoutAlert(okButton, setWorkout);

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  setWorkoutName(name) {
    workoutData.workout.name = name;
  }

  addExercises(new_workout) {
    setState(() {
      PrevWorkoutData newWorkoutData = new PrevWorkoutData(new_workout,
          new WorkoutTotals(0, 0, 0, 0, 0), updateTotals, addNewSet);
      firstLoad = false;
      workoutData = newWorkoutData;
      workout = newWorkoutData.workout;
      //print(workoutData.workout.exercises[0]);
    });
  }

  showAlertDialogWorkout(BuildContext context) {
    RaisedGradientButton viewButton = RaisedGradientButton(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFF34D1C2), Color(0xFF31A6DC)],
      ),
      radius: 30,
      child: Text(
        "VIEW",
        style: buttonTextSmall,
      ),
      onPressed: () {
        addExercises(widget.workout);
        Navigator.pop(context);
      },
    );

    GradientBorderButton redoButton = GradientBorderButton(
      addButton: false,
      borderSize: 2,
      gradient: LinearGradient(
        colors: <Color>[Color(0xFF34D1C2), Color(0xFF31A6DC)],
      ),
      radius: 30,
      child: Text(
        "REDO",
        style: whiteTextStyleSmall,
      ),
      onPressed: () {
        Navigator.pop(context);
        Navigator.of(context).pop();
          Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WorkoutPage(widget.workout!
                      ),
                    ),
                  );
      },
    );

    // set up the AlertDialog
    RedoWorkoutAlert alert =
        RedoWorkoutAlert(viewButton, redoButton);

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
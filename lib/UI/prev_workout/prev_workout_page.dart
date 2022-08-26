import 'package:exerlog/Bloc/workout_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/prev_workout_data.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/exercise/add_exercise_widget.dart';
import 'package:exerlog/UI/exercise/add_new_exercise_alert.dart';
import 'package:exerlog/UI/gradient_border_button.dart';
import 'package:exerlog/UI/prev_workout/delete_prev_workout_dialog.dart';
import 'package:exerlog/UI/workout/redo_workout_alert.dart';
import 'package:exerlog/UI/workout/save_workout_dialog.dart';
import 'package:exerlog/UI/workout/workout_page.dart';
import 'package:exerlog/UI/workout/workout_toatals_widget.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';

import '../../src/widgets/gradient_button.dart';
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
  late Workout newWorkout;

  @override
  void initState() {
    print("init");
    firstLoad = true;
    newWorkout = new Workout(
      [],
      '',
      '',
      0,
      '',
      '',
      false,
      0,
      0.0,
      0,
    );

    newWorkout.id = widget.workout.id;

    // TODO: implement initState
    workoutData = new PrevWorkoutData(
      newWorkout,
      new WorkoutTotals(0, 0, 0, 0, 0),
      updateTotals,
      addNewSet,
    );

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
    return ThemeProvider(
      builder: (context, theme) {
        return ThemeProvider(
          builder: (context, theme) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: theme.colorTheme.backgroundColorVariation,
                leading: BackButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: theme.colorTheme.primaryColor,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      showDeleteWorkoutAlertDialog(context);
                    },
                    child: Icon(
                      Icons.delete,
                      color: theme.colorTheme.primaryColor,
                    ),
                  )
                ],
              ),
              body: firstLoad
                  ? Container(
                      color: theme.colorTheme.backgroundColorVariation,
                    )
                  : GestureDetector(
                      child: Container(
                        color: theme.colorTheme.backgroundColorVariation,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            WorkoutTotalsWidget(
                              totals: workoutData.totals,
                            ),
                            Expanded(
                              child: Container(
                                //height: screenHeight * 0.5,
                                child: ListView(
                                  addAutomaticKeepAlives: true,
                                  children: workoutData.exerciseWidgets,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            );
          },
        );
      },
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
      radius: 30,
      child: Text(
        "ADD",
        style: buttonTextSmall,
      ),
      onPressed: () {
        if (exerciseName != '') {
          setState(() {
            workoutData
                .addExercise(new Exercise(exerciseName, [], [], 0, 0, 0.0));
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
            new Workout([], '', '', 0, '', '', false, 0, 0.0, 0),
            new WorkoutTotals(0, 0, 0, 0, 0),
            updateTotals,
            addNewSet,
          );
        });
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

  showDeleteWorkoutAlertDialog(BuildContext context) {
    RaisedGradientButton okButton = RaisedGradientButton(
      radius: 30,
      child: Text(
        "DELETE",
        style: buttonTextSmall,
      ),
      onPressed: () {
        deleteWorkout(workoutData.workout);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    DeleteWorkoutAlert alert = DeleteWorkoutAlert(okButton);

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
      PrevWorkoutData newWorkoutData = new PrevWorkoutData(
        new_workout,
        new WorkoutTotals(0, 0, 0, 0, 0),
        updateTotals,
        addNewSet,
      );
      firstLoad = false;
      workoutData = newWorkoutData;
      newWorkout = newWorkoutData.workout;
      //print(workoutData.workout.exercises[0]);
    });
  }

  showAlertDialogWorkout(BuildContext context) {
    RaisedGradientButton viewButton = RaisedGradientButton(
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
      radius: 30,
      child: Text(
        "REDO",
        style: whiteTextStyleSmall,
      ),
      onPressed: () {
        Navigator.pop(context);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => WorkoutPage(widget.workout),
          ),
        );
      },
    );

    // set up the AlertDialog
    RedoWorkoutAlert alert = RedoWorkoutAlert(viewButton, redoButton);

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

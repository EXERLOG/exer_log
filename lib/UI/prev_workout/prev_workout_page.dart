import 'package:exerlog/Bloc/workout_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/prev_workout_data.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/exercise/add_exercise_widget.dart';
import 'package:exerlog/UI/exercise/add_new_exercise_alert.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/gradient_border_button.dart';
import 'package:exerlog/UI/prev_workout/delete_prev_workout_dialog.dart';
import 'package:exerlog/UI/workout/redo_workout_alert.dart';
import 'package:exerlog/UI/workout/save_workout_dialog.dart';
import 'package:exerlog/UI/workout/workout_page.dart';
import 'package:exerlog/UI/workout/workout_toatals_widget.dart';
import 'package:exerlog/src/core/theme/app_theme.dart';
import 'package:exerlog/src/utils/logger/logger.dart';
import 'package:exerlog/src/widgets/gradient_button.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class PrevWorkoutPage extends StatefulWidget {

  PrevWorkoutPage(this.workout, {Key? key}) : super(key: key);
  Workout workout;

  @override
  PrevWorkoutPageState createState() => PrevWorkoutPageState();
}

class PrevWorkoutPageState extends State<PrevWorkoutPage> {
  late WorkoutTotalsWidget workoutTotalsWidget;
  late PrevWorkoutData workoutData;
  String exerciseName = '';
  late bool firstLoad;
  late Workout newWorkout;

  @override
  void initState() {
    Log.info('init');
    firstLoad = true;
    newWorkout = Workout(
      <Exercise>[],
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
    workoutData = PrevWorkoutData(
      newWorkout,
      WorkoutTotals(0, 0, 0, 0, 0),
      updateTotals,
      addNewSet,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (firstLoad) {
      Future<void>.delayed(Duration.zero, () => showAlertDialogWorkout(context));
    }
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    //workoutData.workout = workout;
    workoutTotalsWidget = WorkoutTotalsWidget(totals: workoutData.totals);
    return ThemeProvider(
      builder: (BuildContext context, AppTheme theme) {
        return ThemeProvider(
          builder: (BuildContext context, AppTheme theme) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: theme.colorTheme.backgroundColorVariation,
                leading: BackButton(
                  onPressed: Navigator.of(context).pop,
                  color: theme.colorTheme.primaryColor,
                ),
                actions: <Widget> [
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
                          children: <Widget>[
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

  setExercisename(String name) {
    exerciseName = name;
  }

  setWorkout(String name, bool template) {
    workoutData.workout.name = name;
    workoutData.workout.template = template;
  }

  updateTotals(Workout newWorkout) {
    setState(() {
      firstLoad = false;
    });
  }

  showAlertDialogExercise(BuildContext context) {
    ExerciseNameSelectionWidget exerciseNameSelectionWidget =
        ExerciseNameSelectionWidget(
      setExercisename: setExercisename,
    );
    // set up the button
    RaisedGradientButton okButton = RaisedGradientButton(
      radius: 30,
      child: Text(
        'ADD',
        style: buttonTextSmall,
      ),
      onPressed: () {
        if (exerciseName != '') {
          setState(() {
            workoutData
                .addExercise(Exercise(exerciseName, <Sets>[], <String>[], 0, 0, 0.0));
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

  addNewSet(Exercise exercise, Sets newSet, int id) {
    workoutData.addSet(exercise, newSet, id);
  }

  createNewSet(Sets sets, int id) {}

  showSaveWorkoutAlertDialog(BuildContext context) {
    RaisedGradientButton okButton = RaisedGradientButton(
      radius: 30,
      child: Text(
        'SAVE',
        style: buttonTextSmall,
      ),
      onPressed: () {
        saveWorkout(workoutData.workout);
        setState(() {
          firstLoad = true;
          workoutData = PrevWorkoutData(
            Workout(<Exercise>[], '', '', 0, '', '', false, 0, 0.0, 0),
            WorkoutTotals(0, 0, 0, 0, 0),
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
        'DELETE',
        style: buttonTextSmall,
      ),
      onPressed: () {
        deleteWorkout(workoutData.workout);
        Navigator.of(context)
          ..pop()
          ..pop();
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

  setWorkoutName(String name) {
    workoutData.workout.name = name;
  }

  addExercises(Workout newWorkout) {
    setState(() {
      PrevWorkoutData newWorkoutData = PrevWorkoutData(
        newWorkout,
        WorkoutTotals(0, 0, 0, 0, 0),
        updateTotals,
        addNewSet,
      );
      firstLoad = false;
      workoutData = newWorkoutData;
      newWorkout = newWorkoutData.workout;
    });
  }

  showAlertDialogWorkout(BuildContext context) {
    RaisedGradientButton viewButton = RaisedGradientButton(
      radius: 30,
      child: Text(
        'VIEW',
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
        'REDO',
        style: whiteTextStyleSmall,
      ),
      onPressed: () {
        Navigator.of(context)
          ..pop()
          ..pushReplacement(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => WorkoutPage(widget.workout),
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

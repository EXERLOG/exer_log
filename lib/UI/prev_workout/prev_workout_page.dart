import 'package:exerlog/Bloc/workout_bloc.dart';
import 'package:exerlog/Models/prev_workout_data.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/workout/workout_page.dart';
import 'package:exerlog/UI/workout/workout_toatals_widget.dart';
import 'package:exerlog/src/widgets/alert_dialogs/alert_dialogs.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class PrevWorkoutPage extends StatefulWidget {
  Workout workout;

  PrevWorkoutPage(this.workout);

  @override
  _PrevWorkoutPageState createState() => _PrevWorkoutPageState();
}

class _PrevWorkoutPageState extends State<PrevWorkoutPage> {
  late WorkoutTotalsWidget workoutTotalsWidget;
  late PrevWorkoutData workoutData;
  late bool firstLoad;
  late Workout newWorkout;

  @override
  void initState() {
    _prefillWorkoutData();
    super.initState();
  }

  void _prefillWorkoutData() {
    firstLoad = true;
    newWorkout = Workout(
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

    workoutData = PrevWorkoutData(
      newWorkout,
      WorkoutTotals(0, 0, 0, 0, 0),
      updateTotals,
      addNewSet,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (firstLoad) {
      Future.delayed(Duration.zero, () => _showViewOrRedoAlertDialog(context));
    }
    return ThemeProvider(
      builder: (context, theme) {
        screenHeight = MediaQuery.of(context).size.height;
        screenWidth = MediaQuery.of(context).size.width;
        workoutTotalsWidget = WorkoutTotalsWidget(totals: workoutData.totals);
        return Scaffold(
          backgroundColor: theme.colorTheme.backgroundColorVariation,
          appBar: AppBar(
            backgroundColor: theme.colorTheme.backgroundColorVariation,
            leading: BackButton(
              onPressed: Navigator.of(context).pop,
              color: theme.colorTheme.primaryColor,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _showDeleteWorkoutDialog(context);
                },
                child: Icon(
                  Icons.delete,
                  color: theme.colorTheme.primaryColor,
                ),
              )
            ],
          ),
          body: firstLoad
              ? Container(color: theme.colorTheme.backgroundColorVariation)
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
                          child: ListView(
                            addAutomaticKeepAlives: true,
                            children: workoutData.exerciseWidgets,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  void updateTotals(newWorkout) {
    setState(() {
      firstLoad = false;
    });
  }

  void addNewSet(exercise, newSet, id) {
    workoutData.addSet(exercise, newSet, id);
  }

  void addExercises(newWorkout) {
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

  Future<void> _showViewOrRedoAlertDialog(BuildContext context) async {
    if (await showViewOrRedoAlertDialog(context)) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => WorkoutPage(widget.workout),
        ),
      );
    } else {
      addExercises(widget.workout);
    }
  }

  Future<void> _showDeleteWorkoutDialog(BuildContext context) async {
    if (await showDeleteWorkoutDialog(context)) {
      deleteWorkout(workoutData.workout);
      Navigator.of(context).pop();
    }
  }
}

import 'package:exerlog/Bloc/workout_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/Models/workout_data.dart';
import 'package:exerlog/UI/exercise/add_exercise_widget.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/workout/add_new_workout_alert.dart';
import 'package:exerlog/UI/workout/save_workout_dialog.dart';
import 'package:exerlog/UI/workout/workout_name_selection_widget.dart';
import 'package:exerlog/UI/workout/workout_toatals_widget.dart';
import 'package:exerlog/src/core/theme/app_theme.dart';
import 'package:exerlog/src/widgets/alert_dialogs/alert_dialogs.dart';
import 'package:exerlog/src/widgets/custom_floating_action_button.dart';
import 'package:exerlog/src/widgets/gradient_button.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  WorkoutPage(this.workout);

  Workout? workout;

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  late WorkoutTotalsWidget workoutTotalsWidget;
  late WorkoutData workoutData;
  String exerciseName = '';
  late bool firstLoad;
  List workoutList = [];

  @override
  void initState() {
    _preFillWorkoutData();

    super.initState();
  }

  void _preFillWorkoutData() {
    if (widget.workout == null) {
      firstLoad = true;
      String id = '';

      widget.workout = Workout(
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
      widget.workout!.id = id;
      workoutData = WorkoutData(
        widget.workout!,
        WorkoutTotals(0, 0, 0, 0, 0),
        updateTotals,
      );
    } else {
      firstLoad = false;
      workoutData = WorkoutData(
        widget.workout!,
        WorkoutTotals(0, 0, 0, 0, 0),
        updateTotals,
      );
      addExercises(widget.workout);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      builder: (context, theme) {
        screenHeight = MediaQuery.of(context).size.height;
        screenWidth = MediaQuery.of(context).size.width;
        workoutTotalsWidget = WorkoutTotalsWidget(totals: workoutData.totals);
        return Scaffold(
          backgroundColor: theme.colorTheme.backgroundColorVariation,
          floatingActionButton: CustomFloatingActionButton(
            icon: Icons.add,
            onTap: () => _showAddNewExerciseDialog(context),
          ),
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: theme.colorTheme.backgroundColorVariation,
            leading: BackButton(
              onPressed: Navigator.of(context).pop,
              color: theme.colorTheme.primaryColor,
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 5),
                height: 30,
                width: 30,
                child: CustomFloatingActionButton(
                  icon: Icons.done,
                  onTap: () {
                    for (Exercise exercise in workoutData.workout.exercises) {
                      for (int i = 0; i < exercise.sets.length; i++) {
                        if (exercise.sets[i].reps == 0) {
                          exercise.sets.remove(exercise.sets[i]);
                        }
                      }
                      if (exercise.sets.length == 0) {
                        workoutData.workout.exercises.remove(exercise);
                      }
                    }
                    if (workoutData.workout.exercises.length > 0) {
                      showSaveWorkoutAlertDialog(context);
                    }
                  },
                ),
              ),
            ],
          ),
          body: firstLoad
              ? FutureBuilder(
                  future: getWorkoutTemplates(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Workout>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Something went wrong"),
                        );
                      } else {
                        if (snapshot.data!.isEmpty) {
                          firstLoad = false;
                          Future.delayed(Duration.zero,
                              () => _showAddNewExerciseDialog(context));
                          return getPage(theme);
                        } else {
                          firstLoad = false;
                          workoutList = snapshot.data!;
                          Future.delayed(Duration.zero,
                              () => showAlertDialogWorkout(context));
                          return getPage(theme);
                        }
                      }
                    }
                  })
              : getPage(theme),
        );
      },
    );
  }

  Widget getPage(AppTheme theme) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: firstLoad
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
  }

  void setExerciseName(name) {
    exerciseName = name;
  }

  void setWorkout(name, template) {
    workoutData.workout.name = name;
    workoutData.workout.template = template;
  }

  void updateTotals(newWorkout) {
    setState(() {});
  }

  void _showAddNewExerciseDialog(BuildContext context) async {
    ExerciseInputField exerciseNameSelectionWidget =
        ExerciseInputField(setExerciseName: setExerciseName);

    if (await showAddNewExerciseDialog(context, exerciseNameSelectionWidget)) {
      addExercise();
    }
  }

  void addExercise() {
    if (exerciseName != '') {
      workoutData.addExercise(
        Exercise(
          exerciseName,
          [],
          [],
          0,
          0,
          0.0,
        ),
      );
    }
  }

  void showSaveWorkoutAlertDialog(BuildContext context) {
    RaisedGradientButton okButton = RaisedGradientButton(
      child: Text(
        "SAVE",
        style: buttonTextSmall,
      ),
      onPressed: () {
        saveWorkout(workoutData.workout);
        Navigator.of(context)
          ..pop()
          ..pop();
      },
    );

    SaveWorkoutAlert alert = SaveWorkoutAlert(okButton, setWorkout);

    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void setWorkoutName(name) {
    workoutData.workout.name = name;
  }

  void addExercises(newWorkout) {
    setState(() {
      WorkoutData newWorkoutData = WorkoutData(
        newWorkout,
        WorkoutTotals(0, 0, 0, 0, 0),
        updateTotals,
      );
      firstLoad = false;
      workoutData = newWorkoutData;
      widget.workout = newWorkoutData.workout;
    });
  }

  void showAlertDialogWorkout(BuildContext context) {
    WorkoutTemplateSelectionWidget workoutTemplateSelectionWidget =
        WorkoutTemplateSelectionWidget(
      setWorkout: addExercises,
      workoutList: workoutList,
    );
    RaisedGradientButton okButton = RaisedGradientButton(
      child: Text(
        "START",
        style: buttonTextSmall,
      ),
      onPressed: () {
        setState(() {
          firstLoad = false;
        });
        Navigator.pop(context);
      },
    );

    AddWorkoutAlert alert = AddWorkoutAlert(
      okButton,
      workoutTemplateSelectionWidget,
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

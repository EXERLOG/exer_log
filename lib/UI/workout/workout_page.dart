import 'package:exerlog/Bloc/workout_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/Models/workout_data.dart';
import 'package:exerlog/UI/exercise/add_exercise_widget.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/workout/save_workout_dialog.dart';
import 'package:exerlog/UI/workout/workout_toatals_widget.dart';
import 'package:exerlog/src/core/theme/app_theme.dart';
import 'package:exerlog/src/widgets/alert_dialogs/alert_dialogs.dart';
import 'package:exerlog/src/widgets/custom_floating_action_button.dart';
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
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(
                  backgroundColor: theme.colorTheme.primaryColor,
                  child: IconButton(
                    icon: Icon(
                      Icons.done,
                      color: Colors.black,
                    ),
                    onPressed: () {
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
                        _showSaveWorkoutDialog(context);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          body: firstLoad
              ? FutureBuilder(
                  future: getWorkoutTemplates(),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<Workout>> snapshot,
                  ) {
                    /// Loading
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    /// Error
                    if (snapshot.hasError) {
                      return Center(child: Text("Something went wrong"));
                    }

                    firstLoad = false;
                    if (snapshot.data!.isNotEmpty) workoutList = snapshot.data!;
                    Future.delayed(
                      Duration.zero,
                      () {
                        _showAddNewExerciseDialog(context);
                      },
                    );
                    return getPage(theme);
                  },
                )
              : getPage(theme),
        );
      },
    );
  }

  Widget getPage(AppTheme theme) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: firstLoad
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

  /// Alert Dialogs
  void _showAddNewExerciseDialog(BuildContext context) async {
    ExerciseInputField exerciseNameSelectionWidget =
        ExerciseInputField(setExerciseName: setExerciseName);

    if (await showAddNewExerciseDialog(context, exerciseNameSelectionWidget)) {
      addExercise();
    }
  }

  void _showSaveWorkoutDialog(BuildContext context) async {
    if (await showSaveWorkoutDialog(context, SaveWorkoutContent(setWorkout))) {
      saveWorkout(workoutData.workout);
      Navigator.of(context).pop();
    }
  }
}

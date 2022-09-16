import 'package:exerlog/Bloc/exercise_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/exercise/exercise_card.dart';
import 'package:exerlog/UI/workout/workout_toatals_widget.dart';
import 'package:exerlog/src/utils/logger/logger.dart';
import 'package:flutter/widgets.dart';

class WorkoutData {

  WorkoutData(this.workout, this.totals, this.updateTotals) {
    workout = this.workout;

      loadWorkoutData().then((Workout value) {
        workout = value;
        setExerciseWidgets();
        updateExisitingExercise();
      });
  }

  Function(Workout) updateTotals;
  Workout workout;
  WorkoutTotals totals;
  List<ExerciseCard> exerciseWidgets = [];
  static int key = 0;

  addSet(exercise, newSet, id) {
    exercise.sets[id] = newSet;
    updateExisitingExercise();
  }

  removeSet(exercise, setToRemove,id) {
    exercise.sets.removeAt(id);
    exercise.setExerciseTotals();
    updateExisitingExercise();
    setExerciseWidgets();
    return exercise;
  }



  Future<Workout> loadWorkoutData() async {
    Workout loadedWorkout =
        Workout(workout.exercises, '', '', 0, '', '', true, 0, 0.0, 0);
        loadedWorkout.id = workout.id;
    List<Exercise> exerciseList = [];
    List<Exercise> newExerciseList = [];
    try {
      for (String exerciseId in workout.exercises) {
        await getSpecificExercise(exerciseId)
            .then((Exercise value) async => {exerciseList.add(value)});
      }
      Future.delayed(const Duration(seconds: 3));
      int totalSets = 0;
      int totalReps = 0;
      double totalKgs = 0;
      int reps = 0;
      for (Exercise exercise in exerciseList) {
        await getExerciseByName(exercise.name).then(
          (Exercise newexercise) => {
            for (Sets sets in newexercise.sets)
              {
                totalSets += sets.sets,
                reps = sets.sets * sets.reps,
                totalReps += reps,
                totalKgs += reps * sets.weight
              },
            updateExisitingExercise(),
            newExerciseList.add(newexercise)
          },
        );
      }
      loadedWorkout.exercises = newExerciseList;
    } catch (exception) {
      Log.debug(exception.toString());
    }
    return loadedWorkout;
  }

  List<ExerciseCard> setExerciseWidgets() {
    exerciseWidgets = [];
    for (Exercise exercise in workout.exercises) {
      exerciseWidgets.add(
        ExerciseCard(
          name: exercise.name,
          exercise: exercise,
          addExercise: addExercise,
          updateExisitingExercise: updateExisitingExercise,
          removeExercise: removeExercise,
          removeSet: removeSet,
          isTemplate: workout.template,
          workoutData: this,
          key: ValueKey(key),
          totalsWidget: exercise.totalWidget,
        ),
      );
      key++;
      for (Sets sets in exercise.sets) {
        totals.sets += sets.sets;
        int repsSet = sets.sets * sets.reps;
        totals.weight += repsSet * sets.weight;
        totals.reps += repsSet;
        totals.avgKgs = (totals.weight / totals.reps).roundToDouble();
      }
    }

    return exerciseWidgets;
  }

  updateExisitingExercise() {
    try {
      totals = WorkoutTotals(0, 0, 0, 0, 0);
      for (Exercise oldexercise in workout.exercises) {
        totals.exercises++;
        for (Sets sets in oldexercise.sets) {
          totals.sets += sets.sets;
          int repsSet = sets.sets * sets.reps;
          totals.weight += repsSet * sets.weight;
          totals.reps += repsSet;
        }
        totals.avgKgs = (totals.weight / totals.reps).roundToDouble();
        oldexercise.setExerciseTotals();
      }
      updateTotals(workout);
    } catch (exception) {
      Log.debug('problem:$exception');
    }
  }

  removeExercise(exercise) async {
    workout.exercises.remove(exercise);
    setExerciseWidgets();
    updateTotals(workout);
  }

  addExercise(exercise) async {
    try {
      for (Exercise existingExercise in workout.exercises) {
        if (existingExercise.name == exercise.name) {
          existingExercise = exercise;
          return;
        }
      }

      if (exercise.name != '') {
        await getExerciseByName(exercise.name).then(
          (Exercise value) =>
              {workout.exercises.add(value), setExerciseWidgets()},
        );
      }
    } catch (exception) {
      Log.debug(exception.toString());
      if (exercise.name != '') {
        workout.exercises.add(exercise);
        setExerciseWidgets();
      }
    }
    updateTotals(workout);
  }
}

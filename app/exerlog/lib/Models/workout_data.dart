import 'package:exerlog/Bloc/exercise_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/exercise/exercise_card.dart';
import 'package:exerlog/UI/exercise/set_widget.dart';
import 'package:exerlog/UI/exercise/totals_widget.dart';
import 'package:exerlog/UI/workout/workout_toatals_widget.dart';
import 'package:flutter/widgets.dart';

class WorkoutData {
  Function(Workout) updateTotals;
  Workout workout;
  WorkoutTotals totals;
  List<ExerciseCard> exerciseWidgets = [];
  static int key = 0;

  WorkoutData(this.workout, this.totals, this.updateTotals) {
    workout = this.workout;
  
      loadWorkoutData().then((value) {
        workout = value;
        setExerciseWidgets();
        updateExisitingExercise();
      });
  }

  addSet(exercise, newSet, id) {
    exercise.sets[id] = newSet;
    //updateExisitingExercise(exercise);
    updateExisitingExercise();
    //setExerciseWidgets();
  }

  removeSet(exercise, setToRemove,id) {
    exercise.sets.removeAt(id);
    exercise.setExerciseTotals();
    updateExisitingExercise();
    setExerciseWidgets();
    return exercise;
  }



  Future<Workout> loadWorkoutData() async {
    Workout loaded_workout =
        new Workout(workout.exercises, '', '', 0, '', '', true, 0, 0.0, 0);
        loaded_workout.id = workout.id;
    List<Exercise> exerciseList = [];
    List<Exercise> newExerciseList = [];
    try {
      for (String exercise_id in workout.exercises) {
        await getSpecificExercise(exercise_id)
            .then((value) async => {exerciseList.add(value)});
      }
      Future.delayed(Duration(seconds: 3));
      int totalSets = 0;
      int totalReps = 0;
      double totalKgs = 0;
      int reps = 0;
      double avgKgs = 0;
      for (Exercise exercise in exerciseList) {
        await getExerciseByName(exercise.name).then((newexercise) => {
              for (Sets sets in newexercise.sets)
                {
                  totalSets += sets.sets,
                  reps = sets.sets * sets.reps,
                  totalReps += reps,
                  totalKgs += reps * sets.weight
                },
              avgKgs = (totalKgs / totalReps).roundToDouble(),
              updateExisitingExercise(),
              newExerciseList.add(newexercise)
            });
      }
      loaded_workout.exercises = newExerciseList;
      //workout = loaded_workout;
    } catch (Exception) {
      print("Helloooo");
      print(Exception);
    }
    return loaded_workout;
    //updateTotals(loaded_workout);
    //print(loaded_workout.exercises[0]);
  }

  List<ExerciseCard> setExerciseWidgets() {
    exerciseWidgets = [];
    for (Exercise exercise in workout.exercises) {
      List<SetWidget> setList = [];
      int i = 0;
      exerciseWidgets.add(new ExerciseCard(
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
      ));
      key++;
      for (Sets sets in exercise.sets) {

        totals.sets += sets.sets;
        int reps_set = sets.sets * sets.reps;
        totals.weight += reps_set * sets.weight;
        totals.reps += reps_set;
        totals.avgKgs = (totals.weight / totals.reps).roundToDouble();
        i++;
      }
    }
    return exerciseWidgets;
  }

  updateExisitingExercise() {
    try {
      totals = new WorkoutTotals(0, 0, 0, 0, 0);
      for (Exercise oldexercise in workout.exercises) {  
        totals.exercises++;
        for (Sets sets in oldexercise.sets) {
          totals.sets += sets.sets;
          int reps_set = sets.sets * sets.reps;
          totals.weight += reps_set * sets.weight;
          totals.reps += reps_set;
        }
        totals.avgKgs = (totals.weight / totals.reps).roundToDouble();
        oldexercise.setExerciseTotals();
      }
      //setTotals(exercise);
      updateTotals(workout);
    } catch (Exception) {
      print("problem");
      print(Exception);
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

      List exercises = workout.exercises;

      if (exercise.name != '') {
        await getExerciseByName(exercise.name).then((value) => {
          workout.exercises.add(value),
          setExerciseWidgets()
        });
      }
    } catch (Exception) {
      print(Exception);
      if (exercise.name != '') { 
        workout.exercises.add(exercise);
        setExerciseWidgets();
      }
    }
    updateTotals(workout);
  }
}

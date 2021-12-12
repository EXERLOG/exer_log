import 'package:exerlog/Bloc/exercise_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/exercise/exercise_card.dart';
import 'package:exerlog/UI/workout/workout_toatals_widget.dart';

class WorkoutData {
  Function(Workout) updateTotals;
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
        updateExisitingExercise: updateExisitingExercise,
        isTemplate: workout.template,
      ));
    }
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
    updateTotals(workout);
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
    updateTotals(workout);
  }
}

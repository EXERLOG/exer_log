import 'package:exerlog/Bloc/exercise_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/prev_workout/prev_exercise_card.dart';
import 'package:exerlog/UI/prev_workout/prev_set_widget.dart';
import 'package:exerlog/UI/workout/workout_toatals_widget.dart';
import 'package:exerlog/src/utils/logger/logger.dart';

class PrevWorkoutData {
  Function(Workout) updateTotals;
  Workout workout;
  WorkoutTotals totals;
  Function(Exercise, Sets, int) addNewSet;
  List<PrevExerciseCard> exerciseWidgets = [];

  PrevWorkoutData(this.workout, this.totals, this.updateTotals, this.addNewSet) {
    workout = this.workout;

      loadWorkoutData().then((value) {
        workout = value;
        setExerciseWidgets();
        for (Exercise exercise in this.workout.exercises) {
          updateExisitingExercise(exercise);
        }
      });
  }

  addSet(exercise, newSet, id) {
    exercise.sets[id] = newSet;
    updateExisitingExercise(exercise);
  }

  Future<Workout> loadWorkoutData() async {
    Workout loadedWorkout =
        new Workout(workout.exercises, '', '', 0, '', '', true, 0, 0.0, 0);
    loadedWorkout.id = workout.id;
    List<Exercise> exerciseList = [];
    int totalSets = 0;
    int totalReps = 0;
    double totalKgs = 0;
    int reps = 0;
    try {
      for (String exerciseId in workout.exercises) {
        await loadExercise(exerciseId)
            .then((value) async => {
              exerciseList.add(value),
              for (Sets sets in value.sets)
                {
                  totalSets += sets.sets,
                  reps = sets.reps * sets.sets,
                  totalReps += reps,
                  totalKgs += reps * sets.weight,
                },
              });
      }
      loadedWorkout.exercises = exerciseList;

    } catch (exception) {
      Log.debug(exception.toString());
    }
    return loadedWorkout;
  }

  List<PrevExerciseCard> setExerciseWidgets() {
    exerciseWidgets = [];
    for (Exercise exercise in workout.exercises) {
      List<PrevSetWidget> setList = [];
      int i = 0;
      for (Sets _ in exercise.sets) {
        setList.add(new PrevSetWidget(
            name: exercise.name,
            exercise: exercise,
            addNewSet: addSet,
            id: i,
            isTemplate: workout.template));
        i++;
      }
      exerciseWidgets.add(new PrevExerciseCard(
        name: exercise.name,
        exercise: exercise,
        addExercise: addExercise,
        updateExisitingExercise: updateExisitingExercise,
        isTemplate: workout.template,
        setList: setList,
        prevworkoutData: this,
      ));
    }
    return exerciseWidgets;
  }

  updateExisitingExercise(exercise) {
    try {
      totals = new WorkoutTotals(0, 0, 0, 0, 0);
      for (Exercise oldexercise in workout.exercises) {
        totals.exercises++;
        if (oldexercise.name == exercise.name) {
          oldexercise = exercise;
        }
        for (Sets sets in oldexercise.sets) {
          totals.sets += sets.sets;
          int repsSet = sets.sets * sets.reps;
          totals.weight += repsSet * sets.weight;
          totals.reps += repsSet;
        }
        totals.avgKgs = (totals.weight / totals.reps).roundToDouble();
      }
      updateTotals(workout);
    } catch (exception) {
      Log.debug("problem:"+exception.toString());
    }
  }

  addExercise(exercise) {
    try {
      for (Exercise existingExercise in workout.exercises) {
        if (existingExercise.name == exercise.name) {
          existingExercise = exercise;
          return;
        }
      }

      if (exercise.name != '') {
        workout.exercises.add(exercise);
      }
    } catch (exception) {
      Log.debug(exception.toString());
    }
    updateTotals(workout);
  }
}

import 'package:exerlog/Bloc/exercise_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/prev_workout/prev_exercise_card.dart';
import 'package:exerlog/UI/prev_workout/prev_set_widget.dart';
import 'package:exerlog/UI/workout/workout_toatals_widget.dart';
import 'package:exerlog/src/utils/logger/logger.dart';

class PrevWorkoutData {

  PrevWorkoutData(this.workout, this.totals, this.updateTotals, this.addNewSet) {

    workout = workout;

      loadWorkoutData().then((Workout value) {
        workout = value;
        setExerciseWidgets();
        for (Exercise exercise in workout.exercises) {
          updateExisitingExercise(exercise);
        }

      });
  }
  Function(Workout) updateTotals;
  Workout workout;
  WorkoutTotals totals;
  Function(Exercise, Sets, int) addNewSet;
  List<PrevExerciseCard> exerciseWidgets = <PrevExerciseCard>[];

  addSet(Exercise exercise, Sets newSet, int id) {
    exercise.sets[id] = newSet;
    updateExisitingExercise(exercise);
  }

  Future<Workout> loadWorkoutData() async {

    Workout loadedWorkout =
        Workout(workout.exercises, '', '', 0, '', '', true, 0, 0.0, 0);

    loadedWorkout.id = workout.id;
    List<Exercise> exerciseList = <Exercise>[];
    int totalSets = 0;
    int totalReps = 0;
    double totalKgs = 0;
    int reps = 0;

    List<String> toRemove = <String>[];
    for (String exerciseId in workout.exercises) {
      try {
        await loadExercise(exerciseId).then(
          (Exercise value) async => <void> {
            exerciseList.add(value),
            for (Sets sets in value.sets)
              <void>{
                totalSets += sets.sets,
                reps = sets.reps * sets.sets,
                totalReps += reps,
                totalKgs += reps * sets.weight,
              },
          },
        );
      } catch (exception) {
        toRemove.add(exerciseId);
        Log.debug('load workout error:' + exception.toString());
      }
    }

    workout.exercises.removeWhere((dynamic e) => toRemove.contains(e));

    loadedWorkout.exercises = exerciseList;

    return loadedWorkout;
  }

  List<PrevExerciseCard> setExerciseWidgets() {
    exerciseWidgets = <PrevExerciseCard> [];
    for (Exercise exercise in workout.exercises) {
      List<PrevSetWidget> setList = <PrevSetWidget>[];
      int i = 0;
      for (Sets _ in exercise.sets) {
        setList.add(
          PrevSetWidget(
            name: exercise.name,
            exercise: exercise,
            addNewSet: addSet,
            id: i,
            isTemplate: workout.template,
          ),
        );
        i++;
      }
      exerciseWidgets.add(
        PrevExerciseCard(
          name: exercise.name,
          exercise: exercise,
          addExercise: addExercise,
          updateExisitingExercise: updateExisitingExercise,
          isTemplate: workout.template,
          setList: setList,
          prevworkoutData: this,
        ),
      );
    }

    return exerciseWidgets;
  }

  updateExisitingExercise(Exercise exercise) {
    try {
      totals = WorkoutTotals(0, 0, 0, 0, 0);
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
      Log.debug('problem:$exception');
    }
  }

  addExercise(Exercise exercise) {
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

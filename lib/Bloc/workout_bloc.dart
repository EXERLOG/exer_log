import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exerlog/Bloc/exercise_bloc.dart';
import 'package:exerlog/Bloc/user_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/src/core/base/shared_preference/shared_preference_b.dart';

Future<Workout> getSpecificWorkout(String id) async {
  final data = FirebaseFirestore.instance
      .collection('users')
      .doc(SharedPref.getStringAsync(USER_UID))
      .collection('workouts')
      .doc(id)
      .withConverter<Workout>(
        fromFirestore: (snapshot, _) => Workout.fromJson(snapshot.data()!),
        toFirestore: (workout, _) => workout.toJson(),
      );
  Workout workout = await data.get().then((value) => value.data()!);
  workout.id = id;
  return workout;
}

Future<List<Workout>> getWorkoutsWithinDates(DateTime startDate, DateTime endDate) async {
  final ref = await FirebaseFirestore.instance
      .collection('users')
      .doc(SharedPref.getStringAsync(USER_UID))
      .collection('workouts')
      .where('date', isGreaterThanOrEqualTo: startDate).where('date', isLessThanOrEqualTo: endDate).get();

  List<Workout> workoutList = [];
  for (int i = 0; i < ref.docs.length; i++) {
    Workout workout = Workout.fromJsonQuery(ref.docs[i]);
    workout.id = ref.docs[i].id;
    workoutList.add(workout);
  }
  return workoutList;
}

Stream<QuerySnapshot<Map<String, dynamic>>> getWorkoutOnDate(DateTime after, DateTime before) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(SharedPref.getStringAsync(USER_UID))
      .collection('workouts')
      .where('date', isLessThan: after)
      .where('date', isGreaterThan: before)
      .snapshots();
}

Future<Workout> loadWorkout(Workout workout) async {
  List<Exercise> exerciseList = [];
  for (int i = 0; i < workout.exercises.length; i++) {
    Exercise exercise = await loadExercise(workout.exercises[i]);
    exerciseList.add(exercise);
  }
  workout.exercises = exerciseList;
  return workout;
}

Future<List<Workout>> getWorkoutTemplates() async {
  final ref = await FirebaseFirestore.instance
      .collection('users')
      .doc(SharedPref.getStringAsync(USER_UID))
      .collection('workouts')
      .where('template', isEqualTo: true)
      .get();
  List<Workout> workoutTemplates = [];

  for (int i = 0; i < ref.docs.length; i++) {
    final data = FirebaseFirestore.instance
        .collection('users')
        .doc(SharedPref.getStringAsync(USER_UID))
        .collection('workouts')
        .doc(ref.docs[i].id)
        .withConverter<Workout>(
          fromFirestore: (snapshot, _) => Workout.fromJson(snapshot.data()!),
          toFirestore: (max, _) => max.toJson(),
        );
    Workout workout = await data.get().then((value) => value.data()!);
    workout.id = data.id;
    if (!workoutTemplates.contains(workout)) {
      workoutTemplates.add(workout);
    }
  }
  return workoutTemplates;
}

void saveWorkout(Workout workout) async {
  List exerciseList = [];
  for (Exercise exercise in workout.exercises) {
    exercise.setExerciseTotals();
    exerciseList.add(await saveExercise(exercise));
  }
  workout.setWorkoutTotals();
  workout.exercises = exerciseList;
  Map<String, Object?> jsonWorkout = workout.toJson();
  firestoreInstance
      .collection('users')
      .doc(SharedPref.getStringAsync(USER_UID))
      .collection('workouts')
      .add(jsonWorkout)
      .then((value) {
  });

  //databaseRef.push().set(workout.toJson());
}

void deleteWorkout(Workout workout) async {
  for (Exercise exercise in workout.exercises) {
    deleteExercise(exercise);
  }
  await firestoreInstance
      .collection('users')
      .doc(SharedPref.getStringAsync(USER_UID))
      .collection('workouts')
      .doc(workout.id)
      .delete();
}

void printFirebase() {
  //
}

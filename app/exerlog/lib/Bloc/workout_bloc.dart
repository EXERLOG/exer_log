import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exerlog/Bloc/exercise_bloc.dart';
import 'package:exerlog/Bloc/user_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/workout.dart';

import '../main.dart';

deleteWorkout() {}

Future<Workout> getSpecificWorkout(String id) async {
  final data = FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('workouts')
      .doc(id)
      .withConverter<Workout>(
        fromFirestore: (snapshot, _) => Workout.fromJson(snapshot.data()!),
        toFirestore: (workout, _) => workout.toJson(),
      );
  Workout workout = await data.get().then((value) => value.data()!);
  return workout;
}

Future<Workout> getSpecificWorkoutToReplace(String id) async {
  final data = FirebaseFirestore.instance
      .collection('users')
      .doc("KGjuifVkeop9CFHmTIHU")
      .collection('workouts')
      .doc(id)
      .withConverter<Workout>(
        fromFirestore: (snapshot, _) => Workout.fromJson(snapshot.data()!),
        toFirestore: (workout, _) => workout.toJson(),
      );
  Workout workout = await data.get().then((value) => value.data()!);
  return workout;
}

Future<List<Workout>> getWorkoutTemplates() async {
  final ref = await FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection("workouts")
      .where('template', isEqualTo: true)
      .get();
  List<Workout> workoutTemplates = [];

  for (int i = 0; i < ref.docs.length; i++) {
    final data = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('workouts')
        .doc(ref.docs[i].id)
        .withConverter<Workout>(
          fromFirestore: (snapshot, _) => Workout.fromJson(snapshot.data()!),
          toFirestore: (max, _) => max.toJson(),
        );
    Workout workout = await data.get().then((value) => value.data()!);
    if (!workoutTemplates.contains(workout)) {
      workoutTemplates.add(workout);
    }
  }
  return workoutTemplates;
}

void replaceWorkouts() async {
  final ref = await FirebaseFirestore.instance
      .collection('users')
      .doc("KGjuifVkeop9CFHmTIHU")
      .collection('workouts')
      .get();
  List<Workout> workoutList = [];
  for (int i = 0; i < ref.docs.length; i++) {
    List<Exercise> exerciseList = [];
    Workout workout = await getSpecificWorkoutToReplace(ref.docs[i].id);
    for (int i = 0; i < workout.exercises.length; i++) {
      exerciseList.add(await getSpecificExerciseToReplace(workout.exercises[i]));
      print(exerciseList[i].name);
    }
    workout.exercises = exerciseList;
    saveWorkout(workout);
  }
}

void saveWorkout(Workout workout) async {
  List exerciseList = [];
  for (Exercise exercise in workout.exercises) {
    exerciseList.add(await saveExercise(exercise));
  }
  workout.exercises = exerciseList;
  Map<String, Object?> jsonWorkout = workout.toJson();
  firestoreInstance
      .collection("users")
      .doc(userID)
      .collection("workouts")
      .add(jsonWorkout)
      .then((value) {
    print(value.id);
  });

  //databaseRef.push().set(workout.toJson());
}

void printFirebase() {
  //
}

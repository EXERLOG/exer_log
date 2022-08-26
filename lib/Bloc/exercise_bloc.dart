import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exerlog/Bloc/max_bloc.dart';
import 'package:exerlog/Bloc/user_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/sets.dart';

import '../main.dart';

Future<Exercise> getSpecificExercise(String id) async {
  final data = FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('exercises')
      .doc(id)
      .withConverter<Exercise>(
        fromFirestore: (snapshot, _) => Exercise.fromJson(snapshot.data()!),
        toFirestore: (exercise, _) => exercise.toJson(),
      );
  Exercise exercise = await data.get().then((value) => value.data()!);
  exercise.id = data.id;
  return exercise;
}


Future<List<String>> getExerciseNames() async {
  final ref = await FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('exercises')
      .get();
  List<String> exerciseNames = [];

  for (int i = 0; i < ref.docs.length; i++) {
    String name = ref.docs[i].get("name");
    if (!exerciseNames.contains(name)) {
      exerciseNames.add(name);
    }
  }
  return exerciseNames;
}

Future<Exercise> loadExercise(String id) async {
  final data = FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('exercises')
      .doc(id)
      .withConverter<Exercise>(
        fromFirestore: (snapshot, _) => Exercise.fromJson(snapshot.data()!),
        toFirestore: (exercise, _) => exercise.toJson(),
      );
  Exercise exercise = await data.get().then((value) => value.data()!);
  exercise.id = data.id;
  List<Sets> setList = [];
  for (int i = 0; i < exercise.sets.length; i++) {
    Sets set_ = Sets.fromString(exercise.sets[i]);
    setList.add(set_);
  }
  exercise.sets = setList;
  return exercise;
}

Future<Exercise> getExerciseByName(String exercise) async {
  final ref = await FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('exercises')
      .where('name', isEqualTo: exercise)
      .orderBy('created', descending: false)
      .get();

  Exercise theExercise = Exercise.fromJson(ref.docs.last.data());
  List<Sets> setList = [];
  for (int i = 0; i < theExercise.sets.length; i++) {
    Sets set_ = Sets.fromString(theExercise.sets[i]);
    setList.add(set_);
  }
  theExercise.sets = setList;
  return theExercise;
}

Future<String> saveExercise(Exercise exercise) async {
  Map<String, Object?> jsonExercise = exercise.toJson();
  final ref = await firestoreInstance
      .collection("users")
      .doc(userID)
      .collection("exercises")
      .doc();
  await ref.set(jsonExercise);
  exercise.id = ref.id;
  checkMax(exercise);
  return ref.id;
}

void deleteExercise(Exercise exercise) async {
  //checkRemoveMax(exercise);
  await firestoreInstance
      .collection("users")
      .doc(userID)
      .collection("exercises")
      .doc(exercise.id)
      .delete();
  deleteMax(exercise);
}

void updateExercise(String id, Exercise exercise) {}

void printFirebase() {
  //
}

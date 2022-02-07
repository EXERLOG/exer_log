import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exerlog/Bloc/max_bloc.dart';
import 'package:exerlog/Bloc/user_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/Models/workout.dart';

import '../main.dart';

deleteExercise() {}

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
  return exercise;
}
Future<Exercise> getSpecificExerciseToReplace(String id) async {
  final data = FirebaseFirestore.instance
      .collection('users')
      .doc("KGjuifVkeop9CFHmTIHU")
      .collection('exercises')
      .doc(id)
      .withConverter<Exercise>(
        fromFirestore: (snapshot, _) => Exercise.fromJson(snapshot.data()!),
        toFirestore: (exercise, _) => exercise.toJson(),
      );
  Exercise exercise = await data.get().then((value) => value.data()!);
  List<Sets> setList = [];
  for (int i = 0; i < exercise.sets.length; i++) {
    setList.add(Sets.fromString(exercise.sets[i]));
  }
  exercise.sets = setList;
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

Future<Exercise> getExerciseByName(String exercise) async {
  final ref = await FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('exercises')
      .where('name', isEqualTo: exercise)
      .orderBy('created', descending: false)
      .get();

  final data = FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('exercises')
      .doc(ref.docs.last.id)
      .withConverter<Exercise>(
        fromFirestore: (snapshot, _) => Exercise.fromJson(snapshot.data()!),
        toFirestore: (max, _) => max.toJson(),
      );
  return await data.get().then((value) => value.data()!);
}

Future<String> saveExercise(Exercise exercise) async {
  checkMax(exercise);
  Map<String, Object?> jsonExercise = exercise.toJson();
  final ref = await firestoreInstance
      .collection("users")
      .doc(userID)
      .collection("exercises")
      .doc();
  await ref.set(jsonExercise);
  return ref.id;
}

void updateExercise(String id, Exercise exercise) {}

void printFirebase() {
  //
}

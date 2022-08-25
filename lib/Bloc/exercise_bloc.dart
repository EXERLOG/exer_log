import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exerlog/Bloc/max_bloc.dart';
import 'package:exerlog/Bloc/user_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/sets.dart';

import '../src/core/base/shared_preference/shared_preference_b.dart';


Future<Exercise> getSpecificExercise(String id) async {
  final data = FirebaseFirestore.instance
      .collection('users')
      .doc(SharedPref.getStringAsync('USER_UID'))
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
      .doc(SharedPref.getStringAsync('USER_UID'))
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
      .doc(SharedPref.getStringAsync('USER_UID'))
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
      .doc(SharedPref.getStringAsync('USER_UID'))
      .collection('exercises')
      .where('name', isEqualTo: exercise)
      .orderBy('created', descending: false)
      .get();

  Exercise the_exercise = Exercise.fromJson(ref.docs.last.data());
  List<Sets> setList = [];
  for (int i = 0; i < the_exercise.sets.length; i++) {
    Sets set_ = Sets.fromString(the_exercise.sets[i]);
    setList.add(set_);
  }
  the_exercise.sets = setList;
  return the_exercise;
}

Future<String> saveExercise(Exercise exercise) async {
  Map<String, Object?> jsonExercise = exercise.toJson();
  final ref = await firestoreInstance
      .collection("users")
      .doc(SharedPref.getStringAsync('USER_UID'))
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
      .doc(SharedPref.getStringAsync('USER_UID'))
      .collection("exercises")
      .doc(exercise.id)
      .delete();
  deleteMax(exercise);
}

void updateExercise(String id, Exercise exercise) {}

void printFirebase() {
  //
}

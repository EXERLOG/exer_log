import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exerlog/Bloc/max_bloc.dart';
import 'package:exerlog/Bloc/user_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/src/core/base/shared_preference/shared_preference_b.dart';


Future<Exercise> getSpecificExercise(String id) async {
  final DocumentReference<Exercise> data = FirebaseFirestore.instance
      .collection('users')
      .doc(SharedPref.getStringAsync(USER_UID))
      .collection('exercises')
      .doc(id)
      .withConverter<Exercise>(
        fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot, _) => Exercise.fromJson(snapshot.data()!),
        toFirestore: (Exercise exercise, _) => exercise.toJson(),
      );
  Exercise exercise = await data.get().then((DocumentSnapshot<Exercise> value) => value.data()!);
  exercise.id = data.id;
  return exercise;
}


Future<List<String>> getExerciseNames() async {
  final QuerySnapshot<Map<String, dynamic>> ref = await FirebaseFirestore.instance
      .collection('users')
      .doc(SharedPref.getStringAsync(USER_UID))
      .collection('exercises')
      .get();

  List<String> exerciseNames = <String>[];

  for (int i = 0; i < ref.docs.length; i++) {
    String name = ref.docs[i].get('name');
    if (!exerciseNames.contains(name)) {
      exerciseNames.add(name);
    }
  }
  return exerciseNames;
}

Future<Exercise> loadExercise(String id) async {
  final DocumentReference<Exercise> data = FirebaseFirestore.instance
      .collection('users')
      .doc(SharedPref.getStringAsync(USER_UID))
      .collection('exercises')
      .doc(id)
      .withConverter<Exercise>(
        fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot, _) => Exercise.fromJson(snapshot.data()!),
        toFirestore: (Exercise exercise, _) => exercise.toJson(),
      );
  Exercise exercise = await data.get().then((DocumentSnapshot<Exercise> value) => value.data()!);
  exercise.id = data.id;
  List<Sets> setList = <Sets>[];
  for (int i = 0; i < exercise.sets.length; i++) {
    Sets set_ = Sets.fromString(exercise.sets[i]);
    setList.add(set_);
  }
  exercise.sets = setList;
  return exercise;
}

Future<Exercise> getExerciseByName(String exercise) async {
  final QuerySnapshot<Map<String, dynamic>> ref = await FirebaseFirestore.instance
      .collection('users')
      .doc(SharedPref.getStringAsync(USER_UID))
      .collection('exercises')
      .where('name', isEqualTo: exercise)
      .orderBy('created', descending: false)
      .get();

  Exercise theExercise = Exercise.fromJson(ref.docs.last.data());
  List<Sets> setList = <Sets>[];
  for (int i = 0; i < theExercise.sets.length; i++) {
    Sets set_ = Sets.fromString(theExercise.sets[i]);
    setList.add(set_);
  }
  theExercise.sets = setList;
  return theExercise;
}

Future<String> saveExercise(Exercise exercise) async {
  Map<String, Object?> jsonExercise = exercise.toJson();
  final DocumentReference<Map<String, dynamic>> ref = await firestoreInstance
      .collection('users')
      .doc(SharedPref.getStringAsync(USER_UID))
      .collection('exercises')
      .doc();
  await ref.set(jsonExercise);
  exercise.id = ref.id;
  checkMax(exercise);
  return ref.id;
}

void deleteExercise(Exercise exercise) async {
  await firestoreInstance
      .collection('users')
      .doc(SharedPref.getStringAsync(USER_UID))
      .collection('exercises')
      .doc(exercise.id)
      .delete();
  deleteMax(exercise);
}

void updateExercise(String id, Exercise exercise) {}

void printFirebase() {
  //
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exerlog/Bloc/user_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/workout.dart';

import '../main.dart';


deleteExercise() {}


Future<Exercise> getSpecificExercise(String id) async {
  final data = FirebaseFirestore.instance.collection('users').doc(userID).collection('exercises').doc(id).withConverter<Exercise>(
      fromFirestore: (snapshot, _) => Exercise.fromJson(snapshot.data()!),
      toFirestore: (exercise, _) => exercise.toJson(),
    );
  Exercise exercise = await data.get().then((value) => value.data()!);
  return exercise;
}

//void getExercise() async {

 // final data = await FirebaseFirestore.instance.collection('users').doc('pbAyI1OvjxxfL5TjReGZ').get();
  //print(data);
//}
  
Future<String> saveExercise(Exercise exercise) async {
  Map<String, Object?> jsonExercise = exercise.toJson();
  final ref = await firestoreInstance.collection("users").doc(userID).collection("exercises").doc(); 
  await ref.set(jsonExercise);
  return ref.id;
}

void updateExercise(String id, Exercise exercise) {

}

  void printFirebase(){
    //
}
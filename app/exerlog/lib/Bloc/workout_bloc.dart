
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exerlog/Bloc/exercise_bloc.dart';
import 'package:exerlog/Bloc/user_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/workout.dart';

import '../main.dart';


deleteWorkout() {}




Future<Workout> getSpecificWorkout(String id) async {
  final data = await FirebaseFirestore.instance.collection('users').doc(userID).collection('workouts').doc(id).get();
  print(data['date']);
  Workout workout = Workout(data['exercises'], data['notes'], data['rating'], data['time'], data['type']);
  return workout;
}
  
void saveWorkout(Workout workout) async {
  List exerciseList = [];
  for (Exercise exercise in workout.exercises) {
    exerciseList.add(await saveExercise(exercise));
  }
  workout.exercises = exerciseList;
  Map<String, Object?> jsonWorkout = workout.toJson();
  firestoreInstance.collection("users").doc(userID).collection("workouts").add(jsonWorkout).then((value){
    print(value.id);
  }); 

  //databaseRef.push().set(workout.toJson());
}

  void printFirebase(){
    //
}

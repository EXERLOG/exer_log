import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exerlog/Bloc/user_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/maxes.dart';
import 'package:exerlog/Models/sets.dart';

import '../main.dart';

Future<List<Max>> getSpecificMax(String exercise, double reps) async {
  final ref = await FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('maxes')
      .where('exercise', isEqualTo: exercise)
      .where('reps', isEqualTo: reps)
      .orderBy('weight', descending: true)
      .get();
  List<Max> maxList = [];
  for (int i = 0; i < ref.docs.length; i++) {
    Max max = Max.fromJson(ref.docs[i].data());
    maxList.add(max);
  }
  return maxList;
}

void deleteMax(Exercise exercise) async {
  final ref = await firestoreInstance
      .collection("users")
      .doc(userID)
      .collection("maxes")
      .where('exerciseID', isEqualTo: exercise.id)
      .get();
  for (int i = 0; i < ref.docs.length; i++) {
      firestoreInstance
    .collection('users')
    .doc(userID)
    .collection('maxes')
    .doc(ref.docs[i].id)
    .delete();
  }
}

Future<Max> getOneRepMax(String exercise) async {
  int reps = 1;
  QuerySnapshot<Map<String, dynamic>>? ref;
  ref = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('maxes')
        .where('exercise', isEqualTo: exercise)
        .orderBy('weight', descending: true)
        .get();
  print(ref.docs.first.data());
  Max returnMax;
  if (ref != null) {
    returnMax = Max.fromJson(ref.docs.first.data());
  } else {
    returnMax = new Max(0, 0, 0, '');
  }
  return returnMax;
}

void saveMax(Max max) {
  Map<String, Object?> jsonMax = max.toJson();
  firestoreInstance
      .collection("users")
      .doc(userID)
      .collection("maxes")
      .add(jsonMax)
      .then((value) {
  });
}

void checkMax(Exercise exercise) async {
  // check if max already exists otherwise save
  final ref = await FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('maxes')
      .where('exercise', isEqualTo: exercise.name)
      .get();

  if (ref.docs.length == 0) {
    List setList = [];
    for (Sets set in exercise.sets) {
      // check which ones are maxes and which aren't
      if (setList.length > 0) {
        bool shouldUpdate = true;
        for (Sets newSet in setList) {
          if (newSet.reps == set.reps && newSet.weight == set.weight) {
            shouldUpdate = false;
          }
        }
        if (shouldUpdate) {
          setList.add(set);
        }
      } else {
        setList.add(set);
      }
    }
    for (Sets set in setList) {
      Max max = Max(set.weight, set.reps, set.sets, exercise.name);
      max.exerciseID = exercise.id;
      saveMax(max);
    }
  } else {
    List setList = [];
    for (Sets set in exercise.sets) {
      bool shouldUpdate = true;
      for (int i = 0; i < ref.docs.length; i++) {
        var data = ref.docs[i];

        if (data['reps'] == set.reps && data['weight'] == set.weight) {
          shouldUpdate = false;
        }
      }
      for (Sets refSet in setList) {
        if (set.reps == refSet.reps && set.weight == refSet.weight) {
          shouldUpdate = false;
        }
      }
      if (shouldUpdate) {
        setList.add(set);
      }
    }
    for (Sets set in setList) {
      Max max = Max(set.weight, set.reps, set.sets, exercise.name);
      max.exerciseID = exercise.id;
      saveMax(max);
    }
  }
}



void updateExercise(String id, Exercise exercise) {}

void printFirebase() {
  //
}

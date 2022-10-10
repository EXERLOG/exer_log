// ignore_for_file: always_specify_types

import 'package:cloud_firestore/cloud_firestore.dart';

import 'exercise.dart';

class Workout {

  Workout(
      this.exercises,
      this.notes,
      this.rating,
      this.time,
      this.type,
      this.name,
      this.template,
      this.totalReps,
      this.totalWeight,
      this.totalSets,);

  Workout.fromJson(Map<String, Object?> workout)

      : this.exercises = workout['exercises']! as List,
        this.notes = workout['notes']! as String,
        this.rating = workout['rating']! as String,
        this.time = workout['time']! as double,
        this.totalReps = workout['total_reps']! as int,
        this.totalWeight = workout['total_weight']! as double,
        this.totalSets = workout['total_sets']! as int,
        this.name = workout['name']! as String,
        this.type = workout['type']! as String,
        this.template = workout['template']! as bool;

  Workout.fromJsonQuery(QueryDocumentSnapshot<Map<String, dynamic>> workout)
      : this.exercises = workout['exercises']! as List<Exercise>,
        this.notes = workout['notes']! as String,
        this.rating = workout['rating']! as String,
        this.time = workout['time']! as double,
        this.totalReps = workout['total_reps']! as int,
        this.totalWeight = workout['total_weight']! as double,
        this.totalSets = workout['total_sets']! as int,
        this.name = workout['name']! as String,
        this.type = workout['type']! as String,
        this.template = workout['template']! as bool;

  Workout.fromJsonQuerySnapshot(QuerySnapshot<Map<String, dynamic>> workout)

      : this.exercises = workout.docs.last['exercises']! as List,
        this.notes = workout.docs.last['notes']! as String,
        this.date =
            DateTime.parse(workout.docs.last['date']!.toDate().toString()),
        this.rating = workout.docs.last['rating']! as String,
        this.time = workout.docs.last['time']! as double,
        this.totalReps = workout.docs.last['total_reps']! as int,
        this.totalWeight = workout.docs.last['total_weight']! as double,
        this.totalSets = workout.docs.last['total_sets']! as int,
        this.name = workout.docs.last['name']! as String,
        this.type = workout.docs.last['type']! as String,
        this.template = workout.docs.last['template']! as bool;

  List exercises;
  String notes;
  String rating;
  double time;
  String type;
  String name;
  bool template;
  DateTime? date;
  String? id;
  int totalReps;
  double totalWeight;
  int totalSets;

  void setWorkoutTotals() {
    for (Exercise exercise in exercises) {
      totalReps += exercise.totalReps;
      totalSets += exercise.totalSets;
      totalWeight += exercise.totalWeight;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'date': FieldValue.serverTimestamp(),
      'exercises': exercises,
      'notes': notes,
      'rating': rating,
      'time': time,
      'type': type,
      'total_reps': totalReps,
      'total_weight': totalWeight,
      'total_sets': totalSets,
      'template': template,
      'name': name
    };
  }
}

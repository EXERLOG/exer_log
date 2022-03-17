import 'package:cloud_firestore/cloud_firestore.dart';

import 'exercise.dart';

class Workout {
  List exercises;
  String notes;
  String rating;
  double time;
  String type;
  String name;
  bool template;
  DateTime? date;
  String? id;

  Workout(this.exercises, this.notes, this.rating, this.time, this.type,
      this.name, this.template);

  Map<String, dynamic> toJson() {
    return {
      "date": FieldValue.serverTimestamp(),
      "exercises": exercises,
      "notes": notes,
      "rating": rating,
      "time": time,
      "type": type,
      "template": template,
      "name": name
    };
  }

  Workout.fromJson(Map<String, Object?> workout)
      : this.exercises = workout['exercises']! as List,
        this.notes = workout['notes']! as String,
        this.rating = workout['rating']! as String,
        this.time = workout['time']! as double,
        this.name = workout['name']! as String,
        this.type = workout['type']! as String,
        this.template = workout['template']! as bool;
  
  Workout.fromJsonQuery(QueryDocumentSnapshot<Map<String, dynamic>> workout)
      : this.exercises = workout['exercises']! as List,
        this.notes = workout['notes']! as String,
        this.date = DateTime.parse(workout['date']!.toDate().toString()),
        this.rating = workout['rating']! as String,
        this.time = workout['time']! as double,
        this.name = workout['name']! as String,
        this.type = workout['type']! as String,
        this.template = workout['template']! as bool;
  
  Workout.fromJsonQuerySnapshot(QuerySnapshot<Map<String, dynamic>> workout)
      : this.exercises = workout.docs.last['exercises']! as List,
        this.notes = workout.docs.last['notes']! as String,
        this.date = DateTime.parse(workout.docs.last['date']!.toDate().toString()),
        this.rating = workout.docs.last['rating']! as String,
        this.time = workout.docs.last['time']! as double,
        this.name = workout.docs.last['name']! as String,
        this.type = workout.docs.last['type']! as String,
        this.template = workout.docs.last['template']! as bool;
  // getVolume()
  // getLoad()
}



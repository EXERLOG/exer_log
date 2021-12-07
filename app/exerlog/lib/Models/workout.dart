import 'package:cloud_firestore/cloud_firestore.dart';

import 'exercise.dart';

class Workout {
  List exercises;
  String notes;
  String rating;
  double time;
  String type;
  String name;
  
  Workout(this.exercises, this.notes, this.rating, this.time, this.type, this.name);
 
  Map<String, dynamic> toJson() {
    return { "date" : FieldValue.serverTimestamp(), "exercises": exercises, "notes": notes, "rating": rating, "time": time, "type": type };
  }

  Workout.fromJson(Map<String, Object?> workout) :
      this.exercises = workout['exercises']! as List,
      this.notes = workout['notes']! as String,
      this.rating = workout['rating']! as String,
      this.time = workout['time']! as double,
      this.name = workout['name']! as String,
      this.type = workout['type']! as String;
  // getVolume()
  // getLoad()
}
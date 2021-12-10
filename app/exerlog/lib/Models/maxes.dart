
import 'package:cloud_firestore/cloud_firestore.dart';

class Max {
  int reps;
  int sets;
  double weight;
  String exercise;

  Max( this.weight, this.reps, this.sets, this.exercise);

  Map<String, dynamic> toJson() {
    return { "date": FieldValue.serverTimestamp(), "reps": reps, "sets": sets, "weight": weight, "exercise": exercise };
  }

  Max.fromJson(Map<String, Object?> max) :
      this.sets = max['sets']! as int,
      this.reps = max['reps']! as int,
      this.weight = max['weight']! as double,
      this.exercise = max['exercise']! as String;
}

/*
{
  "bb bench press" : {
    "10102021" : {
      "reps" : 10,
      "sets" : 1,
      "weight" : 100
    }
  }
}
*/
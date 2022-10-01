import 'package:cloud_firestore/cloud_firestore.dart';

class Max {

  Max(this.weight, this.reps, this.sets, this.exercise,);

  Max.fromJson(Map<String, Object?> max)
      : sets = max['sets']! as int,
        reps = max['reps']! as int,
        weight = max['weight']! as double,
        exercise = max['exercise']! as String,
        exerciseID = max['exerciseID']! as String;

  int reps;
  int sets;
  double weight;
  String exercise;
  String? exerciseID;

  Map<String, dynamic> toJson() {
    return {
      'date': FieldValue.serverTimestamp(),
      'reps': reps,
      'sets': sets,
      'weight': weight,
      'exercise': exercise,
      'exerciseID': exerciseID
    };
  }
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

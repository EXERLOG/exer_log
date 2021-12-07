
import 'package:cloud_firestore/cloud_firestore.dart';

import 'sets.dart';

class Exercise {
  String name;
  List sets;
  List bodyParts;

  Exercise(this.name, this.sets, this.bodyParts);
 
  Map<String, dynamic> toJson() {
    List the_sets = [];
    for (Sets set in sets) {
      the_sets.add(set.toJson());
    }
    return { "name": name, "sets": the_sets, "body_parts": bodyParts, "created": FieldValue.serverTimestamp()};
  }

  Exercise.fromJson(Map<String, Object?> exercise) :
      this.name = exercise['name']! as String,
      this.sets = exercise['sets']! as List,
      this.bodyParts = exercise['body_parts']! as List;


}
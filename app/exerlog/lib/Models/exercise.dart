
import 'sets.dart';

class Exercise {
  String name;
  List sets;

  Exercise(this.name, this.sets);
 
  Map<String, dynamic> toJson() {
    List the_sets = [];
    for (Sets set in sets) {
      the_sets.add(set.toJson());
    }
    return { "name": name, "sets": the_sets };
  }

  Exercise.fromJson(Map<String, Object?> exercise) :
      this.name = exercise['name']! as String,
      this.sets = exercise['sets']! as List;


}
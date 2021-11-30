import 'exercise.dart';

class Workout {
  List exercises;
  String notes;
  String rating;
  double time;
  String type;
  
  Workout(this.exercises, this.notes, this.rating, this.time, this.type);
 
  Map<String, dynamic> toJson() {
    String date = DateTime.now().millisecondsSinceEpoch.toString();
    return { "date" : date, "exercises": exercises, "notes": notes, "rating": rating, "time": time, "type": type };
  }

  static Workout fromString(Map workout) {
    List exercise_list = [];
    for (Map exercise in workout['exercises']) {
      // exercise_list.add(Exercise.fromJson(exercise));
    }
    return new Workout(exercise_list, workout['notes'], workout['rating'], workout['time'], workout['type']);
  }
  // getVolume()
  // getLoad()
}
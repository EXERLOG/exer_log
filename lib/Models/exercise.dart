import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/UI/exercise/totals_widget.dart';

class Exercise {
  String name;
  List sets;
  List bodyParts;
  String? id;
  int totalReps;
  double totalWeight;
  int totalSets;
  ExerciseTotalsWidget totalWidget = new ExerciseTotalsWidget(
      totals: new TotalsData(0, 0, 0.0, 0.0), index: 0);

  Exercise(this.name, this.sets, this.bodyParts, this.totalSets, this.totalReps,
      this.totalWeight);

  void setExerciseTotals() {
    totalReps = 0;
    totalSets = 0;
    totalWeight = 0.0;
    for (Sets set in sets) {
      totalSets += set.sets;
      int reps = (set.reps * set.sets);
      totalReps += reps;
      totalWeight += (reps * set.weight);
    }
    totalWidget.totals.totalReps = totalReps;
    totalWidget.totals.totalSets = totalSets;
    totalWidget.totals.totalWeight = totalWeight;
    totalWidget.totals.avgWeight = totalWeight / totalReps;
  }

  Map<String, dynamic> toJson() {
    List theSets = [];
    for (Sets set in sets) {
      theSets.add(set.toJson());
    }
    return {
      'name': name,
      'sets': theSets,
      'body_parts': bodyParts,
      'total_reps': totalReps,
      'total_weight': totalWeight,
      'total_sets': totalSets,
      'created': FieldValue.serverTimestamp()
    };
  }

  Exercise.fromJson(Map<String, Object?> exercise)
      : this.name = exercise['name']! as String,
        this.sets = exercise['sets']! as List,
        this.bodyParts = exercise['body_parts']! as List,
        this.totalReps = exercise['total_reps']! as int,
        this.totalWeight = exercise['total_weight']! as double,
        this.totalSets = exercise['total_sets']! as int;
}

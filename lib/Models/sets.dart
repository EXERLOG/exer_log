

class Sets {
  int reps;
  double rest;
  double weight;
  int sets;
  double percentage;

  Sets(this.reps, this.rest, this.weight, this.sets, this.percentage);

  Map<dynamic, dynamic> toJson() {
    return { "reps": reps, "rest": rest, "weight": weight, "sets": sets, "percentage": percentage};
  }

  static Sets fromString(Map set) {
    return Sets(
      set['reps'], 
      set['rest'], 
      set['weight'], 
      set['sets'],
      set['percentage']);
  }
}

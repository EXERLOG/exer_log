

class Sets {
  int reps;
  double rest;
  double weight;
  int sets;

  Sets(this.reps, this.rest, this.weight, this.sets);

  Map<dynamic, dynamic> toJson() {
    return { "reps": reps, "rest": rest, "weight": weight, "sets": sets};
  }

  static Sets fromString(Map set) {
    return Sets(set['reps'], set['rest'], set['weight'], set['sets']);
  }
}

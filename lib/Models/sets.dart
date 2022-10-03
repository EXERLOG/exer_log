

class Sets {

  Sets(this.reps, this.rest, this.weight, this.sets, this.percentage,);

  int reps;
  double rest;
  double weight;
  int sets;
  double percentage;

  Map<dynamic, dynamic> toJson() {
    return  <String, dynamic> { 'reps': reps, 'rest': rest, 'weight': weight, 'sets': sets, 'percentage': percentage};
  }

  static Sets fromString(Map <dynamic, dynamic>set) {
    return Sets(
      set['reps'],
      set['rest'],
      set['weight'],
      set['sets'],
      set['percentage'],
    );
  }
}

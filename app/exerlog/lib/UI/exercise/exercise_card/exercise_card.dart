import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/Models/workout_data.dart';
import 'package:exerlog/UI/exercise/exercise_card/add_exercise_button.dart';
import 'package:exerlog/UI/exercise/exercise_card/exercise_card_header.dart';
import 'package:exerlog/UI/exercise/set_widget.dart';
import 'package:exerlog/UI/exercise/totals_widget.dart';
import 'package:exerlog/UI/global.dart';
import 'package:flutter/material.dart';

class ExerciseCard extends StatefulWidget {
  final ValueKey key;
  final String name;
  final ValueChanged<Exercise> addExercise;
  final VoidCallback updateExisitingExercise;
  final ValueChanged<Exercise> removeExercise;
  final void Function(Exercise, Sets, int) removeSet;
  final bool isTemplate;
  final WorkoutData workoutData;
  final ExerciseTotalsWidget totalsWidget;
  final Exercise exercise;

  ExerciseCard({
    required this.key,
    required this.name,
    required this.exercise,
    required this.addExercise,
    required this.updateExisitingExercise,
    required this.removeExercise,
    required this.removeSet,
    required this.isTemplate,
    required this.workoutData,
    required this.totalsWidget,
  });

  @override
  _ExerciseCardState createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> with AutomaticKeepAliveClientMixin {
  static const headerTitles = ["Reps", "Sets", "Weight", "Rest"];

  late Exercise exercise = widget.exercise;
  late ValueNotifier<TotalsData> _notifier;

  static int counter = 0;
  static int index = 0;

  double originalHeight = screenHeight * 0.23;
  double height = 0;
  TotalsData totalData = new TotalsData(0, 0, 0.0, 0.0);

  @override
  void initState() {
    final sets = widget.exercise.sets;
    widget.exercise.setExerciseTotals();
    originalHeight += _getHeight() - 20;
    sets.isEmpty ? _addSet() : null;
    _notifier = ValueNotifier(widget.totalsWidget.totals);
    height = originalHeight + ((screenHeight * 0.05) * (sets.length - 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            Container(
              height: height,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    offset: Offset(0, 3),
                    blurRadius: 5,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  ExerciseCardHeader(
                    height: _getHeight(),
                    index: index,
                    notifier: _notifier,
                    title: widget.name,
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  Column(
                    children: [
                      Container(
                        height: screenHeight * 0.04,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: screenWidth * 0.08),
                            ...headerTitles
                                .map(
                                  (title) => Container(
                                    child: Center(
                                      child: Text(
                                        title,
                                        style: smallTitleStyleWhite,
                                      ),
                                    ),
                                    width: screenWidth * 0.15,
                                  ),
                                )
                                .toList(),
                            SizedBox(width: screenWidth * 0.1),
                          ],
                        ),
                      ),
                      Column(
                        children: List.generate(
                          widget.exercise.sets.length,
                          (index) => SetWidget(
                            name: widget.name,
                            exercise: exercise,
                            addNewSet: widget.workoutData.addSet,
                            removeSet: _removeSet,
                            counter: counter,
                            id: index,
                            isTemplate: false,
                            updateTotal: _updateTotal,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
        AddExerciseButton(
          size: 50,
          onTapped: _addSet,
        ),
      ],
    );
  }

  void _addSet() {
    counter++;
    widget.exercise.sets.add(new Sets(0, 0.0, 0.0, 0, 0.0));
    widget.addExercise(widget.exercise);
    _setHeight();
  }

  void _removeSet(exercise, sets, id) {
    final setList = widget.exercise.sets;
    if (setList.length - 1 == 0) widget.removeExercise(exercise);
    setState(() {
      widget.removeSet(exercise, sets, id);
      height = originalHeight + ((screenHeight * 0.05) * (setList.length - 1));
    });
  }

  void _updateTotal() {
    _notifier.value = new TotalsData(
      widget.exercise.totalReps,
      widget.exercise.totalSets,
      widget.exercise.totalWeight,
      (widget.exercise.totalWeight / widget.exercise.totalReps).roundToDouble(),
    );
  }

  void _setHeight() {
    setState(() {
      height = originalHeight + ((screenHeight * 0.05) * (widget.exercise.sets.length - 1));
    });
  }

  double _getHeight() {
    double length = (widget.exercise.name.length / 16);
    if (length.toInt() == 0 || length == 1.0) {
      return 25;
    } else {
      return (length.toInt() + 1) * 25;
    }
  }

  @override
  bool get wantKeepAlive => true;
}

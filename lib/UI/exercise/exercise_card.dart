import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/Models/workout_data.dart';
import 'package:exerlog/UI/exercise/set_widget.dart';
import 'package:exerlog/UI/exercise/totals_widget.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class ExerciseCard extends StatefulWidget {
  final ValueKey key;
  final String name;
  Exercise exercise;
  Function(Exercise) addExercise;
  Function() updateExisitingExercise;
  Function(Exercise) removeExercise;
  Function(Exercise, Sets, int) removeSet;
  final bool isTemplate;
  WorkoutData workoutData;
  ExerciseTotalsWidget totalsWidget;

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
  static int counter = 0;
  List<SetWidget> setList = [];
  static int index = 0;
  double originalHeight = screenHeight * 0.23;
  double height = 0;
  TotalsData totalData = new TotalsData(0, 0, 0.0, 0.0);
  late ValueNotifier<TotalsData> _notifier;

  @override
  void initState() {
    widget.exercise.setExerciseTotals();
    setList = [];
    originalHeight += getHeight() - 20;
    // widget.workoutData.addNewSet = addTheNewSet;
    if (widget.exercise.sets.length < 1) {
      setList.add(new SetWidget(
        name: widget.name,
        exercise: widget.exercise,
        addNewSet: widget.workoutData.addSet,
        removeSet: removeSet,
        //createNewSet: createNewSet,
        id: 0,
        counter: counter,
        isTemplate: widget.isTemplate,
        updateTotal: updateTotal,
      ));
      widget.exercise.sets.add(new Sets(0, 0.0, 0.0, 0, 0.0));
    } else if (widget.exercise.sets.length > 0) {
      int i = 0;
      for (Sets sets in widget.exercise.sets) {
        setList.add(new SetWidget(
          name: widget.exercise.name,
          exercise: widget.exercise,
          addNewSet: widget.workoutData.addSet,
          removeSet: removeSet,
          counter: counter,
          id: i,
          isTemplate: widget.isTemplate,
          updateTotal: updateTotal,
        ));
        counter++;
        i++;
      }
    }
    _notifier = ValueNotifier(widget.totalsWidget.totals);
    height = originalHeight + ((screenHeight * 0.05) * (setList.length - 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ThemeProvider(
      builder: (context, theme) {
        return Container(
          height: height + screenHeight * 0.06,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: theme.colorTheme.backgroundColorVariation,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      offset: Offset(0, 3),
                      blurRadius: 5,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                padding: EdgeInsets.all(20),
                height: height,
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: getHeight(),
                            width: screenWidth * 0.45,
                            child: Text(
                              widget.name,
                              style: mediumTitleStyleWhite,
                            ),
                          ),
                          Container(
                            child: ValueListenableBuilder(
                              valueListenable: _notifier,
                              builder: (BuildContext context, TotalsData value, Widget? child) {
                                return ExerciseTotalsWidget(
                                  totals: value,
                                  index: index,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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
                              Spacer(flex: 8),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "Reps",
                                    style: smallTitleStyleWhite,
                                  ),
                                ),
                                flex: 15,
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "Sets",
                                    style: smallTitleStyleWhite,
                                  ),
                                ),
                                flex: 15,
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "Weight",
                                    style: smallTitleStyleWhite,
                                  ),
                                ),
                                flex: 15,
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "Rest",
                                    style: smallTitleStyleWhite,
                                  ),
                                ),
                                flex: 15,
                              ),
                              Spacer(flex: 10)
                            ],
                          ),
                        ),
                        Column(
                          children: setList,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                right: screenWidth * 0.43,
                left: screenWidth * 0.43,
                top: height - 15,
                child: Container(
                  height: screenHeight * 0.07,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            theme.colorTheme.primaryColor,
                            theme.colorTheme.secondaryColor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    child: FloatingActionButton(
                      heroTag: null,
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.add,
                        size: 50,
                        color: theme.colorTheme.backgroundColorVariation,
                      ),
                      onPressed: addSet,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void addSet() {
    counter++;
    setState(() {
      setList.add(new SetWidget(
        name: widget.name,
        exercise: widget.exercise,
        addNewSet: widget.workoutData.addSet,
        removeSet: removeSet,
        counter: counter,
        id: widget.exercise.sets.length,
        isTemplate: false,
        updateTotal: updateTotal,
      ));
      widget.exercise.sets.add(new Sets(0, 0.0, 0.0, 0, 0.0));
      widget.addExercise(widget.exercise);
    });
    setHeight();
  }

  void removeSet(exercise, sets, id) {
    setState(() {
      setList.removeAt(id);
      if (setList.length == 0) {
        widget.removeExercise(exercise);
      } else {
        widget.exercise.sets.remove(sets);
        widget.exercise = widget.removeSet(exercise, sets, id);
        height = originalHeight + ((screenHeight * 0.05) * (setList.length - 1));
        setList = [];
        int i = 0;
        for (Sets sets in widget.exercise.sets) {
          setList.add(new SetWidget(
              name: widget.exercise.name,
              exercise: widget.exercise,
              addNewSet: widget.workoutData.addSet,
              removeSet: removeSet,
              counter: counter,
              id: i,
              isTemplate: widget.isTemplate,
              updateTotal: updateTotal));
          counter++;
          i++;
        }
      }
    });
  }

  void updateTotal() {
    _notifier.value = new TotalsData(
      widget.exercise.totalReps,
      widget.exercise.totalSets,
      widget.exercise.totalWeight,
      (widget.exercise.totalWeight / widget.exercise.totalReps).roundToDouble(),
    );
  }

  void setHeight() {
    setState(() {
      height = originalHeight + ((screenHeight * 0.05) * (setList.length - 1));
    });
  }

  double getHeight() {
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

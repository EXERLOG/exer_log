import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/prev_workout_data.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/UI/exercise/totals_widget.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/prev_workout/prev_set_widget.dart';
import 'package:exerlog/src/utils/logger/logger.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class PrevExerciseCard extends StatefulWidget {

  PrevExerciseCard({
    required this.name,
    required this.exercise,
    required this.addExercise,
    required this.updateExisitingExercise,
    required this.isTemplate,
    required this.setList,
    required this.prevworkoutData,
    Key? key,
  }) : super(key: key);
  final String name;
  final Exercise exercise;
  Function(Exercise) addExercise;
  Function(Exercise) updateExisitingExercise;
  final bool isTemplate;
  List<PrevSetWidget> setList;
  PrevWorkoutData prevworkoutData;
  @override
  _PrevExerciseCardState createState() => _PrevExerciseCardState();
}

class _PrevExerciseCardState extends State<PrevExerciseCard> with AutomaticKeepAliveClientMixin {
  int index = 0;
  double height = screenHeight * 0.23;
  TotalsData totalData = TotalsData(0, 0, 0.0, 0.0);
  late ExerciseTotalsWidget totalWidget;

  @override
  void initState() {
    height += getHeight() - 20;
    if (widget.setList.isEmpty) {
      widget.setList.add(
        PrevSetWidget(
          name: widget.name,
          exercise: widget.exercise,
          addNewSet: widget.prevworkoutData.addNewSet,
          id: 0,
          isTemplate: widget.isTemplate,
        ),
      );
      widget.exercise.sets.add(Sets(0, 0.0, 0.0, 0, 0.0));
    }
    totalWidget = widget.exercise.totalWidget;
    height += (screenHeight * 0.05) * (widget.setList.length - 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    totalWidget = ExerciseTotalsWidget(totals: totalData, index: index);
    return ThemeProvider(
      builder: (context, theme) {
        return Container(
          height: height + screenHeight * 0.06,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: theme.colorTheme.backgroundColorVariation,
                  boxShadow: [
                    const BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      offset: Offset(0, 3),
                      blurRadius: 5,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                padding: const EdgeInsets.all(20),
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
                          totalWidget
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
                              Container(
                                width: screenWidth * 0.08,
                              ),
                              Container(
                                width: screenWidth * 0.15,
                                child: Center(
                                  child: Text(
                                    'Reps',
                                    style: smallTitleStyleWhite,
                                  ),
                                ),
                              ),
                              Container(
                                width: screenWidth * 0.15,
                                child: Center(
                                  child: Text(
                                    'Sets',
                                    style: smallTitleStyleWhite,
                                  ),
                                ),
                              ),
                              Container(
                                width: screenWidth * 0.15,
                                child: Center(
                                  child: Text(
                                    'Weight',
                                    style: smallTitleStyleWhite,
                                  ),
                                ),
                              ),
                              Container(
                                width: screenWidth * 0.15,
                                child: Center(
                                  child: Text(
                                    'Rest',
                                    style: smallTitleStyleWhite,
                                  ),
                                ),
                              ),
                              Container(
                                width: screenWidth * 0.1,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: widget.setList,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  double getHeight() {
    Log.info('REMAINDER ${widget.name}${widget.exercise.name.length}');
    double length = (widget.exercise.name.length / 17);
    if (length.toInt() == 0 || length == 1.0) {
      return 25;
    } else {
      return (length.toInt() + 1) * 25;
    }
  }

  @override
  bool get wantKeepAlive => true;
}

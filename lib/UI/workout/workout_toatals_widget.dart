import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class WorkoutTotalsWidget extends StatefulWidget {

  const WorkoutTotalsWidget({Key? key, required this.totals}) : super(key: key);
  final WorkoutTotals totals;

  @override
  _WorkoutTotalsWidgetState createState() => _WorkoutTotalsWidgetState();
}

class _WorkoutTotalsWidgetState extends State<WorkoutTotalsWidget> {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      builder: (context, theme) {
        return Container(
          height: screenHeight * 0.13,
          decoration: BoxDecoration(color: theme.colorTheme.backgroundColorVariation, boxShadow: [
            const BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              offset: Offset(0, 3),
              blurRadius: 5,
              spreadRadius: 5,
            ),
          ],),
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Totals',
                    style: mediumTitleStyleWhite,
                  )
                ],
              ),
              Divider(
                color: Colors.white.withOpacity(0.2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'sets',
                        style: setStyle,
                      ),
                      Text(
                        widget.totals.sets.toString(),
                        style: setStyle,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'reps',
                        style: setStyle,
                      ),
                      Text(
                        widget.totals.reps.toString(),
                        style: setStyle,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'load',
                        style: setStyle,
                      ),
                      Text(
                        widget.totals.weight.toString(),
                        style: setStyle,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'kg/rep',
                        style: setStyle,
                      ),
                      Text(
                        widget.totals.avgKgs.toString(),
                        style: setStyle,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'exercises',
                        style: setStyle,
                      ),
                      Text(
                        widget.totals.exercises.toString(),
                        style: setStyle,
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class WorkoutTotals {

  WorkoutTotals(this.sets, this.reps, this.weight, this.avgKgs, this.exercises) {
    sets = this.sets;
    reps = this.reps;
    weight = this.weight;
    avgKgs = this.avgKgs;
    exercises = this.exercises;
  }

  int sets;
  int reps;
  double weight;
  double avgKgs;
  int exercises;
}

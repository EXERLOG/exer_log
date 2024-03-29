import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/core/theme/app_theme.dart';
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
      builder: (BuildContext context, AppTheme theme) {
        return Container(
          height: screenHeight * 0.13,
          decoration: BoxDecoration(color: theme.colorTheme.backgroundColorVariation, boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              offset: Offset(0, 3),
              blurRadius: 5,
              spreadRadius: 5,
            ),
          ],),
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      'Totals',
                      style: mediumTitleStyleWhite,
                    ),
                  )
                ],
              ),
              Divider(
                color: Colors.white.withOpacity(0.2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  Column(
                    children: <Widget> [
                      Container(
                        child: Text(
                          'sets',
                          style: setStyle,
                        ),
                      ),
                      Container(
                        child: Text(
                          widget.totals.sets.toString(),
                          style: setStyle,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'reps',
                          style: setStyle,
                        ),
                      ),
                      Container(
                        child: Text(
                          widget.totals.reps.toString(),
                          style: setStyle,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget> [
                      Container(
                        child: Text(
                          'load',
                          style: setStyle,
                        ),
                      ),
                      Container(
                        child: Text(
                          widget.totals.weight.toString(),
                          style: setStyle,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget> [
                      Container(
                        child: Text(
                          'kg/rep',
                          style: setStyle,
                        ),
                      ),
                      Container(
                        child: Text(
                          widget.totals.avgKgs.toString(),
                          style: setStyle,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget> [
                      Container(
                        child: Text(
                          'exercises',
                          style: setStyle,
                        ),
                      ),
                      Container(
                        child: Text(
                          widget.totals.exercises.toString(),
                          style: setStyle,
                        ),
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

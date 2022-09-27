import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exerlog/Bloc/workout_bloc.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/prev_workout/prev_workout_page.dart';
import 'package:exerlog/src/core/theme/app_theme.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class DateWidget extends StatelessWidget {

  const DateWidget(this.date, {Key? key}) : super(key: key);
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    DateTime after = DateTime(
      date.year,
      date.month,
      date.day,
      23,
      59,
      59,
      0,
      0,
    );
    DateTime before = DateTime(
      date.year,
      date.month,
      date.day,
      0,
      0,
      0,
      0,
      0,
    );
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: getWorkoutOnDate(after, before),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData) {
          return _buildDayContainer();
        }
        Workout? workout;
        try {
          workout = Workout.fromJsonQuerySnapshot(snapshot.data!);
        } catch (_) {
          /// FIXME: This results in bad state, due to parsing error
          // Log.error(e.toString(), stackTrace: stackTrace);
        }
        return GestureDetector(
          onTap: () => _navigateToPreviousWorkoutScreen(
            context,
            workout,
          ),
          child: _buildDayContainer(hasWorkout: workout != null),
        );
      },
    );
  }

  Widget _buildDayContainer({bool hasWorkout = false}) {
    return ThemeProvider(
      builder: (BuildContext context, AppTheme theme) {
        return Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(10),
          decoration:
              hasWorkout ? _hasWorkoutDecoration(theme.colorTheme) : null,
          child: Center(
            child: Text(
              date.day.toString(),
              textScaleFactor: 1,
              style: hasWorkout ? buttonTextSmall : whiteTextStyleSmall,
            ),
          ),
        );
      },
    );
  }

  BoxDecoration _hasWorkoutDecoration(ColorTheme color) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          color.primaryColor,
          color.secondaryColor,
        ],
      ),
      borderRadius: BorderRadius.circular(5),
    );
  }

  void _navigateToPreviousWorkoutScreen(context, Workout? workout) {
    if (workout == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PrevWorkoutPage(workout),
      ),
    );
  }
}

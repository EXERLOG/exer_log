import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exerlog/Bloc/workout_bloc.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/prev_workout/prev_workout_page.dart';
import 'package:exerlog/src/core/theme/app_theme.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class DateWidget extends StatelessWidget {
  final DateTime date;

  DateWidget(this.date);

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
      builder: (context, snapshot) {
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
      builder: (context, theme) {
        return Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(10),
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
    if (workout != null)
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PrevWorkoutPage(workout),
        ),
      );
  }
}

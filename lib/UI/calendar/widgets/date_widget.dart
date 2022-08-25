import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exerlog/Bloc/workout_bloc.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/prev_workout/prev_workout_page.dart';
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
        if (snapshot.hasError) {
          return _buildDayContainer();
        } else if (snapshot.hasData) {
          Workout? workout;
          try {
            workout = Workout.fromJsonQuerySnapshot(snapshot.data!);
          } catch (_) {
            /// This results in bad state, due to parsing error
            // Log.error(e.toString(), stackTrace: stackTrace);
          }
          return GestureDetector(
            onTap: () {
              if (workout != null)
                _navigateToPreviousWorkoutScreen(
                  context,
                  workout,
                );
            },
            child: _buildDayContainer(hasWorkout: workout != null),
          );
        } else {
          return _buildDayContainer();
        }
      },
    );
  }

  Container _buildDayContainer({bool hasWorkout = false}) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      decoration: hasWorkout ? _hasWorkoutDecoration() : null,
      child: Center(
        child: Text(
          date.day.toString(),
          textScaleFactor: 1,
          style: hasWorkout ? buttonTextSmall : whiteTextStyleSmall,
        ),
      ),
    );
  }

  BoxDecoration _hasWorkoutDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(0xFF34D1C2),
          Color(0xFF31A6DC),
        ],
      ),
      borderRadius: BorderRadius.circular(5),
    );
  }

  Future<dynamic> _navigateToPreviousWorkoutScreen(context, Workout workout) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PrevWorkoutPage(workout),
      ),
    );
  }
}

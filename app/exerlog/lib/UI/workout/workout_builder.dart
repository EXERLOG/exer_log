

import 'package:exerlog/Bloc/workout_bloc.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/exercise/exercise_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutInformation extends StatefulWidget {
  final String id;

  WorkoutInformation({required this.id});
  @override
  _WorkoutInformationState createState() => _WorkoutInformationState();

}

class _WorkoutInformationState extends State<WorkoutInformation> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Workout>(
      future: getSpecificWorkout(widget.id),
      builder: (BuildContext context, AsyncSnapshot<Workout> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          } else {
            return Center(
              child: Column(
                children: [
                  Text(snapshot.data!.type),
                  ExerciseInformation(id: snapshot.data!.exercises[0])
                ],
              ),
            );
          }
        }
      },
    );
  }

}
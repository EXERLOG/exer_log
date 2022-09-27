

import 'package:exerlog/Bloc/workout_bloc.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/exercise/exercise_information.dart';
import 'package:flutter/material.dart';

class WorkoutInformation extends StatefulWidget {

  const WorkoutInformation({required this.id,Key? key}) : super(key: key);

  final String id;
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          } else {
            return Center(
              child: Column(
                children: <Widget>[
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

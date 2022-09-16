import 'package:exerlog/Bloc/exercise_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:flutter/material.dart';

class ExerciseInformation extends StatefulWidget {
  final String id;

  ExerciseInformation({Key? key, required this.id}) : super(key: key);
  @override
  _ExerciseInformationState createState() => _ExerciseInformationState();

}

class _ExerciseInformationState extends State<ExerciseInformation> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Exercise>(
      future: getSpecificExercise(widget.id),
      builder: (BuildContext context, AsyncSnapshot<Exercise> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error'),
            );
          } else {
            return Center(
              child: Text(snapshot.data!.name),
            );
          }
        }
      },
    );
  }

}

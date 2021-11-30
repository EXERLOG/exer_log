import 'package:exerlog/Bloc/exercise_bloc.dart';
import 'package:exerlog/Bloc/max_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/maxes.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MaxInformation extends StatefulWidget {
  final String id;

  MaxInformation({required this.id});
  @override
  _MaxInformationState createState() => _MaxInformationState();

}

class _MaxInformationState extends State<MaxInformation> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Max>>(
      future: getSpecificMax(widget.id, 10),
      builder: (BuildContext context, AsyncSnapshot<List<Max>> snapshot) {
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
              child: Text('${snapshot.data![0].weight}'),
            );
          }
        }
      },
    );
  }

}
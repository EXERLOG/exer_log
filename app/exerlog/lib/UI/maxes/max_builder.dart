import 'package:exerlog/Bloc/exercise_bloc.dart';
import 'package:exerlog/Bloc/max_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/maxes.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MaxInformation extends StatefulWidget {
  final String id;
  double weight;
  Function? setMax;

  MaxInformation({required this.id, required this.weight, this.setMax});
  @override
  _MaxInformationState createState() => _MaxInformationState();

}

class _MaxInformationState extends State<MaxInformation> {
  double oneRepMax = 0.0;
  String text = "0%";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Max>(
      future: getOneRepMax(widget.id),
      builder: (BuildContext context, AsyncSnapshot<Max> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasError) {
            return Center(
              child: Text(text, style: setStyle,),
            );
          } else { 
            oneRepMax = snapshot.data!.weight / maxTable[snapshot.data!.reps -1];
            if (widget.setMax != null) {
              widget.setMax!(snapshot.data);
            }
            text = ((widget.weight / oneRepMax) * 100).round().toString() + "%";
            return Center(
              child: Text(text, style: setStyle,),
            );
          }
        }
      },
    );
  }

  void updateSelf(double weight) {
    setState(() {
      widget.weight = weight;
    });
  }

}
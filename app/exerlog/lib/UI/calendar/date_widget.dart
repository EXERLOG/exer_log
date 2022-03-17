import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exerlog/Bloc/workout_bloc.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/Models/workout_data.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/gradient_button.dart';
import 'package:exerlog/UI/prev_workout/prev_workout_page.dart';
import 'package:exerlog/UI/workout/workout_toatals_widget.dart';
import 'package:exerlog/main.dart';
import 'package:flutter/material.dart';

class DateWidget extends StatefulWidget {
  final DateTime date;

  DateWidget(this.date);

  @override 
  _DateWidgetState createState() => _DateWidgetState();

}

class _DateWidgetState extends State<DateWidget> {
  @override
  Widget build(BuildContext context) {
    DateTime after = new DateTime(widget.date.year, widget.date.month, widget.date.day, 23, 59, 59, 0 , 0);
    DateTime before = new DateTime(widget.date.year, widget.date.month, widget.date.day, 0, 0, 0, 0 , 0);
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('workouts')
      .where('date', isLessThan: after)
      .where('date', isGreaterThan: before)
      .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasError) {
            return Container(
              padding: EdgeInsets.only(top:5),
              height: 40,
              width: 35,
              child: Center(child: Text(widget.date.day.toString(), style: whiteTextStyleSmall,)),
            );
          } else if (snapshot.hasData) {
            try {
              Workout workout = Workout.fromJsonQuerySnapshot(snapshot.data!);
              workout.id = snapshot.data!.docs.last.id;

              return Container(
                padding: EdgeInsets.only(top: 5),
                height: 40,
                width: 35,
                child: RaisedGradientButton(
                  onPressed: () {
                    Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PrevWorkoutPage(workout)
                              ),
                            );
                  },
                  radius: 10,
                  gradient: LinearGradient(
                    colors: <Color>[Color(0xFF34D1C2), Color(0xFF31A6DC)],
                  ),
                  child: Text(widget.date.day.toString(), style: buttonTextSmall,),

                ),
              );

            } catch (Exception) {
              return Container(
                padding: EdgeInsets.only(top:5),
                height: 40,
                width: 35,
                child: Center(child: Text(widget.date.day.toString(), style: whiteTextStyleSmall,)),
              );
            }
          }
          else {
            return Container(
              padding: EdgeInsets.only(top:5),
              height: 40,
              width: 35,
              child: Center(child: Text(widget.date.day.toString(), style: whiteTextStyleSmall,)),
            );
          }
        }
      },
    );  
  }
}
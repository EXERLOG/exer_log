import 'package:exerlog/Bloc/exercise_bloc.dart';
import 'package:exerlog/Bloc/max_bloc.dart';
import 'package:exerlog/Bloc/user_bloc.dart';
import 'package:exerlog/Bloc/workout_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/Models/user.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/main.dart';
import 'package:flutter/material.dart';
import 'global.dart';

class RaisedGradientButton extends StatefulWidget {
  Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;
  final double radius;
  final double borderSize;
  RaisedGradientButton({
    required this.child,
    required this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    required this.onPressed,
    required this.radius,
    required this.borderSize,
  });

  @override
  _RaisedGradientButtonState createState() => _RaisedGradientButtonState(child: child, width: width, height: height, radius: radius, borderSize: borderSize, onPressed: onPressed, gradient: gradient);
}

class _RaisedGradientButtonState extends State<RaisedGradientButton> {
  Widget child;
  Gradient gradient;
  double width;
  double height;
  Function onPressed;
  double radius;
  double borderSize;
  _RaisedGradientButtonState({
    required this.child,
    required this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    required this.onPressed,
    required this.radius,
    required this.borderSize
  });
  void changeChild(Widget newChild) {
    setState(() {
      child = newChild;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: radius*2,
      decoration: BoxDecoration(gradient: gradient, boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.2),
          offset: Offset(0, 3),
          blurRadius: 5,
          spreadRadius: 5
        ),
      ],
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(width: borderSize, color: backgroundColor)
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            borderRadius: BorderRadius.circular(radius),
            onTap: (){
              // Workout workout = Workout([], 'notes', 'good', 120, 'strength');
              // Sets set1 = Sets(15, 120, 50, 1);
              // Sets set2 = Sets(8, 120, 80, 1);
              // Sets set3 = Sets(5, 120, 90, 1);
              // Exercise exercise = Exercise("Deadlift", [set1, set2, set3]);
              // checkMax(exercise);
              // workout.exercises.add(exercise);
              // saveWorkout(workout);
              //createUser(UserClass("kallehallden", 178, 80, [], [], 27, "example@example.com", "Kalle", "Hallden", [], "metric", ''));
              setState(() {
                onPressed();
              });
            },
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
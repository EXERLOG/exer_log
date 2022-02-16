import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/gradient_button.dart';
import 'package:flutter/material.dart';

class DateWidget extends StatefulWidget {
  final DateTime date;
  final Workout? workout;

  DateWidget(this.date, this.workout);

  @override 
  _DateWidgetState createState() => _DateWidgetState();

}

class _DateWidgetState extends State<DateWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.workout != null ? 
    Container(
      padding: EdgeInsets.only(top: 5),
      height: 40,
      width: 35,
      child: RaisedGradientButton(
        onPressed: () {
          print("pressed");
        },
        radius: 10,
        gradient: LinearGradient(
          colors: <Color>[Color(0xFF34D1C2), Color(0xFF31A6DC)],
        ),
        child: Text(widget.date.day.toString(), style: buttonTextSmall,),

      ),
    ) 
    : 
    Container(
      padding: EdgeInsets.only(top:5),
      height: 40,
      width: 35,
      child: Center(child: Text(widget.date.day.toString(), style: whiteTextStyleSmall,)),
    );
  }
}
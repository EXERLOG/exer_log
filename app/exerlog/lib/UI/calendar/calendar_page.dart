import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/gradient_button.dart';
import 'package:exerlog/UI/workout/workout_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'calendar_widget.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage();

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CalendarWidget(),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.only(bottom: 30),
              child: RaisedGradientButton(
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFF34D1C2), Color(0xFF31A6DC)],
                ),
                radius: 30,
                child: Text(
                  "START NEW WORKOUT",
                  style: buttonTextSmall,
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  // Navigator.of(context).pop();
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(
                  //       builder: (context) => WorkoutPage(null
                  //       ),
                  //     ),
                  //   );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

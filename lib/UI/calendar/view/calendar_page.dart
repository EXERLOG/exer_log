import 'package:exerlog/UI/calendar/widgets/calendar_widget.dart';
import 'package:exerlog/UI/calendar/widgets/logout_button.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/widgets/gradient_button.dart';
import 'package:exerlog/UI/workout/workout_page.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Exerlog"),
        elevation: 0,
        backgroundColor:
            Colors.transparent, // backgroundColor.withOpacity(0.75),
        actions: [
          LogoutButton(),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CalendarWidget(),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: RaisedGradientButton(
                child: Text(
                  "START NEW WORKOUT",
                  style: buttonTextSmall,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => WorkoutPage(null),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

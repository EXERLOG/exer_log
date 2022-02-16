import 'package:exerlog/UI/global.dart';
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
      body: Container(
        padding: EdgeInsets.only(top:30, left: 20, right: 20),
        color: backgroundColor,
        child: Column(
          children: [
            CalendarWidget(),
          ],
          ),
      ),
    );
  }

}
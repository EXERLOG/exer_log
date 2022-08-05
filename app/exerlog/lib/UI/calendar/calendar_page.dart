import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/gradient_button.dart';
import 'package:exerlog/UI/workout/workout_page.dart';
import 'package:exerlog/main.dart';
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
      appBar: AppBar(
        title: Text("Exerlog"),
        backgroundColor: backgroundColor.withOpacity(0.75),
        actions: [
          _Logout(),
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

class _Logout extends StatefulWidget {
  const _Logout({
    Key? key,
  }) : super(key: key);

  @override
  State<_Logout> createState() => _LogoutState();
}

class _LogoutState extends State<_Logout> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: InkWell(
        onTap: () async {
          if (!_isLoading) {
            setState(() {
              _isLoading = true;
            });
            await FirebaseAuth.instance.signOut();
            setState(() {
              _isLoading = false;
            });
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
              (route) => false,
            );
          }
        },
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(Icons.logout),
      ),
    );
  }
}

import 'package:exerlog/UI/calendar/widgets/calendar_widget.dart';
import 'package:exerlog/UI/calendar/widgets/logout_button.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/widgets/gradient_button.dart';
import 'package:exerlog/UI/workout/workout_page.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

import '../../../src/widgets/SnackBars/noNetworkConnectionSnackBar.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Stream<ConnectivityResult> _connectivityStream =
      Connectivity().onConnectivityChanged;
  _noNetworkConnection() {
    ScaffoldMessenger.of(context).showSnackBar(noNetworkConnectionSnackBar());
  }

  @override
  void initState() {
    super.initState();
    _connectivityStream.listen((connectionResult) {
      if (connectionResult == ConnectivityResult.none) {
        _noNetworkConnection();
      }
    });
  }

  // @override
  // void dispose() {
  //   connectionStreamSubscribtion.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Exerlog"),
        backgroundColor: backgroundColor.withOpacity(0.75),
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
                  Navigator.of(context).push(
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

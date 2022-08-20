import 'package:exerlog/UI/calendar/widgets/calendar_widget.dart';
import 'package:exerlog/UI/calendar/widgets/logout_button.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/core/theme/app_theme.dart';
import 'package:exerlog/src/widgets/SnackBars/noNetworkConnectionSnackBar.dart';
import 'package:exerlog/src/widgets/gradient_button.dart';
import 'package:exerlog/UI/workout/workout_page.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Stream<ConnectivityResult> _connectivityStream = Connectivity().onConnectivityChanged;

  @override
  void initState() {
    super.initState();
    _connectivityStream.listen((connectionResult) {
      if (connectionResult == ConnectivityResult.none) {
        _showNoNetworkConnectionSnackbar();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      builder: (context, theme) {
        return Scaffold(
          backgroundColor: theme.colorTheme.backgroundColorVariation,
          appBar: AppBar(
            title: Text("Exerlog"),
            backgroundColor: theme.colorTheme.backgroundColorVariation.withOpacity(0.75),
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
      },
    );
  }

  void _showNoNetworkConnectionSnackbar() => ScaffoldMessenger.of(context).showSnackBar(noNetworkConnectionSnackBar(AppTheme.of(context)));
}

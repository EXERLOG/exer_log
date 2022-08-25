import 'package:connectivity/connectivity.dart';
import 'package:exerlog/UI/calendar/widgets/calendar_widget.dart';
import 'package:exerlog/UI/calendar/widgets/logout_button.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/workout/workout_page.dart';
import 'package:exerlog/src/core/base/extensions/context_extension.dart';
import 'package:exerlog/src/core/theme/app_theme.dart';
import 'package:exerlog/src/dependency.dart';
import 'package:exerlog/src/utils/text_constants.dart';
import 'package:exerlog/src/widgets/gradient_button.dart';
import 'package:exerlog/src/widgets/snack_bars/no_network_connection_snackbar.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  @override
  void initState() {
    super.initState();
    ref.read(Dependency.connectivityResult.stream).listen((connectionResult) {
      if (connectionResult == ConnectivityResult.none) {
        _showNoNetworkConnectionSnackBar();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      builder: (context, theme) {
        ColorTheme colorTheme = theme.colorTheme;
        return Scaffold(
          backgroundColor: colorTheme.backgroundColorVariation,
          appBar: AppBar(
            title: Text(Texts.appName),
            backgroundColor:
                colorTheme.backgroundColorVariation.withOpacity(0.75),
            actions: [
              LogoutButton(),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CalendarWidget(),
                RaisedGradientButton(
                  child: Text(
                    Texts.startNewWorkout.toUpperCase(),
                    style: buttonTextSmall,
                  ),
                  width: context.width * .8,
                  onPressed: _navigateToWorkoutScreen,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToWorkoutScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutPage(null),
      ),
    );
  }

  void _showNoNetworkConnectionSnackBar() =>
      ScaffoldMessenger.of(context).showSnackBar(
        noNetworkConnectionSnackBar(AppTheme.of(context)),
      );
}

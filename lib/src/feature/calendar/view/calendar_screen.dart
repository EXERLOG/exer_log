import 'package:connectivity/connectivity.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/workout/workout_page.dart';
import 'package:exerlog/src/core/base/extensions/context_extension.dart';
import 'package:exerlog/src/core/theme/app_theme.dart';
import 'package:exerlog/src/dependency.dart';
import 'package:exerlog/src/feature/calendar/widgets/calendar_widget.dart';
import 'package:exerlog/src/feature/calendar/widgets/logout_button.dart';
import 'package:exerlog/src/utils/text_constants.dart';
import 'package:exerlog/src/widgets/gradient_button.dart';
import 'package:exerlog/src/widgets/snack_bars/no_network_connection_snackbar.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(Dependency.connectivityResult.stream).listen((ConnectivityResult connectionResult) {
      if (connectionResult == ConnectivityResult.none) {
        _showNoNetworkConnectionSnackBar();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      builder: (BuildContext context, AppTheme theme) {
        ColorTheme colorTheme = theme.colorTheme;
        return Scaffold(
          backgroundColor: colorTheme.backgroundColorVariation,
          appBar: AppBar(
            title: const Text(Texts.appName),
            backgroundColor:
                colorTheme.backgroundColorVariation.withOpacity(0.75),
            actions: const <Widget>[
              LogoutButton(),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget> [
                CalendarWidget(),
                Column(
                  children: [
                    RaisedGradientButton(
                      width: context.width * .8,
                      onPressed: _navigateToExerciseScreen,
                      child: Text(
                        Texts.startNewWorkout.toUpperCase(),
                        style: buttonTextSmall,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    RaisedGradientButton(
                      width: context.width * .8,
                      onPressed: _navigateToWorkoutScreen,
                      child: Text(
                        Texts.startFromTemplate.toUpperCase(),
                        style: buttonTextSmall,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToExerciseScreen() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => WorkoutPage(null),
      ),
    );
  }

  void _navigateToWorkoutScreen() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => WorkoutPage(null, isTemplateMode: true),
      ),
    );
  }

  void _showNoNetworkConnectionSnackBar() =>
      ScaffoldMessenger.of(context).showSnackBar(
        noNetworkConnectionSnackBar(AppTheme.of(context)),
      );
}

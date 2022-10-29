import 'package:exerlog/UI/exercise/add_exercise_widget.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/core/theme/app_theme.dart';
import 'package:exerlog/src/widgets/gradient_button.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class AddExerciseAlert extends StatelessWidget {

  const AddExerciseAlert(
    this.addExercise,
    this.nameWidget,
      {Key? key,}
  ) : super(key: key);
  final ExerciseNameSelectionWidget nameWidget;
  final RaisedGradientButton addExercise;
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      builder: (BuildContext context, AppTheme theme) {
        return Dialog(
          backgroundColor: theme.colorTheme.backgroundColorVariation,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(15),
            height: screenHeight * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'New Exercise',
                  style: mediumTitleStyleWhite,
                  textAlign: TextAlign.center,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: nameWidget,
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.5,
                  child: addExercise,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/widgets/gradient_button.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class DeleteWorkoutAlert extends StatefulWidget {

  const DeleteWorkoutAlert(this.deleteWorkoutButton, {Key? key}) : super(key: key);
  final RaisedGradientButton deleteWorkoutButton;
  @override
  _DeleteWorkoutAlertState createState() => _DeleteWorkoutAlertState();
}

class _DeleteWorkoutAlertState extends State<DeleteWorkoutAlert> {
  String name = '';
  bool? template;

  @override
  void initState() {
    template = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(builder: (context, theme) {
      return Dialog(
        backgroundColor: theme.colorTheme.backgroundColorVariation,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(15),
          height: screenHeight * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Are you sure you want to delete this workout?',
                style: mediumTitleStyleWhite,
                textAlign: TextAlign.center,
              ),
              Container(
                height: screenHeight * 0.05,
                width: screenWidth * 0.5,
                child: widget.deleteWorkoutButton,
              ),
            ],
          ),
        ),
      );
    },);
  }
}

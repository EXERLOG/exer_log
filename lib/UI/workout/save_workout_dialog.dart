import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class SaveWorkoutContent extends StatefulWidget {
  const SaveWorkoutContent(
    this.setWorkout,
  );

  final Function(String, bool) setWorkout;

  @override
  _SaveWorkoutContentState createState() => _SaveWorkoutContentState();
}

class _SaveWorkoutContentState extends State<SaveWorkoutContent> {
  String name = '';
  bool template = false;

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      builder: (context, theme) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              style: setStyle,
              onChanged: (value) {
                name = value;
                widget.setWorkout(name, template);
              },
              decoration: InputDecoration(
                hintText: 'Enter workout name',
                hintStyle: setHintStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: theme.colorTheme.primaryColor,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: theme.colorTheme.primaryColor,
                  ),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: theme.colorTheme.primaryColor,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Save as template',
                  style: mediumTitleStyleWhite,
                ),
                Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  fillColor: MaterialStateProperty.all<Color>(
                    theme.colorTheme.primaryColor,
                  ),
                  value: this.template,
                  onChanged: (bool? value) {
                    setState(() {
                      template = value!;
                      widget.setWorkout(name, template);
                    });
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

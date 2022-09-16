import 'package:exerlog/Bloc/exercise_bloc.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseInputField extends StatefulWidget {
  ExerciseInputField({
    required this.setExerciseName,
  });

  final Function(String) setExerciseName;

  @override
  _ExerciseInputFieldState createState() => _ExerciseInputFieldState();
}

class _ExerciseInputFieldState extends State<ExerciseInputField> {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      builder: (context, theme) {
        return FutureBuilder<List<String>>(
          future: getExerciseNames(),
          builder:
              (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Center(child: Text("Error"));
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Theme(
                        data: ThemeData(
                          inputDecorationTheme: InputDecorationTheme(
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
                          textTheme: TextTheme(subtitle1: setStyle),
                        ),
                        child: Autocomplete<String>(
                          optionsMaxHeight: 100,
                          onSelected: widget.setExerciseName,
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            widget.setExerciseName(textEditingValue.text);
                            return snapshot.data!.where(
                              (String name) => name.toLowerCase().startsWith(
                                    textEditingValue.text.toLowerCase(),
                                  ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            }
          },
        );
      },
    );
  }
}

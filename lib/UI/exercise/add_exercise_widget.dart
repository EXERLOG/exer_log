import 'package:exerlog/Bloc/exercise_bloc.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/core/theme/app_theme.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class ExerciseNameSelectionWidget extends StatefulWidget {

  ExerciseNameSelectionWidget({required this.setExercisename, Key? key})
      : super(key: key) {
    setExercisename = setExercisename;
  }
  Function(String) setExercisename;
  @override
  _ExerciseNameSelectionWidgetState createState() => _ExerciseNameSelectionWidgetState();
}

class _ExerciseNameSelectionWidgetState extends State<ExerciseNameSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      builder: (BuildContext context, AppTheme theme) {
        return FutureBuilder<List<String>>(
          future: getExerciseNames(),
          builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error'),
                );
              } else {
                return Center(
                  child: Theme(
                    data: ThemeData(
                        inputDecorationTheme: InputDecorationTheme(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: theme.colorTheme.primaryColor,
                            ),
                            //  when the TextFormField in unfocused
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: theme.colorTheme.primaryColor,
                            ),
                            //  when the TextFormField in focused
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: theme.colorTheme.primaryColor),
                          ),
                        ),
                      textTheme: TextTheme(
                        subtitle1: setStyle,
                      ),
                    ),
                    child: Container(
                      child: Autocomplete<String>(
                        optionsMaxHeight: 100,
                        onSelected: (String value) {
                          widget.setExercisename(value);
                        },
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          widget.setExercisename(textEditingValue.text);
                          return snapshot.data!.where(
                            (String name) => name.toLowerCase().startsWith(
                                  textEditingValue.text.toLowerCase(),
                                ),
                          );
                        },
                      ),
                    ),
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

import 'package:exerlog/Bloc/exercise_bloc.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class ExerciseNameSelectionWidget extends StatefulWidget {
  Function(String) setExercisename;

  ExerciseNameSelectionWidget({
    required this.setExercisename,
  }) {
    setExercisename = this.setExercisename;
  }
  @override
  _ExerciseNameSelectionWidgetState createState() => _ExerciseNameSelectionWidgetState();
}

class _ExerciseNameSelectionWidgetState extends State<ExerciseNameSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      builder: (context, theme) {
        return FutureBuilder<List<String>>(
          future: getExerciseNames(),
          builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error'),
                );
              } else {
                return Center(
                  child: Theme(
                    data: ThemeData(
                        inputDecorationTheme: new InputDecorationTheme(
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
                        )),
                    child: Container(
                      child: Autocomplete<String>(
                        optionsMaxHeight: 100,
                        onSelected: (value) {
                          widget.setExercisename(value);
                        },
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          widget.setExercisename(textEditingValue.text);
                          return snapshot.data!.where((String name) => name.toLowerCase().startsWith(
                                textEditingValue.text.toLowerCase(),
                              ));
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

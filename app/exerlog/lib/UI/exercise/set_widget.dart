import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exerlog/Bloc/exercise_bloc.dart';
import 'package:exerlog/Bloc/max_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetWidget extends StatefulWidget {
  final String name;
  final Exercise exercise;
  Function(Sets, int) addNewSet;
  int id;

  SetWidget(
      {required this.name,
      required this.exercise,
      required this.addNewSet,
      required this.id});
  @override
  _SetWidgetState createState() => _SetWidgetState();
}

class _SetWidgetState extends State<SetWidget> {
  double percent = 0.0;
  Sets sets = new Sets(0, 0, 0, 0);
  TextEditingController setsController = new TextEditingController();
  TextEditingController repsController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();
  TextEditingController restController = new TextEditingController();
  List types = ['reps', 'sets', 'weight', 'rest'];
  List setList = [0, 0, 0.0, 0.0];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Exercise>(
      future: getExerciseByName(widget.name),
      builder: (BuildContext context, AsyncSnapshot<Exercise> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: getSetWidget(snapshot),
            );
          }
          if (!snapshot.hasData) {
            print("No data");
            return Center(
              child: getSetWidget(snapshot),
            );
          } else {
            return getSetWidget(snapshot);
          }
        }
      },
    );
  }

  Container getSetWidget(AsyncSnapshot<Exercise> snapshot) {
    return Container(
      height: screenHeight * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Center(
                child: Text(
              "#" + (widget.id + 1).toString(),
              style: setStyle,
            )),
            width: screenWidth * 0.08,
          ),
          Container(
            child: getTextField(0, snapshot),
            width: screenWidth * 0.145,
          ),
          Container(
            child: getTextField(1, snapshot),
            width: screenWidth * 0.145,
          ),
          Container(
            child: getTextField(2, snapshot),
            width: screenWidth * 0.145,
          ),
          Container(
            child: getTextField(3, snapshot),
            width: screenWidth * 0.145,
          ),
          Container(
            child: Center(
                child: Text(
               (percent * 100).round().toString() + "%",
              style: setStyle,
            )),
            width: screenWidth * 0.11,
          ),
        ],
      ),
    );
  }

  TextField getTextField(int type, AsyncSnapshot<Exercise> snapshot) {
    List controllers = [
      repsController,
      setsController,
      weightController,
      restController
    ];
    return TextField(
      cursorColor: Colors.white,
      style: setStyle,
      textAlign: TextAlign.center,
      keyboardType: type == 2 ? TextInputType.text : TextInputType.number,
      controller: controllers[type],
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: getHintText(snapshot, type),
        hintStyle: setHintStyle,
      ),
      onChanged: (value) {
        sets.reps = getInfo(repsController.text, 0);
        sets.sets = getInfo(setsController.text, 0);
        if (weightController.text.contains('%')) {
          // set weight to be percentage of max
          var regex = new RegExp(r'\D');
          getWeightFromMax(weightController.text.replaceAll(regex, ''))
              .then((result) {
            setState(() {
              sets.weight = result;
              weightController.text = result.toString();
            });
          });
        }
          sets.weight = getInfo(weightController.text, 1);
          sets.rest = getInfo(restController.text, 1);
          if (sets.sets == 0.0) {
            sets.sets = 1;
          }
          widget.addNewSet(sets, widget.id);
          setPercentageOfMax(sets.weight).then((value) {
            setState(() {
              percent = value;
            });
          });
      },
      onEditingComplete: () {
        sets.reps = getInfo(repsController.text, 0);
        sets.sets = getInfo(setsController.text, 0);
        sets.weight = getInfo(weightController.text, 1);
        sets.rest = getInfo(restController.text, 1);
        if (sets.sets == 0.0) {
          sets.sets = 1;
        }
        widget.addNewSet(sets, widget.id);
      },
    );
  }

  dynamic getInfo(String text, int type) {
    try {
      if (type == 0) {
        return int.parse(text);
      } else {
        return double.parse(text);
      }
    } catch (Exception) {
      if (type == 0) {
        return 0;
      } else {
        return 0.0;
      }
    }
  }
  Future<double> setPercentageOfMax(double weight) async {
    print("UPDATING");
    var result = await getSpecificMax(widget.name, 1);
    if (result.length < 1) {
      print("Hello");
      double count = 0;
      while (result.length < 1 || count > 20) {
        result = await getSpecificMax(widget.name, count);
        count++;
      }
      return (weight / (result[0].weight / maxTable[(count - 1).toInt()]));
    }
    return (weight / result[0].weight)
        .roundToDouble();
  }

  Future<double> getWeightFromMax(String percentage) async {
    var result = await getSpecificMax(widget.name, 1);
    if (result.length < 1) {
      double count = 2;
      while (result.length < 1 || count > 20) {
        result = await getSpecificMax(widget.name, count);
        count++;
      }
      return (result[0].weight / maxTable[(count - 1).toInt()]).roundToDouble();
    }
    print(result);
    return (result[0].weight * (double.parse(percentage) / 100))
        .roundToDouble();
  }

  String getHintText(AsyncSnapshot<Exercise> snapshot, int type) {
    String returnText = '';
    try {
      returnText = snapshot.data?.sets[widget.id][types[type]].toString() ?? '';
    } catch (Exception) {}
    return returnText;
  }
}

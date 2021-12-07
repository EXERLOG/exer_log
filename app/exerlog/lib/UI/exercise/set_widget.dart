import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exerlog/Bloc/exercise_bloc.dart';
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

  SetWidget({required this.name, required this.exercise, required this.addNewSet, required this.id});
  @override
  _SetWidgetState createState() => _SetWidgetState();

}

class _SetWidgetState extends State<SetWidget> {
  Sets sets = new Sets(0, 0, 0, 0);
  TextEditingController setsController = new TextEditingController();
  TextEditingController repsController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();
  TextEditingController restController = new TextEditingController();
  List types = ['reps', 'sets', 'weight', 'rest'];
  List setList = [
    0,
    0,
    0.0,
    0.0
  ];
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
              child: Text("Error"),
            );
          } else {
            return Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Center(child: Text("#" + (widget.id +1).toString(), style: setStyle,)),
                    width: 40,
                  ),
                  Container(
                    child: getTextField(0, snapshot),
                    width: 60,
                  ),
                  Container(
                    child: getTextField(1, snapshot),
                    width: 60,
                  ),
                  Container(
                    child: getTextField(2, snapshot),
                    width: 60,
                  ),
                  Container(
                    child: getTextField(3, snapshot),
                    width: 60,
                  )
                ],
              ),
            );
          }
        }
      },
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
      keyboardType: TextInputType.number,
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
          sets.weight = getInfo(weightController.text, 1);
          sets.rest = getInfo(restController.text, 1);
          widget.addNewSet(sets, widget.id);
      },
      onEditingComplete: () {
          sets.reps = getInfo(repsController.text, 0);
          sets.sets = getInfo(setsController.text, 0);
          sets.weight = getInfo(weightController.text, 1);
          sets.rest = getInfo(restController.text, 1);
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

  String getHintText(AsyncSnapshot<Exercise> snapshot, int type) {
    String returnText = '';
    try {
      returnText = snapshot.data?.sets[widget.id][types[type]].toString() ?? '';
    } catch (Exception) {
    }
    return returnText;

  }

}
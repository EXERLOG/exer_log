import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exerlog/Bloc/exercise_bloc.dart';
import 'package:exerlog/Bloc/max_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/maxes/max_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrevSetWidget extends StatefulWidget {
  final String name;
  final Exercise exercise;
  Function(Exercise, Sets, int) addNewSet;
  //Function(Sets, int) createNewSet;
  final bool isTemplate;
  int id;

  PrevSetWidget(
      {required this.name,
      required this.exercise,
      required this.addNewSet,
      //required this.createNewSet,
      required this.id,
      required this.isTemplate});
  @override
  _PrevSetWidgetState createState() => _PrevSetWidgetState();
}

class _PrevSetWidgetState extends State<PrevSetWidget>
    with AutomaticKeepAliveClientMixin {
  int percent = 0;
  double oneRepMax = 0.0;
  Sets sets = new Sets(0, 0, 0, 0);
  String setsController = "";
  String repsController = "";
  String weightController = "";
  String restController = "";
  String percentageController = "";
  List types = ['reps', 'sets', 'weight', 'rest', ''];
  List setList = [0, 0, 0.0, 0.0];

  @override
  void initState() {
    //percentageProvider = Provider.of<PercentageProvider>(context, listen: false);
    // TODO: implement initState
    super.initState();
  }

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
            child: getText(0, snapshot),
            width: screenWidth * 0.145,
          ),
          Container(
            child: getText(1, snapshot),
            width: screenWidth * 0.145,
          ),
          Container(
            child: getText(2, snapshot),
            width: screenWidth * 0.145,
          ),
          Container(
            child: getText(3, snapshot),
            width: screenWidth * 0.145,
          ),
          Container(
            child: getText(4, snapshot),
            width: screenWidth * 0.08,
          ),
        ],
      ),
    );
  }

  Widget getText(int type, AsyncSnapshot<Exercise> snapshot) {
    List controllers = [
      repsController,
      setsController,
      weightController,
      restController,
      percentageController
    ];
    if (types[type] == '') {
      print("HelloMax");
      double weight = snapshot.data?.sets[widget.id][types[2]];
      return MaxInformation(id: snapshot.data!.name, weight: weight);
      //widget.addNewSet(sets, widget.id);
    } else {
      controllers[type] = getHintText(snapshot, type);
      return Center(
      child: Text(
        controllers[type],
        style: setStyle,
      ),
    );
    }
  }

  

  String getHintText(AsyncSnapshot<Exercise> snapshot, int type) {
    String returnText = '';
    try {
      returnText = snapshot.data?.sets[widget.id][types[type]].toString() ?? '';
    } catch (Exception) {}
    return returnText;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

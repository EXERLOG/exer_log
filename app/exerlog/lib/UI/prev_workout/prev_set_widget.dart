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
    return getSetWidget();
  }

  Container getSetWidget() {
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
            child: getText(0),
            width: screenWidth * 0.145,
          ),
          Container(
            child: getText(1),
            width: screenWidth * 0.145,
          ),
          Container(
            child: getText(2),
            width: screenWidth * 0.145,
          ),
          Container(
            child: getText(3),
            width: screenWidth * 0.145,
          ),
          Container(
            child: getText(4),
            width: screenWidth * 0.08,
          ),
        ],
      ),
    );
  }

  Widget getText(int type) {
    List controllers = [
      widget.exercise.sets[widget.id].reps.toString(),
      widget.exercise.sets[widget.id].sets.toString(),
      widget.exercise.sets[widget.id].weight.toString(),
      widget.exercise.sets[widget.id].rest.toString(),
      percentageController
    ];
    if (types[type] == '') {
      print("HelloMax");
      double weight = widget.exercise.sets[widget.id].weight;
      return MaxInformation(id: widget.exercise.name, weight: weight);
      //widget.addNewSet(sets, widget.id);
    } else {
      return Center(
      child: Text(
        controllers[type],
        style: setStyle,
      ),
    );
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/maxes/max_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrevSetWidget extends StatefulWidget {

  PrevSetWidget({
    required this.name,
    required this.exercise,
    required this.addNewSet,
    required this.id,
    required this.isTemplate,
    Key? key,
  }) : super(key: key);

  final String name;
  final Exercise exercise;
  final bool isTemplate;
  int id;

  Function(Exercise, Sets, int) addNewSet;

  @override
  _PrevSetWidgetState createState() => _PrevSetWidgetState();
}

class _PrevSetWidgetState extends State<PrevSetWidget>
    with AutomaticKeepAliveClientMixin {
  int percent = 0;
  double oneRepMax = 0.0;
  Sets sets = Sets(0, 0.0, 0.0, 0, 0.0);
  String setsController = '';
  String repsController = '';
  String weightController = '';
  String restController = '';
  String percentageController = '';
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
            width: screenWidth * 0.08,
            child: Center(
              child: Text(
                '#${widget.id + 1}',
                style: setStyle,
              ),
            ),
          ),
          Container(
            width: screenWidth * 0.145,
            child: getText(0),
          ),
          Container(
            width: screenWidth * 0.145,
            child: getText(1),
          ),
          Container(
            width: screenWidth * 0.145,
            child: getText(2),
          ),
          Container(
            width: screenWidth * 0.145,
            child: getText(3),
          ),
          Container(
            width: screenWidth * 0.08,
            child: getText(4),
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
      return MaxInformation(id: widget.exercise.name, sets: widget.exercise.sets[widget.id]);
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

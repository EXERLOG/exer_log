import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exerlog/Bloc/exercise_bloc.dart';
import 'package:exerlog/Bloc/max_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/maxes.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/exercise/totals_widget.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/maxes/max_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '';

class SetWidget extends StatefulWidget {
  final String name;
  final Exercise exercise;
  Function(Exercise, Sets, int) addNewSet;
  Function(Exercise, Sets, int) removeSet;
  Function? updateExercise;
  Function updateTotal;
  final counter;
  //Function(Sets, int) createNewSet;
  final bool isTemplate;
  int id;

  SetWidget(
      {required this.name,
      required this.exercise,
      required this.addNewSet,
      required this.removeSet,
      //required this.createNewSet,
      required this.counter,
      required this.id,
      required this.isTemplate,
      this.updateExercise,
      required this.updateTotal
      });
  @override
  _SetWidgetState createState() => _SetWidgetState();
}

class _SetWidgetState extends State<SetWidget>
  with AutomaticKeepAliveClientMixin {
  int percent = 0;
  Max? oneRepMax;
  Sets sets = new Sets(0, 0.0, 0.0, 0, 0.0);
  String percentageController = '0%';
  TextEditingController setsController = new TextEditingController();
  TextEditingController repsController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();
  TextEditingController restController = new TextEditingController();
  List types = ['reps', 'sets', 'weight', 'rest', ''];
  MaxInformation? maxinfoWidget;
  ValueNotifier<SetData> _notifier = ValueNotifier(new SetData(0.0, 0));
  
  @override
  void initState() {
    //percentageProvider = Provider.of<PercentageProvider>(context, listen: false);
    // TODO: implement initState
    _notifier.value.weight = widget.exercise.sets[widget.id].weight;
    _notifier.value.reps = widget.exercise.sets[widget.id].reps;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return getSetWidget();
  }


  SlidableAutoCloseBehavior getSetWidget() {
    return SlidableAutoCloseBehavior(
      closeWhenTapped: true,
      child: Slidable(
        key: ValueKey(widget.counter),
        endActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: ScrollMotion(),
    
          // A pane can dismiss the Slidable.
          //dismissible: DismissiblePane(onDismissed: () {}),
    
          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            TextButton(
              onPressed: () {
                  widget.removeSet(widget.exercise, sets, widget.id);
              },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFFE4A49))),
              child: Icon(Icons.delete, color: Colors.white,),
            ),
          ],
        ),
    
        child: Container(
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
                child: getTextField(0),
                width: screenWidth * 0.145,
              ),
              Container(
                child: getTextField(1),
                width: screenWidth * 0.145,
              ),
              Container(
                child: getTextField(2),
                width: screenWidth * 0.145,
              ),
              Container(
                child: getTextField(3),
                width: screenWidth * 0.145,
              ),
              Container(
                child: ValueListenableBuilder(
                valueListenable: _notifier,
                builder: (BuildContext context, SetData value, Widget? child) {
                  return MaxInformation(id: widget.exercise.name, sets: widget.exercise.sets[widget.id], setMax: setOneRepMax, setPercentage: setPercentage);
                } 
              ), 
                width: screenWidth * 0.11,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setPercentage(percent) {
    widget.exercise.sets[widget.id].percentage = percent;
    sets.percentage = percent;
  }

  void setOneRepMax(Max max) {
    oneRepMax = max;
  }

  Widget getTextField(int type) {
    List controllers = [
      repsController,
      setsController,
      weightController,
      restController
    ];


      controllers[type].text = getHintText(type);
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
        hintText: getHintText(type),
        hintStyle: setHintStyle,
      ),
      onChanged: (value) {
        sets.reps = getInfo(repsController.text, 0);
        sets.sets = getInfo(setsController.text, 0);
        if (weightController.text.contains('%')) {
          // set weight to be percentage of max
          var regex = new RegExp(r'\D');
          sets.weight = getWeightFromMax(weightController.text.replaceAll(regex, ''));
          weightController.text = sets.weight.toString();
        }
        sets.weight = getInfo(weightController.text, 1);
        sets.rest = getInfo(restController.text, 1);
        if (sets.sets == 0.0) {
          sets.sets = 1;
        }
        widget.addNewSet(widget.exercise, sets, widget.id);
        _notifier.value = new SetData(sets.weight, sets.reps);
        widget.updateTotal();
        //percent = (sets.weight / oneRepMax).round();
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

  double getWeightFromMax(String percentage) {
    var result = oneRepMax!.weight / maxTable[oneRepMax!.reps -1];
    double the_percent = double.parse(percentage) / 100;
    return (result * the_percent).roundToDouble();
  }

  String getHintText(int type) {
    List listType = [
      widget.exercise.sets[widget.id].reps,
      widget.exercise.sets[widget.id].sets,
      widget.exercise.sets[widget.id].weight,
      widget.exercise.sets[widget.id].rest,
    ];
    String returnText = '';
    try {
      returnText = listType[type].toString();
    } catch (Exception) {}
    return returnText;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class SetData {
  double weight;
  int reps;

  SetData(this.weight, this.reps);
}
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/maxes.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/maxes/max_builder.dart';
import 'package:exerlog/src/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SetWidget extends StatefulWidget {
  SetWidget({
    required this.name,
    required this.exercise,
    required this.addNewSet,
    required this.removeSet,
    required this.counter,
    required this.id,
    required this.isTemplate,
    this.updateExercise,
    required this.updateTotal,
    Key? key,
  }) : super(key: key);

  final String name;
  final Exercise exercise;
  final int counter;
  final bool isTemplate;
  int id;

  Function(Exercise, Sets, int) addNewSet;
  Function(Exercise, Sets, int) removeSet;
  Function? updateExercise;
  Function updateTotal;

  @override
  SetWidgetState createState() => SetWidgetState();
}

class SetWidgetState extends State<SetWidget>
    with AutomaticKeepAliveClientMixin {
  int percent = 0;
  Max? oneRepMax;
  Sets sets = Sets(0, 0.0, 0.0, 0, 0.0);
  String percentageController = '0%';
  TextEditingController setsController = TextEditingController();
  TextEditingController repsController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController restController = TextEditingController();
  List<String> types = <String>['reps', 'sets', 'weight', 'rest', ''];
  MaxInformation? maxinfoWidget;
  ValueNotifier<SetData> _notifier = ValueNotifier<SetData>(SetData(0.0, 0));

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
        key: ValueKey<dynamic>(widget.counter),
        endActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // A pane can dismiss the Slidable.
          //dismissible: DismissiblePane(onDismissed: () {}),

          // All actions are defined in the children parameter.
          children: <Widget>[
            // A SlidableAction can have an icon and/or a label.
            TextButton(
              onPressed: () {
                widget.removeSet(widget.exercise, sets, widget.id);
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFFFE4A49))),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ],
        ),
        child: Container(
          height: screenHeight * 0.05,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Center(
                  child: Text(
                    '#${widget.id + 1}',
                    style: setStyle,
                  ),
                ),
              ),
              Expanded(
                flex: 15,
                child: getTextField(0),
              ),
              Expanded(
                flex: 15,
                child: getTextField(1),
              ),
              Expanded(
                flex: 15,
                child: getTextField(2),
              ),
              Expanded(
                flex: 15,
                child: getTextField(3),
              ),
              Expanded(
                flex: 10,
                child: ValueListenableBuilder<SetData>(
                  valueListenable: _notifier,
                  builder:
                      (BuildContext context, SetData value, Widget? child) {
                    return MaxInformation(
                      id: widget.exercise.name,
                      sets: widget.exercise.sets[widget.id],
                      setMax: setOneRepMax,
                      setPercentage: setPercentage,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setPercentage(double percent) {
    widget.exercise.sets[widget.id].percentage = percent;
    sets.percentage = percent;
  }

  void setOneRepMax(Max max) {
    oneRepMax = max;
  }

  Widget getTextField(int type) {
    List<TextEditingController> controllers = <TextEditingController>[
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
      inputFormatters: type == 2
          ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}%?'))]
          : type == 3
              ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}'))]
              : <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
      controller: controllers[type],
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: getHintText(type),
        hintStyle: setHintStyle,
      ),
      onChanged: (String value) {
        sets.reps = getInfo(repsController.text, 0);
        sets.sets = getInfo(setsController.text, 0);
        if (weightController.text.contains('%')) {
          // set weight to be percentage of max
          RegExp regex = RegExp(r'\D');
          sets.weight =
              getWeightFromMax(weightController.text.replaceAll(regex, ''));
          weightController.text = sets.weight.toString();
        }
        sets.weight = getInfo(weightController.text, 1);
        sets.rest = getInfo(restController.text, 1);
        if (sets.sets == 0.0) {
          sets.sets = 1;
        }
        widget.addNewSet(widget.exercise, sets, widget.id);
        _notifier.value = SetData(sets.weight, sets.reps);
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
    } catch (exception) {
      if (type == 0) {
        return 0;
      } else {
        return 0.0;
      }
    }
  }

  double getWeightFromMax(String percentage) {
    double result = oneRepMax!.weight / maxTable[oneRepMax!.reps - 1];
    double thePercent = double.parse(percentage) / 100;
    return (result * thePercent).roundToDouble();
  }

  String getHintText(int type) {
    List<num> listType = <num>[
      widget.exercise.sets[widget.id].reps,
      widget.exercise.sets[widget.id].sets,
      widget.exercise.sets[widget.id].weight,
      widget.exercise.sets[widget.id].rest,
    ];
    String returnText = '';
    try {
      returnText = listType[type].toString();
    } catch (exception) {
      Log.debug('hint error: $exception');
    }
    return returnText;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class SetData {
  SetData(this.weight, this.reps);

  double weight;
  int reps;
}

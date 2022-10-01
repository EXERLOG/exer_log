import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/widgets/gradient_button.dart';
import 'package:flutter/cupertino.dart';

class ExerciseTotalsWidget extends StatefulWidget {

  ExerciseTotalsWidget({required this.totals, required this.index,Key? key}) : super(key: key);

  TotalsData totals;
  int index;

  @override
  _ExerciseTotalsWidgetState createState() => _ExerciseTotalsWidgetState();
}

class _ExerciseTotalsWidgetState extends State<ExerciseTotalsWidget> {
  List _list = [];
  List<String> endings = [' reps', ' sets', ' kgs', ' kgs/rep'];

  @override
  Widget build(BuildContext context) {
    _list = [
      widget.totals.totalReps,
      widget.totals.totalSets,
      widget.totals.totalWeight,
      widget.totals.avgWeight
    ];
    return SizedBox(
      height: screenHeight * 0.04,
      width: screenWidth * 0.3,
      child: RaisedGradientButton(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF34D1C2), Color(0xFF31A6DC)],
        ),
        onPressed: () {
          setState(() {
            widget.index += 1;
            if (widget.index == 4) {
              widget.index = 0;
            }
          });
        },
        radius: 30,
        child: Text(
          _list[widget.index].toString() + endings[widget.index],
          style: buttonTextSmall,
        ),
      ),
    );
  }
}

class TotalsData {
  TotalsData(this.totalReps, this.totalSets, this.totalWeight, this.avgWeight);

  int totalReps;
  int totalSets;
  double totalWeight;
  double avgWeight;
}

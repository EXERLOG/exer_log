import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/widgets/gradient_button.dart';
import 'package:exerlog/src/widgets/gradient_button.dart';
import 'package:flutter/cupertino.dart';

class ExerciseTotalsWidget extends StatefulWidget {
  TotalsData totals;
  int index;

  ExerciseTotalsWidget({required this.totals, required this.index});
  @override
  _ExerciseTotalsWidgetState createState() => _ExerciseTotalsWidgetState();
}

class _ExerciseTotalsWidgetState extends State<ExerciseTotalsWidget> {
  List _list = [];
  List endings = [" reps", " sets", " kgs", " kgs/rep"];
  @override
  Widget build(BuildContext context) {
    _list = [
      widget.totals.totalReps,
      widget.totals.totalSets,
      widget.totals.totalWeight,
      widget.totals.avg_weight
    ];
    return Container(
      height: screenHeight * 0.04,
      width: screenWidth * 0.3,
      child: RaisedGradientButton(
        child: Text(
          _list[widget.index].toString() + endings[widget.index],
          style: buttonTextSmall,
        ),
        gradient: LinearGradient(
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
      ),
    );
  }
}

class TotalsData {
  int totalReps;
  int totalSets;
  double totalWeight;
  double avg_weight;

  TotalsData(this.totalReps, this.totalSets, this.totalWeight, this.avg_weight);
}

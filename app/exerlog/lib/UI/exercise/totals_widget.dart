import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/gradient_button.dart';
import 'package:exerlog/UI/gradient_button.dart';
import 'package:flutter/cupertino.dart';

class ExerciseTotalsWidget extends StatefulWidget {
  TotalsData totals;
  int index;

  ExerciseTotalsWidget(this.totals, this.index) {
    totals = this.totals;
    index = this.index;
  }
  @override
  _ExerciseTotalsWidgetState createState() => _ExerciseTotalsWidgetState();
}

class _ExerciseTotalsWidgetState extends State<ExerciseTotalsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.04,
      width: screenWidth * 0.3,
      child: RaisedGradientButton(
          child: Text(
            widget.totals.total[widget.index],
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
          borderSize: 0),
    );
  }
}

class TotalsData {
  List<String> total;

  TotalsData(this.total) {
    total = this.total;
  }
}

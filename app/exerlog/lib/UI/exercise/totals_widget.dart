import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/gradient_button.dart';
import 'package:exerlog/UI/gradient_button.dart';
import 'package:flutter/cupertino.dart';

class TotalsWidget extends StatefulWidget {
  TotalsData totals;
  int index;

  TotalsWidget(this.totals, this.index) {
    totals = this.totals;
    index = this.index;
  }
  @override
  _TotalsWidgetState createState() => _TotalsWidgetState();
}

class _TotalsWidgetState extends State<TotalsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 150,
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

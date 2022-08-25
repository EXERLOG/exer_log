import 'package:exerlog/Bloc/max_bloc.dart';
import 'package:exerlog/Models/maxes.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/UI/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MaxInformation extends StatefulWidget {
  final String id;
  Sets sets;
  Function? setMax;
  Function? setPercentage;

  MaxInformation(
      {required this.id, required this.sets, this.setMax, this.setPercentage});
  @override
  _MaxInformationState createState() => _MaxInformationState();
}

class _MaxInformationState extends State<MaxInformation> {
  double oneRepMax = 0.0;
  String text = "0%";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Max>(
      future: getOneRepMax(widget.id),
      builder: (BuildContext context, AsyncSnapshot<Max> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasError) {
            if (minimumOneWeightRep(widget.sets)) {
              oneRepMax = widget.sets.weight / maxTable[widget.sets.reps - 1];
              widget.setMax!(Max(oneRepMax, 1, 0, widget.id));
              widget.setPercentage!(widget.sets.weight / oneRepMax);
            }

            return Center(
              child: Text(
                oneRepMaxPercentLabel(widget.sets.weight, oneRepMax),
                style: setStyle,
              ),
            );
          } else {
            oneRepMax =
                snapshot.data!.weight / maxTable[snapshot.data!.reps - 1];
            if (snapshot.data!.weight == 0.0) {
              print("No max");
            }
            if (widget.setMax != null) {
              widget.setMax!(snapshot.data);
              widget.setPercentage!(widget.sets.weight / oneRepMax);
            }

            return Center(
              child: Text(
                oneRepMaxPercentLabel(widget.sets.weight, oneRepMax),
                style: setStyle,
              ),
            );
          }
        }
      },
    );
  }

  String oneRepMaxPercentLabel(double weight, double oneRepMax) {
    if (oneRepMax > 0.0) {
      text = ((weight / oneRepMax) * 100).round().toString() + "%";
    }

    return this.text;
  }

  bool minimumOneWeightRep(Sets sets) {
    return sets.weight != 0.0 && sets.reps < 30 && sets.reps > 0;
  }
}

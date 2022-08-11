import 'package:exerlog/UI/exercise/totals_widget.dart';
import 'package:exerlog/UI/global.dart';
import 'package:flutter/material.dart';

class ExerciseCardHeader extends StatelessWidget {
  final double height;
  final String title;
  final int index;
  final ValueNotifier<TotalsData> notifier;

  const ExerciseCardHeader({
    required this.notifier,
    required this.title,
    required this.height,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: height,
            child: Text(
              title,
              style: mediumTitleStyleWhite,
            ),
          ),
          Container(
            child: ValueListenableBuilder(
              valueListenable: notifier,
              builder: (BuildContext context, TotalsData value, Widget? child) {
                return ExerciseTotalsWidget(
                  totals: value,
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

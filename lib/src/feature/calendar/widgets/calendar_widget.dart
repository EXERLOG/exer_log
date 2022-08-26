import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/core/base/extensions/context_extension.dart';
import 'package:exerlog/src/core/theme/app_theme.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';

import 'date_widget.dart';

class CalendarWidget extends StatelessWidget {
  final List<String> monthNames = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      builder: (context, theme) {
        ColorTheme colorTheme = theme.colorTheme;
        return FittedBox(
          child: Container(
            padding: EdgeInsets.all(20),
            width: context.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: colorTheme.shadow,
                  offset: Offset(0, 3),
                  blurRadius: 5,
                  spreadRadius: 5,
                ),
              ],
              color: colorTheme.backgroundColorVariation,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    _getCurrentMonth,
                    style: mediumTitleStyleWhite,
                  ),
                ),
                Divider(
                  color: colorTheme.white.withOpacity(0.75),
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _getDateColumns(),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  String get _getCurrentMonth => monthNames[DateTime.now().month - 1];
}

List<Widget> _getDateColumns() {
  List weekdayNames = [
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
    'SUN',
  ];
  List<Widget> dates = [];
  int today = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;
  DateTime now = DateTime.now();
  const int daysInAWeek = 7;

  List<List<DateTime>> weekList = List.generate(daysInAWeek, (index) => []);

  /// Month could span 4-6 weeks which is 4-6 columns
  /// which day of the week does the first fall on
  DateTime first = now.subtract(Duration(days: today - 1));
  DateTime last = new DateTime(year, month + 1, 0);

  /// If the first of the month falls anywhere else than on a monday
  /// then get the dates before the first as well

  /// Calculate how many days and weeks should be shown in the calendar
  DateTime previousMonth = first.subtract(Duration(days: first.weekday));

  int daysToShow =
      last.day + (first.weekday - 1) + (daysInAWeek - last.weekday);
  double weeks = daysToShow / daysInAWeek;
  if (weeks is! int) {
    /// If the weeks is not an int then we need to add an extra week
    weeks = weeks.toInt() + 1;
  }

  int currentDay = 0;
  int j = 0;
  while (currentDay != daysToShow) {
    if (j == daysInAWeek) {
      j = 0;
    }

    DateTime dayToAdd = previousMonth.add(Duration(days: currentDay + 1));
    weekList[j].add(dayToAdd);
    j++;
    currentDay++;
  }

  for (int i = 0; i < daysInAWeek; i++) {
    List<Widget> _dates = [];

    /// Add all weekdays name
    _dates.add(
      Text(
        weekdayNames[i],
        style: setStyle,
        textScaleFactor: 1,
      ),
    );
    for (int j = 0; j < weekList[i].length; j++) {
      _dates.add(
        DateWidget(weekList[i][j]),
      );
    }
    dates.add(
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _dates,
      ),
    );
  }

  return dates;
}

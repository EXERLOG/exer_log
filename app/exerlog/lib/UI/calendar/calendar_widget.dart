import 'package:exerlog/Bloc/workout_bloc.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/calendar/date_widget.dart';
import 'package:exerlog/UI/global.dart';
import 'package:flutter/material.dart';

class CalendarWidget extends StatefulWidget {

  @override 
  _CalendarWidgetState createState() => _CalendarWidgetState();

}

class _CalendarWidgetState extends State<CalendarWidget> {
  List<String> monthNames = ["January","February","March","April","May","June","July", "August","September","October","November","December"];
  
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder<List<Widget>>(
      future: getDates(),
      builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          } else {
      return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                offset: Offset(0, 3),
                blurRadius: 5,
                spreadRadius: 5),
          ],
          color: backgroundColor,
        ),
        height: screenHeight*0.4,
        child: Column(
          children: [
            Container(
              height: screenHeight*0.05,
              child: Text(monthNames[DateTime.now().month-1], style: mediumTitleStyleWhite,),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right:20),
              child: Divider(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: snapshot.data!,
            )
          ],
        ),
      );
    }
  }
      }
    );
  }
  }

  Future<List<Widget>> getDates() async {
    List weekdayNames = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    List<Widget> datelist = [];
    int today = DateTime.now().day;
    int month = DateTime.now().month;
    int year = DateTime.now().year;
    int weekday = DateTime.now().weekday;
    DateTime now = DateTime.now();
    
    List week_list = [[],[],[],[],[],[],[]];
    List<Widget> dates = [];
    // month could span 4-6 weeks which is 4-6 columns
    // which day of the week does the first fall on
    DateTime first = now.subtract(Duration(days: today-1));
    DateTime last = new DateTime(year,month+1,0);
    // if the first of the month falls anywhere else than on a monday
    // then get the dates before the first as well

    // calculate how many days and weeks should be shown in the calendar
    DateTime prev_month = first.subtract(Duration(days: first.weekday));

    final workout_list = await getWorkoutsWithinDates(prev_month, last.add(Duration(days: 7-last.weekday+1)));
    int days_to_show = last.day + (first.weekday-1) + (7-last.weekday);
    double weeks = days_to_show/7;
    if (weeks is !int) {
      // if the weeks is not an int then we need to add an extra week
      weeks = weeks.toInt() + 1;
    }

    int current_day = 0;
    int j = 0;
    Map finalWorkoutList = {};
    while (current_day != days_to_show) {
      if (j == 7) {
        j = 0;
      }

      DateTime day_to_add = prev_month.add(Duration(days: current_day + 1));
      week_list[j].add(day_to_add);
      bool workoutAdded = false;
      for (int i = 0; i < workout_list.length; i++) {
        if (day_to_add.month == workout_list[i].date?.month && day_to_add.day == workout_list[i].date?.day)  {
          finalWorkoutList[day_to_add] = workout_list[i];
        }
      }

      j++;
      current_day++;
    }

    for (int i = 0; i < 7; i++) {
      List<Widget> dates = [];
      dates.add(Text(weekdayNames[i], style: setStyle,));
      for (int j = 0; j < week_list[i].length; j++) {
        Workout workout = finalWorkoutList[week_list[i][j]];
        dates.add(DateWidget(week_list[i][j], workout));
      }
      datelist.add(Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: dates,
      ));
    }
      
    
    return datelist;
  }
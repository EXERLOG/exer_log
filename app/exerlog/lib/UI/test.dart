import 'package:exerlog/Bloc/workout_bloc.dart';
import 'package:exerlog/Models/exercise.dart';
import 'package:exerlog/Models/sets.dart';
import 'package:exerlog/Models/workout.dart';
import 'package:exerlog/UI/workout/workout_builder.dart';
import 'package:flutter/material.dart';
import 'gradient_button.dart';
import 'global.dart';
import 'maxes/max_builder.dart';

class LoginForm extends StatefulWidget {
  LoginForm(this.title, {Key? key}) : super(key: key);
  String title = "0";
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool login = true;
  int index = 0;
  List<Tab> tabs = <Tab>[
    Tab(child: Text("Login", style: loginOptionTextStyle,),),
    Tab(child: Text("Sign up", style: loginOptionTextStyle,)),
  ];
  int id = 0; 

  List workoutList = [
    "U4EwfqTt0X8evCK0PsoY",
    "nT0sNrqFfUjNnK3h02ty",
    "oQF0dF6VCcPCRrxlFLqj",
    "ouEYVKFHFTR3PGsQVII0"
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
        color: backgroundColor,
        child: Container(
            padding: EdgeInsets.only(top: 200, bottom: 300, left: 30, right: 30),
              child: Container(
                child: Stack(
                  children: [Container(
                    height: 230,
                    decoration: BoxDecoration(
                          color: Color(0xFF2E2C42),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.2),
                                offset: Offset(0, 3),
                                blurRadius: 10,
                                spreadRadius: 10)
                          ]),
                    child: DefaultTabController(
                        length: tabs.length,
                        // The Builder widget is used to have a different BuildContext to access
                        // closest DefaultTabController.
                        child: Builder(builder: (BuildContext context) {
                          final TabController tabController =
                              DefaultTabController.of(context)!;
                          tabController.addListener(() {
                            if (!tabController.indexIsChanging) {
                              setState(() {
                                index = tabController.index;
                                print(index);
                              });
                              // Your code goes here.
                              // To get index of current tab use tabController.index
                            }
                          });
                          return Column(
                            children: [
                              Container(
                                height: 30,
                                child: AppBar(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                flexibleSpace: TabBar(
                                  tabs: tabs,
                                ),
                            ),
                              ),
                            Container(
                              height: 200,
                              child: TabBarView(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    child:  Text('Hello')//MaxInformation(id: 'BB Bench Pres'),
                                  ),
                                  Container(
                                    color: Colors.red,
                                  )
                                ],
                              ),
                            ),
                            ],
                          );
                        })),
                  ),
                 Positioned(
                child: RaisedGradientButton(
                  borderSize: 8,
                  radius: 30,
                  child: Text(index.toString(), style: buttonText), 
                  gradient: LinearGradient(
                    colors: <Color>[Color(0xFF34D1C2), Color(0xFF31A6DC)],
                  ), 
                  onPressed: () {
                    Sets set1 = Sets(10, 120, 60, 1);
                    Sets set2 = Sets(5, 120, 80, 1);
                    Sets set3 = Sets(4, 120, 100, 1);
                    Exercise exercise = new Exercise("BB Bench Press", [set1, set2, set3], ["chest"]);
                    Workout workout = Workout([exercise], 'notes', 'good', 120, 'Strength', 'chest workout');
                    saveWorkout(workout);
                    setState(() {
                      if (id == workoutList.length -1) {
                          id = 0;
                        } else {
                          id ++;
                      }
                    });
                    if (index > 0) {
                      print("Index is one");
                    }
                    else {
                      print("Index is zero");
                    }
                  },
                ),
                right: 60,
                left: 60,
                bottom: 0,
              )]
                ),
              ),
   
            ));
  }
  }
      
      
      //   child: DefaultTabController(
      //   length: tabs.length, 
      //   initialIndex: 0, 
      //     child: TabBar(
      //       indicatorColor: textColorBlue,
      //       tabs:tabs
      //       ),  
      // ),
      // )

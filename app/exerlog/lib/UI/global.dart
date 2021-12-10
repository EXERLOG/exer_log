import 'package:flutter/material.dart';

// height and width of screen
double screenHeight = 0.0;
double screenWidth = 0.0;

// colors
Color backgroundColor = Color(0xFF2D2B41);
Color textColorLoginForm = Color(0xFFACACB4);
Color textColorBlue = Color(0xFF31A6DC);
Color greenTextColor = Color(0xFF34D2C1);

// text styles
TextStyle buttonTextSmall = TextStyle(
    color: backgroundColor,
    fontFamily: "Avenir",
    fontWeight: FontWeight.w800,
    fontSize: 12);
TextStyle buttonText = TextStyle(
    color: backgroundColor,
    fontFamily: "Avenir",
    fontWeight: FontWeight.w800,
    fontSize: 18);
TextStyle loginOptionTextStyle = TextStyle(
    letterSpacing: 1,
    color: textColorLoginForm,
    fontFamily: "Avenir",
    fontWeight: FontWeight.w300,
    fontSize: 18);
TextStyle loginOptionTextStyleSelected = TextStyle(
    letterSpacing: 1,
    color: textColorBlue,
    fontFamily: "Avenir",
    fontWeight: FontWeight.w400,
    fontSize: 18);
TextStyle mediumTitleStyleWhite = TextStyle(
    letterSpacing: 1,
    color: Colors.white,
    fontFamily: "Avenir",
    fontWeight: FontWeight.bold,
    fontSize: 18);
TextStyle setHintStyle = TextStyle(
  letterSpacing: 1,
  color: Colors.white.withOpacity(0.2),
  fontFamily: "Avenir",
  fontSize: 15,
);
TextStyle setStyle = TextStyle(
  letterSpacing: 1,
  color: greenTextColor,
  fontFamily: "Avenir",
  fontSize: 15,
);
TextStyle greenButtonTextThin = TextStyle(
  letterSpacing: 1,
  color: greenTextColor,
  fontFamily: "Avenir",
  fontWeight: FontWeight.w300,
  fontSize: 18,
);
TextStyle smallTitleStyleWhite = TextStyle(
    letterSpacing: 1,
    color: Colors.white,
    fontFamily: "Avenir",
    fontWeight: FontWeight.bold,
    fontSize: 12);


// one rep max calculation table
List<double> maxTable = [
  1.0,
  0.97,
  0.94,
  0.92,
  0.89,
  0.86,
  0.83,
  0.81,
  0.78,
  0.75,
  0.73,
  0.71,
  0.70,
  0.68,
  0.67,
  0.65,
  0.64,
  0.63,
  0.61,
  0.60,
  0.59,
  0.58,
  0.57,
  0.56,
  0.55,
  0.54,
  0.53,
  0.52,
  0.51,
  0.5
];
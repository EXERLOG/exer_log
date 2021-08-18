import 'package:flutter/material.dart';
import 'gradient_button.dart';
import 'global.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({ Key? key }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10, top: 200, right: 10, bottom: 200),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xFF322F4A),
                  backgroundColor,
                  backgroundColor
                ],
                begin: Alignment(-1.0, -1),
                end: Alignment(-1.0, 1),
                stops: [0.0, 0.3, 1.0])),
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              height: 250,
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
            ),
            Positioned(
              child: RaisedGradientButton(
                borderSize: 8,
                radius: 30,
                child: Text("Log In", style: buttonText), 
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFF34D1C2), Color(0xFF31A6DC)],
                ), 
                onPressed: () {
                  print("Hello");
                },
              ),
              right: 60,
              left: 60,
              bottom: 80,
            ),
          ],
        ));
  }
}
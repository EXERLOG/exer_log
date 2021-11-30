import 'package:exerlog/Bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'gradient_button.dart';
import 'global.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({ Key? key }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool login = true;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
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
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: Column(children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: (){
                              setState(() {
                                login = true;
                              });
                            },
                            child: Container(
                              child: Text("LOGIN", style: login ? loginOptionTextStyleSelected : loginOptionTextStyle,),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                login = false;
                              });
                            },
                            child: Container(
                              child: Text("SIGN UP", style: login ? loginOptionTextStyle : loginOptionTextStyleSelected),
                            ),
                          )
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Divider(
                          thickness: 0.8,
                          indent: 10,
                          endIndent: 10,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        Container(
                          child: AnimatedAlign(
                            alignment: login ? Alignment.centerLeft : Alignment.centerRight,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn,
                            child: Container(
                              height: 3,
                              width: 50,
                              margin: EdgeInsets.only(left: 70, right: 84, top: 6),
                              color: Color(0xFF31A6DC),
                            ),
                          ),
                        ) 
                      ],
                    )
                  ],
                  ),
                ),
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
          )),
    );
  }
}
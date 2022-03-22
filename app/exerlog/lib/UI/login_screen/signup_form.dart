import 'package:exerlog/UI/global.dart';
import 'package:exerlog/UI/login_screen/login_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignupForm extends StatefulWidget {
  LoginData loginData;
  SignupForm(this.loginData);
  @override
  _SignupFormState createState() => _SignupFormState();

}

class _SignupFormState extends State<SignupForm> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController1 = new TextEditingController();
  TextEditingController passwordController2 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Container(
            height: height*0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: greenTextColor,
                ),
                child: Container(
                  margin: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: backgroundColor,
                ),
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          child: Icon(Icons.mail, color: greenTextColor,)),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: TextField(
                            onChanged: (value) {
                              widget.loginData.email = value;
                            },
                            controller: emailController,
                            style: mediumTitleStyleWhite,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "email"
                            )
                          ),
                        ),
                      ],
                    ),
                  )
                )
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: greenTextColor,
                ),
                child: Container(
                  margin: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: backgroundColor,
                ),
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          child: Icon(Icons.lock, color: greenTextColor,)),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: TextField(
                            controller: passwordController1,
                            obscureText: true,
                            style: mediumTitleStyleWhite,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "password"
                            )
                          ),
                        ),
                      ],
                    ),
                  )
                )
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: greenTextColor,
                ),
                child: Container(
                  margin: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: backgroundColor,
                ),
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          child: Icon(Icons.lock, color: greenTextColor,)),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: TextField(
                            onChanged: (value) {
                              if (value == passwordController1.text) {
                                print("Same!");
                                widget.loginData.password = value;
                              } else {
                                widget.loginData.password = '';
                              }
                            },
                            controller: passwordController2,
                            obscureText: true,
                            style: mediumTitleStyleWhite,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "repeat password"
                            )
                          ),
                        ),
                      ],
                    ),
                  )
                )
              ),
            ],),
          ),
        ],)
    );
  }

}
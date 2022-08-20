import 'package:exerlog/UI/global.dart';
import 'package:flutter/material.dart';

SnackBar noNetworkConnectionSnackBar() => SnackBar(
      backgroundColor: redBackgroundColor,
      duration: Duration(
          days:
              365), // set to a year so that it doesn't disappear automatically untill the user clicks on the Dismiss button
      content: Text('No network connection, please check your connection'),
      action: SnackBarAction(
        textColor: textColorBlue,
        label: 'Dismiss',
        onPressed: () {},
      ),
    );

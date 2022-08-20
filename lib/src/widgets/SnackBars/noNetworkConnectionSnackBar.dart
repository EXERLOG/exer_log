import 'package:exerlog/src/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

SnackBar noNetworkConnectionSnackBar(AppTheme theme) => SnackBar(
      backgroundColor: theme.colorTheme.error,
      duration: Duration(days: 365), // set to a year so that it doesn't disappear automatically untill the user clicks on the Dismiss button
      content: Text('No network connection, please check your connection'),
      action: SnackBarAction(
        textColor: theme.colorTheme.secondaryColor,
        label: 'Dismiss',
        onPressed: () {},
      ),
    );

import 'package:exerlog/src/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

typedef ThemeBuilder = Widget Function(BuildContext context, AppTheme theme);

class ThemeProvider extends StatefulWidget {

  const ThemeProvider({
    required this.builder,
    Key? key,
  }) : super(key: key);
  final ThemeBuilder builder;

  @override
  State<ThemeProvider> createState() => _ThemeProviderState();
}

class _ThemeProviderState extends State<ThemeProvider> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _themeLookup());
  }

  AppTheme _themeLookup() => AppTheme.of(context);
}

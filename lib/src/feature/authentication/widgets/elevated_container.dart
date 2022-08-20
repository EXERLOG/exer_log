import 'package:exerlog/src/core/base/extensions/context_extension.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class ElevatedContainer extends StatelessWidget {
  const ElevatedContainer({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      builder: (context, theme) {
        return Center(
          child: Container(
            height: context.height * 0.50,
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: theme.colorTheme.backgroundColorVariation,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: theme.colorTheme.shadow,
                  offset: Offset(0, 3),
                  blurRadius: 10,
                  spreadRadius: 10,
                )
              ],
            ),
            child: child,
          ),
        );
      },
    );
  }
}

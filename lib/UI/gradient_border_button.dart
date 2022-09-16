import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class GradientBorderButton extends StatefulWidget {
  final Widget child;
  final bool addButton;
  final Gradient? gradient;
  final double width;
  final double height;
  final Function onPressed;
  final double radius;
  final double borderSize;

  GradientBorderButton({
    required this.child,
    required this.onPressed,
    required this.radius,
    required this.borderSize,
    required this.addButton,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
  });
  @override
  _GradientBorderButtonState createState() => _GradientBorderButtonState();
}

class _GradientBorderButtonState extends State<GradientBorderButton> {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      builder: (context, theme) {
        final gradient = widget.gradient ??
            LinearGradient(
              colors: [
                theme.colorTheme.primaryColor,
                theme.colorTheme.secondaryColor,
              ],
            );
        Container cont;
        Container cont2;
        if (widget.addButton) {
          cont = Container(
              width: 30,
              height: 30,
              padding: EdgeInsets.all(widget.borderSize),
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(widget.radius / 2),
              ),
              child: Container(
                child: Center(
                    child: Icon(
                  Icons.add,
                  color: theme.colorTheme.primaryColor,
                  size: 20,
                )),
                decoration: BoxDecoration(
                  color: theme.colorTheme.backgroundColorVariation,
                  borderRadius: BorderRadius.circular(widget.radius),
                ),
              ));
          cont2 = Container(
            width: 30,
          );
        } else {
          cont = Container();
          cont2 = Container();
        }
        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(widget.radius),
          ),
          child: Container(
            padding: EdgeInsets.all(widget.borderSize),
            child: TextButton(
              onPressed: () {
                widget.onPressed();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [cont2, widget.child, cont],
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(theme.colorTheme.backgroundColorVariation),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    side: BorderSide(width: 0),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
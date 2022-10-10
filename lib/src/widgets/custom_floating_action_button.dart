import 'package:exerlog/src/core/theme/app_theme.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.size = 50.0,
  }) : super(key: key);
  final IconData icon;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) => ThemeProvider(
        builder: (BuildContext context, AppTheme theme) => Container(
          decoration: BoxDecoration(
            color: theme.colorTheme.primaryColor,
            borderRadius: BorderRadius.circular(size),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: theme.colorTheme.shadow,
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(size),
              child: Container(
                width: size,
                height: size,
                child: Center(
                  child: Icon(
                    icon,
                    color: theme.colorTheme.backgroundColorVariation,
                    size: size * 0.4,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

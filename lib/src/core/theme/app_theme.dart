import 'package:exerlog/src/core/theme/theme_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  final ColorTheme colorTheme;

  const AppTheme._({required this.colorTheme});

  static const _darkInstance = AppTheme._(
    colorTheme: ColorTheme(
      primaryColor: ThemeColor.primary,
      secondaryColor: ThemeColor.secondary,
      backgroundColor: ThemeColor.darkBlue,
      backgroundColorVariation: ThemeColor.darkBlueVariation,
      error: ThemeColor.red,
      disabled: ThemeColor.grey,
      white: ThemeColor.white,
      shadow: ThemeColor.shadow,
    ),
  );

  static const _lightInstance = AppTheme._(
    colorTheme: ColorTheme(
      primaryColor: ThemeColor.primary,
      secondaryColor: ThemeColor.secondary,
      backgroundColor: ThemeColor.darkBlue,
      backgroundColorVariation: ThemeColor.darkBlueVariation,
      error: ThemeColor.red,
      disabled: ThemeColor.grey,
      white: ThemeColor.white,
      shadow: ThemeColor.shadow,
    ),
  );

  static AppTheme of(BuildContext context) {
    final platformBrightness = MediaQuery.of(context).platformBrightness;
    return platformBrightness == Brightness.dark ? _darkInstance : _lightInstance;
  }
}

class ColorTheme {
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Color backgroundColorVariation;
  final Color error;
  final Color disabled;
  final Color white;
  final Color shadow;

  const ColorTheme({
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.backgroundColorVariation,
    required this.error,
    required this.disabled,
    required this.white,
    required this.shadow,
  });
}

import 'package:exerlog/src/core/theme/app_theme.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';

@immutable
class AlertDialogModel<T> {
  const AlertDialogModel({
    required this.title,
    this.subtitle,
    this.content,
    required this.buttons,
  });

  final String title;
  final String? subtitle;
  final Widget? content;
  final Map<String, T> buttons;
}

extension Present<T> on AlertDialogModel<T> {
  Future<T?> present(BuildContext context, {bool barrierDismissible = true}) {
    return showDialog<T?>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return ThemeProvider(builder: (context, AppTheme theme) {
          return AlertDialog(
            backgroundColor: theme.colorTheme.backgroundColorVariation,
            titleTextStyle: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: theme.colorTheme.white),
            contentTextStyle: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(color: theme.colorTheme.white.withOpacity(0.5)),
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (subtitle != null) Text(subtitle!),
                if (content != null) content!,
              ],
            ),
            actions: buttons.entries.map(
              (entry) {
                return TextButton(
                  style: TextButton.styleFrom(
                    primary: theme.colorTheme.white,
                  ),
                  child: Text(entry.key),
                  onPressed: () {
                    Navigator.of(context).pop(entry.value);
                  },
                );
              },
            ).toList(),
          );
        });
      },
    );
  }
}

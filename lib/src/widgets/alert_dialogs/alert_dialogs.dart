import 'package:flutter/material.dart';

import 'alert_dialog_impl.dart';

/// Delete workout dialog
@immutable
class _DeleteDialog extends AlertDialogModel<bool> {
  const _DeleteDialog({required String objName})
      : super(
          title: 'Delete $objName',
          subtitle: 'Are you sure you want to delete this $objName?',
          buttons: const {
            'CANCEL': false,
            'DELETE': true,
          },
        );
}

Future<bool> showDeleteWorkoutDialog(BuildContext context) {
  return const _DeleteDialog(objName: 'workout').present(context).then(
        (value) => value ?? false,
      );
}

/// Add new exercise dialog
@immutable
class _AddNewExerciseDialog extends AlertDialogModel<bool> {
  _AddNewExerciseDialog({required String objName, Widget? content})
      : super(
          title: 'New $objName',
          subtitle:
              'You can add a new exercise name or select from a existing one',
          content: content,
          buttons: const {
            'CANCEL': false,
            'ADD': true,
          },
        );
}

Future<bool> showAddNewExerciseDialog(BuildContext context, Widget? content) {
  return _AddNewExerciseDialog(
    objName: 'Exercise',
    content: content,
  ).present(context, barrierDismissible: false).then(
        (value) => value ?? false,
      );
}

/// View or Redo Exercise
@immutable
class _ViewOrRedoExerciseDialog extends AlertDialogModel<bool> {
  _ViewOrRedoExerciseDialog({required String objName})
      : super(
          title: 'Previous $objName',
          subtitle: 'Do you want to view or redo?',
          buttons: const {
            'VIEW': false,
            'REDO': true,
          },
        );
}

Future<bool> showViewOrRedoAlertDialog(BuildContext context) {
  return _ViewOrRedoExerciseDialog(
    objName: 'workout',
  ).present(context, barrierDismissible: false).then(
        (value) => value ?? false,
      );
}

/// Save workout dialog
@immutable
class _SaveWorkoutDialog extends AlertDialogModel<bool> {
  _SaveWorkoutDialog({required String objName, Widget? content})
      : super(
          title: 'Save $objName',
          subtitle: 'Save a workout by adding a name',
          content: content,
          buttons: const {
            'CANCEL': false,
            'SAVE': true,
          },
        );
}

Future<bool> showSaveWorkoutDialog(BuildContext context, Widget? content) {
  return _SaveWorkoutDialog(
    objName: 'workout',
    content: content,
  ).present(context, barrierDismissible: false).then(
        (value) => value ?? false,
      );
}

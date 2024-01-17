import 'package:flutter/material.dart';

void showErrorSnackBar(
    BuildContext context, {
      String error = 'Ein Fehler ist aufgetreten.',
      int duration = 3000,
    }) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(error),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,
      ),
    );
}

void showSuccessSnackBar(
    BuildContext context, {
      String message = 'Erfolgreich',
      int duration = 3000,
    }) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ),
    );
}

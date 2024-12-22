import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class AlertHelper {
  static void showAwesomeSnackBar(
      BuildContext context, String title, String message, ContentType type) {
    final snackBarContent = AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: type,
    );

    final snackBar = SnackBar(content: snackBarContent);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

import 'package:flutter/material.dart';

Future<bool?> showConfirmationDialog(
    BuildContext context, {
      required String title,
      required String content,
      String confirmText = "Yes",
      String cancelText = "No",
    }) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmText),
          ),
        ],
      );
    },
  );
}
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      content: Text(
        content,
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
    ),
  );
}

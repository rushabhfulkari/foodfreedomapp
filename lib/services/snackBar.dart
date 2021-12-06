import 'package:flutter/material.dart';

void showSnackBar(context, text) {
  final snackBar = SnackBar(
    content: Text('$text'),
    duration: Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

import 'package:flutter/material.dart';

Padding legendItem(png) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child:
        Container(height: 30, width: 30, child: Image.asset('assets/$png.png')),
  );
}

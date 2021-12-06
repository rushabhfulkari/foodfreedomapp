import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';

Padding legendItem(png, text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(height: 30, width: 30, child: Image.asset('assets/$png.png')),
        SizedBox(
          width: 5,
        ),
        Text(
          "$text",
          style: TextStyle(
              color: black, fontSize: 14, fontWeight: FontWeight.w400),
        )
      ],
    ),
  );
}

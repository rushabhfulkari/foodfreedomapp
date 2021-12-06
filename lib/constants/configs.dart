import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';

const double defaultPadding = 20.0;

ButtonStyle buttonStyleFilled() {
  return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(white),
      fixedSize: MaterialStateProperty.all<Size>(
        Size(200, 45),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      )));
}

ButtonStyle buttonStyleFilled2() {
  return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(verySoftBlue),
      fixedSize: MaterialStateProperty.all<Size>(
        Size(200, 45),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      )));
}

ButtonStyle buttonStyleFilled3() {
  return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      fixedSize: MaterialStateProperty.all<Size>(
        Size(200, 45),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      )));
}

ButtonStyle buttonStyleWithBorder() {
  return OutlinedButton.styleFrom(
      side: BorderSide(width: 2.0, color: white),
      fixedSize: Size(200, 45),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ));
}

ButtonStyle buttonStyleWithBorderBlue() {
  return OutlinedButton.styleFrom(
      side: BorderSide(width: 2.0, color: verySoftBlue),
      fixedSize: Size(200, 45),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ));
}

OutlineInputBorder buildTextFieldOutlineInputBorder(size) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(
      width: 0,
      color: blackTextBox,
    ),
  );
}

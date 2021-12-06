import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/widgets.dart';

Container appSettingsOptions(
    double height, double width, assetPath, title, context, widget) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          assetImage(height, width, "assets/$assetPath", 0.06, 0.13),
          SizedBox(
            width: 20,
          ),
          Container(
              width: width * 0.4,
              child: autoSizeTextWidget(
                  "$title", white, "", FontWeight.w400, 16.0)),
          SizedBox(
            width: 10,
          ),
          Container(
            width: width * 0.25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                widget,
              ],
            ),
          )
        ],
      ),
    ),
  );
}

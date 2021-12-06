import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/widgets.dart';

InkWell settingsOptions(
    double height, double width, assetPath, title, context, onPressed) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            assetImage(height, width, "assets/$assetPath", 0.06, 0.13),
            SizedBox(
              width: 20,
            ),
            autoSizeTextWidget(
                "$title", white, "Raleway", FontWeight.w400, 16.0),
          ],
        ),
      ),
    ),
  );
}

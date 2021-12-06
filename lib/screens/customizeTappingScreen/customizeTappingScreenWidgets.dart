import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/widgets.dart';

InkWell avatarWidget(
    avatarName, onPressed, avatarSelectedIndex, avatarSelected, height, width) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      height: height * 0.3,
      width: width * 0.4,
      decoration: BoxDecoration(
        border: Border.all(
            color: white, width: avatarSelectedIndex == avatarSelected ? 2 : 0),
        borderRadius: BorderRadius.all(Radius.circular(7)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[veryLightOrange, moderateBlue.withOpacity(0)],
        ),
      ),
      child: Container(
        height: height * 0.25,
        width: width * 0.35,
        child: assetImage(height, width, "assets/$avatarName.png", 0.25, 0.35),
      ),
    ),
  );
}

InkWell bgMusicWidget(bgMusicName, onPressed, bgMusicSelectedIndex,
    bgMusicSelected, height, width, color1, color2, bgMusicText) {
  return InkWell(
    onTap: onPressed,
    child: Stack(
      children: [
        Container(
            height: height * 0.18,
            width: width * 0.4,
            child: Image.asset(
              "assets/$bgMusicName.jpeg",
              fit: BoxFit.fill,
            )),
        Container(
          height: height * 0.18,
          width: width * 0.4,
          decoration: BoxDecoration(
            border: Border.all(
                color: white,
                width: bgMusicSelectedIndex == bgMusicSelected ? 2 : 0),
            borderRadius: BorderRadius.all(Radius.circular(7)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[color1, color2],
            ),
          ),
        ),
        Container(
          height: height * 0.18,
          width: width * 0.4,
          child: Center(
            child: AutoSizeText(
              "$bgMusicText",
              maxLines: 1,
              style: TextStyle(
                  color: white, fontSize: 20.0, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ],
    ),
  );
}

Row titleText(text) {
  return Row(
    children: [
      AutoSizeText(
        "$text",
        maxLines: 1,
        style: TextStyle(
            color: white, fontSize: 20.0, fontWeight: FontWeight.w400),
      )
    ],
  );
}

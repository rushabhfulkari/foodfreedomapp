import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/configs.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/models/checkInModel.dart';
import 'package:foodfreedomapp/screens/checkInScreen/checkInScreenConfigs.dart';
import 'package:foodfreedomapp/screens/checkInScreen/checkInScreenWidgets.dart';
import 'package:jiffy/jiffy.dart';

// ignore: must_be_immutable
class CheckInDetailsPage extends StatelessWidget {
  final CheckInModel checkInObject;

  CheckInDetailsPage({
    Key key,
    this.checkInObject,
  }) : super(key: key);

  double width, height;

  @override
  Widget build(BuildContext context) {
    Map temp = {};
    if (checkInObject.whatMakesYouFeel != "") {
      for (var i = 0; i < whatMakesYouFeelData['name'].length; i++) {
        if (checkInObject.whatMakesYouFeel.toString() ==
            "${whatMakesYouFeelData['name'][i]}") {
          print('${whatMakesYouFeelData['image'][i]}');
          temp = {
            'name': '${whatMakesYouFeelData['name'][i]}',
            'image': '${whatMakesYouFeelData['image'][i]}'
          };
        }
      }
    }

    var array = checkInObject.iAlsoFeel.split('//');
    array.remove('');

    Size size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBarWithBackButtonCheckInDetails(
            context, "${checkInObject.howIsYourDay}", () {
          Navigator.pop(context);
        }),
        body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [vividCyan, darkCyan])),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: defaultPadding * 1,
                ),
                AutoSizeText(
                  "${Jiffy(checkInObject.dateTime).format("EEEE,  dd MMM,  h:mm a")}"
                      .toUpperCase(),
                  maxLines: 1,
                  style: TextStyle(
                      color: white,
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: defaultPadding * 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleCheckInDetails("Title"),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: width * 0.85,
                        child: AutoSizeText(
                          "${checkInObject.title}",
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          maxFontSize: 18,
                          style: TextStyle(
                              color: white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      checkInObject.thoughts.toString() != ""
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titleCheckInDetails("Thoughts"),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: width * 0.85,
                                  child: AutoSizeText(
                                    "${checkInObject.thoughts}",
                                    textAlign: TextAlign.start,
                                    maxFontSize: 18,
                                    style: TextStyle(
                                        color: white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            )
                          : Container(),
                      titleCheckInDetails("How was the Day?"),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          checkInDetailsWidget(
                              "${checkInObject.howIsYourDay}"
                                  .replaceAll(" ", "")
                                  .toLowerCase(),
                              "${checkInObject.howIsYourDay}"),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      titleCheckInDetails("Feeling"),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          checkInDetailsWidget(
                              "${checkInObject.howDoYouFeelRightNow}"
                                  .replaceAll(" ", "")
                                  .toLowerCase(),
                              "${checkInObject.howDoYouFeelRightNow}"),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      titleCheckInDetails("Also Feeling"),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: array.length * height * 0.03,
                        child: ListView.builder(
                            itemCount: array.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Container(
                                  width: width * 0.85,
                                  child: AutoSizeText(
                                    "${array[index]}",
                                    textAlign: TextAlign.start,
                                    maxFontSize: 18,
                                    style: TextStyle(
                                        color: white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      checkInObject.iAlsoFeelText.toString() != ""
                          ? Column(
                              children: [
                                Container(
                                  width: width * 0.85,
                                  child: AutoSizeText(
                                    "${checkInObject.iAlsoFeelText}",
                                    textAlign: TextAlign.start,
                                    maxFontSize: 18,
                                    style: TextStyle(
                                        color: white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            )
                          : Container(),
                      titleCheckInDetails("Reasons"),
                      SizedBox(
                        height: 10,
                      ),
                      lastPageWhatMakesYouFeelWidget(
                        "${temp['image']}",
                        "${temp['name']}",
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text titleCheckInDetails(text) {
    return Text(
      "$text",
      style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.w400),
    );
  }

  Row checkInDetailsWidget(pngName, text) {
    return Row(
      children: [
        TextButton(
            onPressed: () {},
            style: selectButtonStyle6(),
            child: Container(
              height: 40,
              width: 40,
              child: Image.asset("assets/$pngName.png"),
            )),
        SizedBox(
          width: 10,
        ),
        Text(
          "$text",
          style: TextStyle(
              color: white, fontWeight: FontWeight.w400, fontSize: 18),
        ),
      ],
    );
  }
}

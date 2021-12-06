import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/models/checkInModel.dart';
import 'package:foodfreedomapp/models/tappingActivityDataModel.dart';
import 'package:foodfreedomapp/screens/checkInDetailsScreen/checkInDetailsScreenPage.dart';
import 'package:foodfreedomapp/screens/tappingDetailsScreen/tappingDetailsScreenPage.dart';
import 'package:foodfreedomapp/screens/tappingScreen/tappingScreenServices.dart';
import 'package:jiffy/jiffy.dart';

Container noActivitiesWidget(
    BuildContext context, height, width, text, buttonText, onPressed) {
  return Container(
    height: height * 0.7,
    width: width,
    child: Column(
      children: [
        Container(
          height: height * 0.62,
          child: Center(
            child: Text(
              "$text",
              textAlign: TextAlign.center,
              style: TextStyle(color: white, fontSize: 20),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Center(child: buttonRegular(onPressed, "$buttonText")),
        )
      ],
    ),
  );
}

Widget buildCheckInList(List<CheckInModel> checkInList, double height,
    double width, BuildContext context) {
  return Container(
    child: Column(
      children: [
        Container(
          height: height * 0.73,
          child: ListView.builder(
              padding: EdgeInsets.only(bottom: 50, left: 15, right: 15),
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: checkInList.length,
              addAutomaticKeepAlives: false,
              itemBuilder: (BuildContext context, int index) {
                CheckInModel checkInObject = checkInList[index];
                return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CheckInDetailsPage(
                            checkInObject: checkInObject,
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        index != checkInList.length - 1
                            ? Positioned(
                                bottom: 0,
                                right: 50,
                                child: Container(
                                  height: 20,
                                  width: 10,
                                  color: veryDarkGrey2.withOpacity(0.45),
                                ))
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            child: Container(
                              height: height * 0.1,
                              width: width * 0.9,
                              decoration: BoxDecoration(
                                  color: veryDarkGrey2.withOpacity(0.45)),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            activityScreenImageCheckInWidget(
                                                "${checkInObject.howIsYourDay}"
                                                    .replaceAll(" ", "")
                                                    .toLowerCase(),
                                                height),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: width * 0.5,
                                              child: AutoSizeText(
                                                "${checkInObject.title}",
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                maxFontSize: 16,
                                                style: TextStyle(
                                                    color: white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Container(
                                              width: width * 0.5,
                                              child: AutoSizeText(
                                                "${checkInObject.thoughts}",
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                maxFontSize: 16,
                                                style: TextStyle(
                                                    color: white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 10,
                                      right: 10,
                                      child: Text(
                                        "${Jiffy(checkInObject.dateTime).format("h:mm a, dd MMM")}",
                                        style: TextStyle(
                                            color: white, fontSize: 10),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ));
              }),
        ),
      ],
    ),
  );
}

Column activityScreenImageCheckInWidget(pngName, height) {
  return Column(
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            child: Container(
              height: height * 0.05,
              width: height * 0.07,
              child: Image.asset("assets/$pngName.png"),
            ),
          )
        ],
      ),
    ],
  );
}

Widget buildTappingActivityList(List<TappingActivityModel> tappingActivityList,
    double height, double width, BuildContext context, refFirebase) {
  return Container(
    child: Column(
      children: [
        Container(
          height: height * 0.73,
          child: ListView.builder(
              padding: EdgeInsets.only(bottom: 23, left: 15, right: 15),
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: tappingActivityList.length,
              addAutomaticKeepAlives: false,
              itemBuilder: (BuildContext context, int index) {
                TappingActivityModel tappingActivityObject =
                    tappingActivityList[index];
                return GestureDetector(
                    onTap: () {
                      buildCPI(context);
                      refFirebase
                          .child('Tapping Data')
                          .child('${tappingActivityObject.tappingKey}')
                          .once()
                          .then((DataSnapshot tappingSnapshot) {
                        var tappingObject = tappingDataServices(
                            tappingSnapshot.value,
                            tappingActivityObject.tappingKey);
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TappingDetailsPage(
                              tappingDetailsObject: tappingObject,
                            ),
                          ),
                        );
                      });
                    },
                    child: Stack(
                      children: [
                        index != tappingActivityList.length - 1
                            ? Positioned(
                                left: width * 0.09,
                                bottom: 0,
                                child: Container(
                                  height: 20,
                                  width: 10,
                                  color: tappingActivityObject.status !=
                                          "inprogress"
                                      ? pureCyan
                                      : veryDarkGrey2.withOpacity(0.45),
                                ))
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    child: Container(
                                      height: height * 0.1,
                                      width: width * 0.2,
                                      decoration: BoxDecoration(
                                          color:
                                              veryDarkGrey2.withOpacity(0.45)),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: height * 0.1,
                                            width: width * 0.2,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 35,
                                                  width: 35,
                                                  child: Image.asset(
                                                      tappingActivityObject
                                                                  .status ==
                                                              "inprogress"
                                                          ? "assets/inprogress.png"
                                                          : "assets/completed.png"),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  tappingActivityObject
                                                              .status ==
                                                          "inprogress"
                                                      ? "In\nProgress"
                                                          .toUpperCase()
                                                      : "Complete"
                                                          .toUpperCase(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: white,
                                                      fontSize: 10),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                  child: Container(
                                    height: height * 0.1,
                                    width: width * 0.6,
                                    decoration: BoxDecoration(
                                        color: veryDarkGrey2.withOpacity(0.45)),
                                    child: Stack(
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 8.0,
                                                  ),
                                                  child: activityScreenImageTappingWidget(
                                                      "${tappingActivityObject.image}",
                                                      context,
                                                      height),
                                                )
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0,
                                                            top: 10,
                                                            bottom: 15),
                                                    child: Container(
                                                      width: width * 0.453,
                                                      child: AutoSizeText(
                                                        "${tappingActivityObject.title}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            color: white,
                                                            fontSize: 10),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ],
                                        ),
                                        Positioned(
                                            bottom: 10,
                                            right: 10,
                                            child: Text(
                                              "${Jiffy(tappingActivityObject.dateTime).format("h:mm a, dd MMM")}",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: white, fontSize: 10),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ));
              }),
        ),
      ],
    ),
  );
}

Column activityScreenImageTappingWidget(imageUrl, context, height) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Container(
          height: height * 0.08,
          width: height * 0.08,
          child: Image.network("$imageUrl", fit: BoxFit.cover),
        ),
      )
    ],
  );
}

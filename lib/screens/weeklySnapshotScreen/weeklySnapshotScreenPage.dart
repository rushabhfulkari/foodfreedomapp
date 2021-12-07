import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/models/checkInModel.dart';
import 'package:foodfreedomapp/models/emotionalTempModel.dart';
import 'package:foodfreedomapp/models/emotionsModel.dart';
import 'package:foodfreedomapp/models/focusOnModel.dart';
import 'package:foodfreedomapp/screens/activityScreen/activityScreenServices.dart';
import 'package:foodfreedomapp/screens/weeklySnapshotScreen/weeklySnapshotScreenConfigs.dart';
import 'package:foodfreedomapp/screens/weeklySnapshotScreen/weeklySnapshotScreenWidgets.dart';
import 'package:foodfreedomapp/services/userDetails.dart';
import 'package:jiffy/jiffy.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

bool checkDataFetchedWeekly = false;

class WeeklySnapshaotPage extends StatefulWidget {
  @override
  _WeeklySnapshaotPageState createState() => _WeeklySnapshaotPageState();
}

class _WeeklySnapshaotPageState extends State<WeeklySnapshaotPage> {
  double height, width;

  DatabaseReference refFirebase = FirebaseDatabase.instance.reference();

  bool checkDataFetchedWeekly = false;

  var listToShow = [];

  List<EmotionalTemp> emotionalData;

  List<Emotions> emotionsData;

  List<FocusOn> focusOnData;

  DateTime today = DateTime.now();

  getDataWeeklySnapshot() {
    if (!checkDataFetchedWeekly) {
      refFirebase
          .child('Users')
          .child('$keyGlobal')
          .child('CheckIn')
          .orderByChild('dateTime')
          .limitToLast(7)
          .once()
          .then((DataSnapshot checkInSnapshot) {
        checkInListWeeklySnapshot =
            getCheckInDataService(checkInSnapshot.value);

        var endDay = Jiffy(today.toString()).format("EEE");

        listToShow = graphData['$endDay'];

        emotionalData = [
          EmotionalTemp(
              '${listToShow[0]}'.toUpperCase(),
              returnGraphValueText(today
                  .subtract(const Duration(days: 6))
                  .toString()
                  .substring(0, 10))),
          EmotionalTemp(
              '${listToShow[1]}'.toUpperCase(),
              returnGraphValueText(today
                  .subtract(const Duration(days: 5))
                  .toString()
                  .substring(0, 10))),
          EmotionalTemp(
              '${listToShow[2]}'.toUpperCase(),
              returnGraphValueText(today
                  .subtract(const Duration(days: 4))
                  .toString()
                  .substring(0, 10))),
          EmotionalTemp(
              '${listToShow[3]}'.toUpperCase(),
              returnGraphValueText(today
                  .subtract(const Duration(days: 3))
                  .toString()
                  .substring(0, 10))),
          EmotionalTemp(
              '${listToShow[4]}'.toUpperCase(),
              returnGraphValueText(today
                  .subtract(const Duration(days: 2))
                  .toString()
                  .substring(0, 10))),
          EmotionalTemp(
              '${listToShow[5]}'.toUpperCase(),
              returnGraphValueText(today
                  .subtract(const Duration(days: 1))
                  .toString()
                  .substring(0, 10))),
          EmotionalTemp('${listToShow[6]}'.toUpperCase(),
              returnGraphValueText(today.toString().substring(0, 10))),
        ];

        var doughnutGraphValueList;

        var percentageValueAnxious = 0;
        var percentageValueDown = 0;
        var percentageValueTired = 0;
        var percentageValueStressed = 0;
        var percentageValueOthers = 0;

        for (var i = 0; i < checkInListWeeklySnapshot.length; i++) {
          if (daysBetween(
                DateTime.parse(checkInListWeeklySnapshot[i].dateTime),
                today,
              ) <
              7) {
            if ('Anxious' ==
                checkInListWeeklySnapshot[i].howDoYouFeelRightNow) {
              percentageValueAnxious = percentageValueAnxious + 1;
            } else if ('Down' ==
                checkInListWeeklySnapshot[i].howDoYouFeelRightNow) {
              percentageValueDown = percentageValueDown + 1;
            } else if ('Tired' ==
                checkInListWeeklySnapshot[i].howDoYouFeelRightNow) {
              percentageValueTired = percentageValueTired + 1;
            } else if ('Stressed' ==
                checkInListWeeklySnapshot[i].howDoYouFeelRightNow) {
              percentageValueStressed = percentageValueStressed + 1;
            } else {
              percentageValueOthers = percentageValueOthers + 1;
            }
          }
        }

        var additionOfAll = percentageValueAnxious +
            percentageValueDown +
            percentageValueTired +
            percentageValueStressed +
            percentageValueOthers;
        doughnutGraphValueList = [
          int.parse(((percentageValueAnxious / additionOfAll) * 100)
              .toStringAsFixed(0)),
          int.parse(
              ((percentageValueDown / additionOfAll) * 100).toStringAsFixed(0)),
          int.parse(((percentageValueTired / additionOfAll) * 100)
              .toStringAsFixed(0)),
          int.parse(((percentageValueStressed / additionOfAll) * 100)
              .toStringAsFixed(0)),
          int.parse(((percentageValueOthers / additionOfAll) * 100)
              .toStringAsFixed(0)),
        ];

        emotionsData = [
          Emotions('Anxious', doughnutGraphValueList[0], palePink),
          Emotions('Down', doughnutGraphValueList[1], moderateCyanLimeGreen),
          Emotions('Tired', doughnutGraphValueList[2], veryLightBlue),
          Emotions(
              'Stressed', doughnutGraphValueList[3], slightlyDesaturatedViolet),
          Emotions('Others', doughnutGraphValueList[4], softYellow)
        ];

        focusOnData = [
          FocusOn('Myself', 25, darkCyanGreen),
          FocusOn('Health', 38, palePink),
          FocusOn('Food', 34, darkModerateBlue3),
          FocusOn('Money', 52, slightlyDesaturatedViolet),
          FocusOn('Others', 52, softYellow)
        ];
      }).then((value) {
        setState(() {
          checkDataFetchedWeekly = true;
        });
      });
    }
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  String returnGraphValueText(day) {
    for (var i = 0; i < checkInListWeeklySnapshot.length; i++) {
      if (day.toString() ==
          checkInListWeeklySnapshot[i].dateTime.toString().substring(0, 10)) {
        return checkInListWeeklySnapshot[i].howIsYourDay.toString();
      }
    }
    return "";
  }

  // ignore: missing_return
  int returnValueInTermsOfEmotion(emotion) {
    if (emotion == "Amazing") {
      return 5;
    } else if (emotion == "Pretty Good") {
      return 4;
    } else if (emotion == "Okay") {
      return 3;
    } else if (emotion == "Somewhat Bad") {
      return 2;
    } else if (emotion == "Horrible") {
      return 1;
    }
  }

  @override
  void initState() {
    super.initState();
    getDataWeeklySnapshot();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          appBar: appBarWithBackButtonCheckInDetails(context, "Weekly Snapshot",
              () {
            Navigator.pop(context);
          }),
          body: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[vividCyan, darkCyan],
              ),
            ),
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: checkDataFetchedWeekly
                    ? Column(children: [
                        emotionalTempChart(),
                        SizedBox(
                          height: 20,
                        ),
                        emotionsChart(),
                        SizedBox(
                          height: 20,
                        ),
                        focusOnChart(),
                        SizedBox(
                          height: 20,
                        ),
                      ])
                    : buildCPIWidget(height, width)),
          )),
    );
  }

  Container emotionalTempChart() {
    return Container(
      width: width * 0.9,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(Radius.circular(9)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              "Emotion Temperature",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Container(
                  height: height * 0.35,
                  width: width * 0.9,
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(
                        minorTicksPerInterval: 1,
                        minorTickLines: MinorTickLines(color: white, width: 0),
                        majorTickLines: MajorTickLines(color: white, width: 0),
                        axisLine: AxisLine(
                            color: white, width: 0, dashArray: <double>[0, 0]),
                        minorGridLines: MinorGridLines(
                            width: 0,
                            color: vividCyan,
                            dashArray: <double>[10, 5]),
                        majorGridLines: MajorGridLines(
                            width: 0,
                            color: vividCyan,
                            dashArray: <double>[10, 5]),
                        labelStyle: TextStyle(
                            color: vividCyan,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      borderWidth: 0,
                      borderColor: white,
                      primaryYAxis: NumericAxis(
                        interval: 1,
                        labelFormat: '       ',
                        maximumLabels: 2,
                        maximum: 5,
                        minimum: 1,
                        majorGridLines: MajorGridLines(
                            width: 0.5,
                            color: vividCyan,
                            dashArray: <double>[10, 5]),
                        minorTickLines: MinorTickLines(color: white, width: 0),
                        majorTickLines: MajorTickLines(color: white, width: 0),
                        placeLabelsNearAxisLine: true,
                        axisLine: AxisLine(
                            color: white, width: 0, dashArray: <double>[0, 0]),
                        labelStyle: TextStyle(
                            color: vividCyan,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      series: <ChartSeries<EmotionalTemp, String>>[
                        LineSeries<EmotionalTemp, String>(
                            dataSource: emotionalData,
                            xAxisName: 'Days',
                            markerSettings: MarkerSettings(
                              isVisible: true,
                              borderWidth: 1,
                              color: veryPaleCyan,
                              height: 12,
                              width: 12,
                            ),
                            yAxisName: 'Emotions',
                            xValueMapper: (EmotionalTemp emotionalTemp, _) =>
                                emotionalTemp.days,
                            yValueMapper: (EmotionalTemp emotionalTemp, _) =>
                                returnValueInTermsOfEmotion(
                                    emotionalTemp.emotions),
                            name: 'Emotional Temperature',
                            width: 3,
                            color: vividCyan)
                      ]),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    legendItem('amazing'),
                    SizedBox(
                      height: height * 0.022,
                    ),
                    legendItem(
                      'prettygood',
                    ),
                    SizedBox(
                      height: height * 0.023,
                    ),
                    legendItem(
                      'okay',
                    ),
                    SizedBox(
                      height: height * 0.025,
                    ),
                    legendItem(
                      'somewhatbad',
                    ),
                    SizedBox(
                      height: height * 0.025,
                    ),
                    legendItem(
                      'horrible',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container emotionsChart() {
    return Container(
      width: width * 0.9,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(Radius.circular(9)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              "Emotions",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                height: height * 0.25,
                width: width * 0.9,
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: SfCircularChart(series: <CircularSeries>[
                          DoughnutSeries<Emotions, String>(
                              dataSource: emotionsData,
                              cornerStyle: CornerStyle.bothFlat,
                              innerRadius: '60%',
                              radius: '100%',
                              pointColorMapper: (Emotions data, _) =>
                                  data.color,
                              xValueMapper: (Emotions data, _) => data.emotion,
                              yValueMapper: (Emotions data, _) => data.data)
                        ]),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            emotionsLegendItem(palePink, "Anxious"),
                            emotionsLegendItem(moderateCyanLimeGreen, "Down"),
                            emotionsLegendItem(veryLightBlue, "Tired"),
                            emotionsLegendItem(
                                slightlyDesaturatedViolet, "Stressed"),
                            emotionsLegendItem(softYellow, "Others"),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Container focusOnChart() {
    return Container(
      width: width * 0.9,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(Radius.circular(9)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              "Focus On",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                height: height * 0.25,
                width: width * 0.9,
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: SfCircularChart(series: <CircularSeries>[
                          RadialBarSeries<FocusOn, String>(
                              dataSource: focusOnData,
                              maximumValue: 100,
                              radius: '100%',
                              innerRadius: '30%',
                              cornerStyle: CornerStyle.bothCurve,
                              pointColorMapper: (FocusOn data, _) => data.color,
                              xValueMapper: (FocusOn data, _) => data.reason,
                              yValueMapper: (FocusOn data, _) => data.data)
                        ]),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            focusOnLegendItem(palePink, "Myself"),
                            focusOnLegendItem(moderateCyanLimeGreen, "Health"),
                            focusOnLegendItem(veryLightBlue, "Food"),
                            focusOnLegendItem(
                                slightlyDesaturatedViolet, "Money"),
                            focusOnLegendItem(softYellow, "Others"),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Padding emotionsLegendItem(color, text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Container(
              height: 20,
              width: 20,
              decoration: new BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              )),
          SizedBox(
            width: 5,
          ),
          Text("$text",
              style: TextStyle(
                fontSize: 12,
              )),
        ],
      ),
    );
  }
}

Padding focusOnLegendItem(color, text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Row(
      children: [
        Container(
            height: 15,
            width: 30,
            decoration: new BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(9)),
              shape: BoxShape.rectangle,
            )),
        SizedBox(
          width: 5,
        ),
        Text("$text",
            style: TextStyle(
              fontSize: 12,
            )),
      ],
    ),
  );
}

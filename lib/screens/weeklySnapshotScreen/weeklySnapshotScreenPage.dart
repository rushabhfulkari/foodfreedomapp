import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/models/emotionalTempModel.dart';
import 'package:foodfreedomapp/models/emotionsModel.dart';
import 'package:foodfreedomapp/models/focusOnModel.dart';
import 'package:foodfreedomapp/screens/weeklySnapshotScreen/weeklySnapshotScreenWidgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeeklySnapshaotPage extends StatefulWidget {
  @override
  _WeeklySnapshaotPageState createState() => _WeeklySnapshaotPageState();
}

class _WeeklySnapshaotPageState extends State<WeeklySnapshaotPage> {
  double height, width;

  DatabaseReference refFirebase = FirebaseDatabase.instance.reference();

  List<EmotionalTemp> emotionalData = [
    EmotionalTemp('Mon'.toUpperCase(), 'Amazing'),
    EmotionalTemp('Tue'.toUpperCase(), 'Pretty Good'),
    EmotionalTemp('Wed'.toUpperCase(), 'Somewhat Bad'),
    EmotionalTemp('Thu'.toUpperCase(), 'Okay'),
    EmotionalTemp(
      'Fri'.toUpperCase(),
      'Okay',
    ),
    EmotionalTemp(
      'Sat'.toUpperCase(),
      'Pretty Good',
    ),
    EmotionalTemp(
      'Sun'.toUpperCase(),
      'Somewhat Bad',
    ),
  ];

  final List<Emotions> emotionsData = [
    Emotions('Anxious', 25, palePink),
    Emotions('Down', 38, moderateCyanLimeGreen),
    Emotions('Tired', 34, veryLightBlue),
    Emotions('Stressed', 52, slightlyDesaturatedViolet),
    Emotions('Others', 52, softYellow)
  ];

  final List<FocusOn> focusOnData = [
    FocusOn('Myself', 25, darkCyanGreen),
    FocusOn('Health', 38, palePink),
    FocusOn('Food', 34, darkModerateBlue3),
    FocusOn('Money', 52, slightlyDesaturatedViolet),
    FocusOn('Others', 52, softYellow)
  ];

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
    return 3;
  }

  String returnValueInTermsOfInt(value) {
    print(value);
    if (value == 5) {
      return "Amazing";
    } else if (value == 4) {
      return "Pretty Good";
    } else if (value == 3) {
      return "Okay";
    } else if (value == 2) {
      return "Somewhat Bad";
    } else if (value == 1) {
      return "Horrible";
    }
    return "Okay";
  }

  @override
  void initState() {
    super.initState();
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
              child: Column(children: [
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
              ]),
            ),
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
                        width: 0, color: vividCyan, dashArray: <double>[10, 5]),
                    majorGridLines: MajorGridLines(
                        width: 0, color: vividCyan, dashArray: <double>[10, 5]),
                    labelStyle: TextStyle(
                        color: vividCyan,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  borderWidth: 0,
                  borderColor: white,
                  primaryYAxis: NumericAxis(
                    interval: 1,
                    labelFormat: '{value}',
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
                  tooltipBehavior:
                      TooltipBehavior(enable: true, color: desaturatedCyan),
                  series: <ChartSeries<EmotionalTemp, String>>[
                    LineSeries<EmotionalTemp, String>(
                        dataSource: emotionalData,
                        xAxisName: 'Days',
                        enableTooltip: true,
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
                            returnValueInTermsOfEmotion(emotionalTemp.emotions),
                        name: 'Emotional Temperature',
                        width: 3,
                        color: vividCyan)
                  ]),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      legendItem('amazing', '5: Amazing'),
                      legendItem('prettygood', '4: Pretty Good'),
                      legendItem('okay', '3: Okay'),
                      legendItem('somewhatbad', '2: Somewhat Bad'),
                      legendItem('horrible', '1: Horrible'),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: width * 0.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Legend",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
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

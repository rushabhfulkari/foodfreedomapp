import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/animations/fadeAnimation.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/models/checkInModel.dart';
import 'package:foodfreedomapp/models/tappingActivityDataModel.dart';
import 'package:foodfreedomapp/screens/activityScreen/activityScreenServices.dart';
import 'package:foodfreedomapp/screens/activityScreen/activityScreenWidgets.dart';
import 'package:foodfreedomapp/screens/checkInScreen/checkInScreenPage.dart';
import 'package:foodfreedomapp/screens/navigationBar/navigationBar.dart';
import 'package:foodfreedomapp/services/userDetails.dart';
import 'package:toggle_switch/toggle_switch.dart';

bool checkDataFetchedActivity = false;
bool tappingDataFetchedActivity = false;

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage>
    with AutomaticKeepAliveClientMixin {
  double height, width;
  int toggleIndex = 0;

  final List<String> toggleBarList = [
    "Tapping",
    "Check-Ins",
  ];

  DatabaseReference refFirebase = FirebaseDatabase.instance.reference();

  getCheckInData() {
    if (!checkDataFetchedActivity) {
      refFirebase
          .child('Users')
          .child('$keyGlobal')
          .child('CheckIn')
          .orderByChild('dateTime')
          .limitToFirst(15)
          .once()
          .then((DataSnapshot checkInSnapshot) {
        checkInList = getCheckInDataService(checkInSnapshot.value);
        if (this.mounted) {
          setState(() {
            checkDataFetchedActivity = true;
          });
        }
      });
    }

    if (!tappingDataFetchedActivity) {
      refFirebase
          .child('Users')
          .child('$keyGlobal')
          .child('Tapping')
          .orderByChild('dateTime')
          .limitToFirst(15)
          .once()
          .then((DataSnapshot tappingActivitySnapshot) {
        tappingActivityList =
            getTappingActivityDataService(tappingActivitySnapshot.value);
        if (this.mounted) {
          setState(() {
            tappingDataFetchedActivity = true;
          });
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCheckInData();
  }

  void onToggled(int index) => setState(() => toggleIndex = index);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    return WillPopScope(
      onWillPop: () async => (false),
      child: Scaffold(
          extendBody: true,
          body: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [vividCyan, darkCyan])),
            child: FadeAnimation(
                0.3,
                Column(children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Container(
                      height: height * 0.06,
                      child: Center(
                          child: Text(
                        "Activity",
                        style: TextStyle(color: white, fontSize: 22),
                      ))),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(3, 20, 3, 20),
                    child: ToggleSwitch(
                      minWidth: 340,
                      minHeight: 40,
                      fontSize: 14,
                      initialLabelIndex: toggleIndex,
                      activeBgColor: veryDarkCyan,
                      activeFgColor: white,
                      inactiveBgColor: veryDarkGrey.withOpacity(0.4),
                      inactiveFgColor: white,
                      labels: toggleBarList,
                      cornerRadius: 5,
                      onToggle: onToggled,
                    ),
                  ),
                  toggleIndex != 0
                      ? checkDataFetchedActivity
                          ? checkInList.length == 0
                              ? noActivitiesWidget(
                                  context,
                                  height,
                                  width,
                                  "Looks like you haven’t checked in yet. Now would be a great time to get started :)",
                                  "Start Check-Ins", () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CheckInPage(),
                                    ),
                                  );
                                })
                              : buildCheckInList(
                                  checkInList, height, width, context)
                          : buildCPIWidget(height, width)
                      : tappingDataFetchedActivity
                          ? tappingActivityList.length == 0
                              ? noActivitiesWidget(
                                  context,
                                  height,
                                  width,
                                  "Looks like you haven’t started Tapping yet. Now would be a great time to get started :)",
                                  "Start Tapping", () {
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              NavigationBar(
                                        indexSent: 1,
                                      ),
                                      transitionDuration: Duration.zero,
                                    ),
                                  );
                                })
                              : buildTappingActivityList(tappingActivityList,
                                  height, width, context, refFirebase)
                          : buildCPIWidget(height, width)
                ])),
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

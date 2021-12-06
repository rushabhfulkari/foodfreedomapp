import 'dart:math';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/animations/fadeAnimation.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/configs.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/models/tappingDataModel.dart';
import 'package:foodfreedomapp/screens/checkInScreen/checkInScreenPage.dart';
import 'package:foodfreedomapp/screens/downloadListScreen/downloadListScreenPage.dart';
import 'package:foodfreedomapp/screens/navigationBar/navigationBar.dart';
import 'package:foodfreedomapp/screens/seeAllScreen/seeAllScreenPage.dart';
import 'package:foodfreedomapp/screens/tappingScreen/tappingScreenPage.dart';
import 'package:foodfreedomapp/screens/tappingScreen/tappingScreenServices.dart';
import 'package:foodfreedomapp/screens/weeklySnapshotScreen/weeklySnapshotScreenPage.dart';
import 'package:foodfreedomapp/services/snackBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  double height, width;

  DatabaseReference refFirebase = FirebaseDatabase.instance.reference();

  String favouriteString = "";

  SharedPreferences prefs;

  var affirmationList = [];

  var rng = new Random();

  var dayToday = "";
  var affirmation = "";
  var checkInDone = "";

  var dataFetched = false;

  getSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    favouriteString = prefs.getString('favorites');
    if (favouriteString == null) {
      favouriteString = "";
    }
    dayToday = prefs.getString('dayToday');
    setState(() {
      affirmation = prefs.getString('affirmation');
      checkInDone = prefs.getString('checkInDone');
      dataFetched = true;
    });
    if (affirmation == null) {
      affirmation = "";
    }
    if (checkInDone == null) {
      checkInDone = "false";
    }
    if (dayToday == null || dayToday != "${DateTime.now().day}".toString()) {
      dayToday = "${DateTime.now().day}".toString();
      prefs.setString('dayToday', "${DateTime.now().day}".toString());
      prefs.setString('checkInDone', "false");
      getAffirmations();
    } else {
      print(affirmation.toString() + "affirmation else");
    }
  }

  getAffirmations() {
    refFirebase.child('Affirmations').once().then((value) {
      var affirmationsValue = value.value;
      affirmationsValue.forEach((keyAff, valueAff) {
        affirmationList.add({
          'text': '${valueAff['text']}',
          'number': '${valueAff['number']}',
        });
      });
      var randomNumber = rng.nextInt(affirmationList.length + 1) + 1;
      for (var i = 0; i < affirmationList.length; i++) {
        if (affirmationList[i]['number'].toString() ==
            randomNumber.toString()) {
          prefs.setString('affirmation', "${affirmationList[i]['text']}");
          setState(() {
            affirmation = "${affirmationList[i]['text']}";
            dataFetched = true;
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPref();
  }

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
          body: Stack(children: [
            containerBackgroundImage(
                "assets/homescreenimage.jpeg", height, width),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              child: Container(
                height: height,
                width: width,
                child: FadeAnimation(
                  0.3,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GradientAppBar("Food Freedom Tapping", false,
                          veryDarkGrayishViolet, white, black),
                      SizedBox(
                        height: defaultPadding * 0.1,
                      ),
                      dataFetched
                          ? Column(
                              children: [
                                assetImage(
                                    height, width, 'assets/logo.png', 0.1, 1),
                                Container(
                                  width: width * 0.8,
                                  child: AutoSizeText(
                                    "$affirmation",
                                    maxFontSize: 40,
                                    minFontSize: 25,
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: veryDarkOrange,
                                        fontSize: 40.0,
                                        fontFamily: 'Pattaya',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: height * 0.06),
                                homePageButtons(
                                    size.height,
                                    size.width,
                                    () {},
                                    darkViolet.withOpacity(0.6),
                                    strongBlue.withOpacity(0.36),
                                    "assets/tv.png",
                                    "Food Freedom Tapping 101"),
                                homePageButtons(size.height, size.width, () {
                                  tappingDataFetched = false;
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
                                },
                                    orangeDesaturated.withOpacity(0.6),
                                    orangeDesaturated.withOpacity(0.6),
                                    "assets/tapping.png",
                                    "Tapping"),
                                homePageButtons(size.height, size.width, () {
                                  if (checkInDone == "false") {
                                    Navigator.of(context)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (context) => CheckInPage(),
                                      ),
                                    )
                                        .then((value) {
                                      checkInDone = "true";
                                    });
                                  } else {
                                    showSnackBar(context,
                                        "Today's Emotional Check-In is Done, Please Come Back Tomorrow");
                                  }
                                },
                                    strongBlue2.withOpacity(0.6),
                                    blueDark.withOpacity(0.6),
                                    "assets/smile.png",
                                    "Your Emotional Check-In"),
                                homePageButtons(size.height, size.width, () {
                                  if (favoritesList.toString() != "[]") {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => SeeAllPage(
                                          category: "Favorites",
                                          favoritesList: favoritesList,
                                        ),
                                      ),
                                    );
                                  } else {
                                    favoritesList.clear();
                                    refFirebase
                                        .child('Tapping Data')
                                        .limitToFirst(200)
                                        .orderByChild('dateAdded')
                                        .once()
                                        .then((DataSnapshot tappingSnapshot) {
                                      tappingSnapshot.value
                                          .forEach((keyTapping, valueTapping) {
                                        if (favouriteString
                                            .contains('$keyTapping')) {
                                          favoritesList.add(tappingDataServices(
                                              valueTapping, keyTapping));
                                        }
                                      });
                                    }).then((value) {
                                      tappingDataFetched = false;
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => SeeAllPage(
                                            category: "Favorites",
                                            favoritesList: favoritesList,
                                          ),
                                        ),
                                      );
                                    });
                                  }
                                },
                                    vividPink.withOpacity(0.6),
                                    brightPink.withOpacity(0.252),
                                    "assets/heart.png",
                                    "Favorites"),
                                homePageButtons(size.height, size.width, () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DownloadListPage(),
                                    ),
                                  );
                                },
                                    blueDark.withOpacity(0.8),
                                    blueDark.withOpacity(0.48),
                                    "assets/download.png",
                                    "Downloaded"),
                                homePageButtons(size.height, size.width, () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          WeeklySnapshaotPage(),
                                    ),
                                  );
                                },
                                    vividPink.withOpacity(0.6),
                                    brightPink.withOpacity(0.252),
                                    "assets/graph.png",
                                    "Weekly Snapshot"),
                              ],
                            )
                          : buildCPIWidget(height, width)
                    ],
                  ),
                ),
              ),
            ),
          ])),
    );
  }

  Padding homePageButtons(
    height,
    width,
    onTap,
    color1,
    color2,
    assetImagePath,
    title,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding * 0.5),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: height * 0.07,
            width: width * 0.9,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [color1, color2],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.5, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                assetImageColor(
                    height, width, "$assetImagePath", 0.05, 0.1, white),
                SizedBox(
                  width: 20,
                ),
                autoSizeTextWidget(
                    "$title", white, 'Raleway', FontWeight.w200, 16.0)
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

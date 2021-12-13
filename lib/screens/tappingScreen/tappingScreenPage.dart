import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/animations/fadeAnimation.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/configs.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/models/tappingDataModel.dart';
import 'package:foodfreedomapp/screens/seeAllScreen/seeAllScreenPage.dart';
import 'package:foodfreedomapp/screens/tappingScreen/tappingScreenServices.dart';
import 'package:foodfreedomapp/screens/tappingScreen/tappingScreenWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool tappingDataFetched = false;

class TappingPage extends StatefulWidget {
  @override
  _TappingPageState createState() => _TappingPageState();
}

class _TappingPageState extends State<TappingPage>
    with AutomaticKeepAliveClientMixin {
  double height, width;

  SharedPreferences prefs;
  DatabaseReference refFirebase = FirebaseDatabase.instance.reference();
  String favouriteString = "";
  String downloadString = "";

  getSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    favouriteString = prefs.getString('favorites');
    if (favouriteString == null) {
      favouriteString = "";
    }
    downloadString = prefs.getString('downloads');
    if (downloadString == null) {
      downloadString = "";
    }
  }

  getTappingData() {
    if (!tappingDataFetched) {
      favoritesList.clear();
      downloadList.clear();
      makingPeaceWithFoodList.clear();
      bodyAcceptanceList.clear();
      stressAndAnxietyList.clear();
      selfLoveList.clear();
      intuitiveEatingList.clear();
      mindsetBoosterList.clear();
      emotionalReleaseList.clear();
      healthAndWellbeingList.clear();
      divingDeeperList.clear();
      refFirebase
          .child('Tapping Data')
          .limitToFirst(200)
          .orderByChild('dateAdded')
          .once()
          .then((DataSnapshot tappingSnapshot) {
        tappingSnapshot.value.forEach((keyTapping, valueTapping) {
          if (favouriteString.contains('$keyTapping')) {
            if (favoritesList.length <= 15) {
              favoritesList.add(tappingDataServices(valueTapping, keyTapping));
            }
          }

          if (downloadString.contains('$keyTapping')) {
            if (downloadList.length <= 15) {
              downloadList.add(tappingDataServices(valueTapping, keyTapping));
            }
          }

          if (valueTapping['category'] == "Making Peace With Food") {
            if (makingPeaceWithFoodList.length <= 15) {
              makingPeaceWithFoodList
                  .add(tappingDataServices(valueTapping, keyTapping));
            }
          } else if (valueTapping['category'] == "Body Acceptance") {
            if (bodyAcceptanceList.length <= 15) {
              bodyAcceptanceList
                  .add(tappingDataServices(valueTapping, keyTapping));
            }
          } else if (valueTapping['category'] == "Stress & Anxiety") {
            if (stressAndAnxietyList.length <= 15) {
              stressAndAnxietyList
                  .add(tappingDataServices(valueTapping, keyTapping));
            }
          } else if (valueTapping['category'] == "Self-Love") {
            if (selfLoveList.length <= 15) {
              selfLoveList.add(tappingDataServices(valueTapping, keyTapping));
            }
          } else if (valueTapping['category'] == "Intuitive Eating") {
            if (intuitiveEatingList.length <= 15) {
              intuitiveEatingList
                  .add(tappingDataServices(valueTapping, keyTapping));
            }
          } else if (valueTapping['category'] == "Mindset Booster") {
            if (mindsetBoosterList.length <= 15) {
              mindsetBoosterList
                  .add(tappingDataServices(valueTapping, keyTapping));
            }
          } else if (valueTapping['category'] == "Emotional Release") {
            if (emotionalReleaseList.length <= 15) {
              emotionalReleaseList
                  .add(tappingDataServices(valueTapping, keyTapping));
            }
          } else if (valueTapping['category'] == "Health & Wellbeing") {
            if (healthAndWellbeingList.length <= 15) {
              healthAndWellbeingList
                  .add(tappingDataServices(valueTapping, keyTapping));
            }
          } else if (valueTapping['category'] == "Diving Deeper") {
            if (divingDeeperList.length <= 15) {
              divingDeeperList
                  .add(tappingDataServices(valueTapping, keyTapping));
            }
          }
        });
      }).then((value) {
        if (this.mounted) {
          setState(() {
            tappingDataFetched = true;
          });
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getSharedPref();
    getTappingData();
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
          body: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [darkModerateBlue2, veryDarkBlue]),
            ),
            child: FadeAnimation(
                0.3,
                Column(children: [
                  GradientAppBar(
                      "Tapping Library",
                      false,
                      veryDarkGrayishViolet,
                      blueVeryDark.withOpacity(1),
                      white),
                  Container(
                    height: height * 0.82,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(
                            height: defaultPadding,
                          ),
                          staticSearchBar(),
                          tappingDataFetched
                              ? Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: Column(
                                    children: [
                                      favoritesList.length != 0
                                          ? Column(
                                              children: [
                                                listTitleAndSeeAll("Favorites",
                                                    "${favoritesList.length}",
                                                    () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SeeAllPage(
                                                        category: "Favorites",
                                                        favoritesList:
                                                            favoritesList,
                                                      ),
                                                    ),
                                                  );
                                                }, true, Icons.favorite),
                                                buildHorizontalScrollTappingList(
                                                    favoritesList,
                                                    height,
                                                    width,
                                                    context, (value) {
                                                  setState(() {
                                                    tappingDataFetched = false;
                                                    getSharedPref();
                                                    getTappingData();
                                                  });
                                                }),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      downloadList.length != 0
                                          ? Column(
                                              children: [
                                                listTitleAndSeeAll("Downloads",
                                                    "${downloadList.length}",
                                                    () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SeeAllPage(
                                                        category: "Downloads",
                                                        downloadList:
                                                            downloadList,
                                                      ),
                                                    ),
                                                  );
                                                }, true, Icons.download),
                                                buildHorizontalScrollTappingList(
                                                    downloadList,
                                                    height,
                                                    width,
                                                    context, (value) {
                                                  setState(() {
                                                    tappingDataFetched = false;
                                                    getSharedPref();
                                                    getTappingData();
                                                  });
                                                }),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      makingPeaceWithFoodList.length != 0
                                          ? Column(
                                              children: [
                                                listTitleAndSeeAll(
                                                    "Making Peace With Food",
                                                    "${makingPeaceWithFoodList.length}",
                                                    () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SeeAllPage(
                                                        category:
                                                            "Making Peace With Food",
                                                      ),
                                                    ),
                                                  );
                                                }, false, null),
                                                buildHorizontalScrollTappingList(
                                                    makingPeaceWithFoodList,
                                                    height,
                                                    width,
                                                    context, (value) {
                                                  setState(() {
                                                    tappingDataFetched = false;
                                                    getSharedPref();
                                                    getTappingData();
                                                  });
                                                }),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      bodyAcceptanceList.length != 0
                                          ? Column(
                                              children: [
                                                listTitleAndSeeAll(
                                                    "Body Acceptance",
                                                    "${bodyAcceptanceList.length}",
                                                    () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SeeAllPage(
                                                        category:
                                                            "Body Acceptance",
                                                      ),
                                                    ),
                                                  );
                                                }, false, null),
                                                buildHorizontalScrollTappingList(
                                                    bodyAcceptanceList,
                                                    height,
                                                    width,
                                                    context, (value) {
                                                  setState(() {
                                                    tappingDataFetched = false;
                                                    getSharedPref();
                                                    getTappingData();
                                                  });
                                                }),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      stressAndAnxietyList.length != 0
                                          ? Column(
                                              children: [
                                                listTitleAndSeeAll(
                                                    "Stress & Anxiety",
                                                    "${stressAndAnxietyList.length}",
                                                    () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SeeAllPage(
                                                        category:
                                                            "Stress & Anxiety",
                                                      ),
                                                    ),
                                                  );
                                                }, false, null),
                                                buildHorizontalScrollTappingList(
                                                    stressAndAnxietyList,
                                                    height,
                                                    width,
                                                    context, (value) {
                                                  setState(() {
                                                    tappingDataFetched = false;
                                                    getSharedPref();
                                                    getTappingData();
                                                  });
                                                }),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      selfLoveList.length != 0
                                          ? Column(
                                              children: [
                                                listTitleAndSeeAll("Self-Love",
                                                    "${selfLoveList.length}",
                                                    () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SeeAllPage(
                                                        category: "Self-Love",
                                                      ),
                                                    ),
                                                  );
                                                }, false, null),
                                                buildHorizontalScrollTappingList(
                                                    selfLoveList,
                                                    height,
                                                    width,
                                                    context, (value) {
                                                  setState(() {
                                                    tappingDataFetched = false;
                                                    getSharedPref();
                                                    getTappingData();
                                                  });
                                                }),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      intuitiveEatingList.length != 0
                                          ? Column(
                                              children: [
                                                listTitleAndSeeAll(
                                                    "Intuitive Eating",
                                                    "${intuitiveEatingList.length}",
                                                    () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SeeAllPage(
                                                        category:
                                                            "Intuitive Eating",
                                                      ),
                                                    ),
                                                  );
                                                }, false, null),
                                                buildHorizontalScrollTappingList(
                                                    intuitiveEatingList,
                                                    height,
                                                    width,
                                                    context, (value) {
                                                  setState(() {
                                                    tappingDataFetched = false;
                                                    getSharedPref();
                                                    getTappingData();
                                                  });
                                                }),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      mindsetBoosterList.length != 0
                                          ? Column(
                                              children: [
                                                listTitleAndSeeAll(
                                                    "Mindset Booster",
                                                    "${mindsetBoosterList.length}",
                                                    () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SeeAllPage(
                                                        category:
                                                            "Mindset Booster",
                                                      ),
                                                    ),
                                                  );
                                                }, false, null),
                                                buildHorizontalScrollTappingList(
                                                    mindsetBoosterList,
                                                    height,
                                                    width,
                                                    context, (value) {
                                                  setState(() {
                                                    tappingDataFetched = false;
                                                    getSharedPref();
                                                    getTappingData();
                                                  });
                                                }),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      emotionalReleaseList.length != 0
                                          ? Column(
                                              children: [
                                                listTitleAndSeeAll(
                                                    "Emotional Release",
                                                    "${emotionalReleaseList.length}",
                                                    () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SeeAllPage(
                                                        category:
                                                            "Emotional Release",
                                                      ),
                                                    ),
                                                  );
                                                }, false, null),
                                                buildHorizontalScrollTappingList(
                                                    emotionalReleaseList,
                                                    height,
                                                    width,
                                                    context, (value) {
                                                  setState(() {
                                                    tappingDataFetched = false;
                                                    getSharedPref();
                                                    getTappingData();
                                                  });
                                                }),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      healthAndWellbeingList.length != 0
                                          ? Column(
                                              children: [
                                                listTitleAndSeeAll(
                                                    "Health & Wellbeing",
                                                    "${healthAndWellbeingList.length}",
                                                    () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SeeAllPage(
                                                        category:
                                                            "Health & Wellbeing",
                                                      ),
                                                    ),
                                                  );
                                                }, false, null),
                                                buildHorizontalScrollTappingList(
                                                    healthAndWellbeingList,
                                                    height,
                                                    width,
                                                    context, (value) {
                                                  setState(() {
                                                    tappingDataFetched = false;
                                                    getSharedPref();
                                                    getTappingData();
                                                  });
                                                }),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      divingDeeperList.length != 0
                                          ? Column(
                                              children: [
                                                listTitleAndSeeAll(
                                                    "Diving Deeper",
                                                    "${divingDeeperList.length}",
                                                    () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SeeAllPage(
                                                        category:
                                                            "Diving Deeper",
                                                      ),
                                                    ),
                                                  );
                                                }, false, null),
                                                buildHorizontalScrollTappingList(
                                                    divingDeeperList,
                                                    height,
                                                    width,
                                                    context, (value) {
                                                  setState(() {
                                                    tappingDataFetched = false;
                                                    getSharedPref();
                                                    getTappingData();
                                                  });
                                                }),
                                              ],
                                            )
                                          : Container()
                                    ],
                                  ),
                                )
                              : buildCPIWidget(height, width)
                        ],
                      ),
                    ),
                  )
                ])),
          )),
    );
  }

  Container listTitleAndSeeAll(title, count, onPressed, icon, iconName) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  AutoSizeText(
                    "$title",
                    style: TextStyle(color: white, fontSize: 18),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  icon
                      ? Icon(
                          iconName,
                          color: white,
                        )
                      : Container()
                ],
              ),
              GestureDetector(
                onTap: onPressed,
                child: AutoSizeText(
                  "See All ($count)",
                  style: TextStyle(color: white, fontSize: 18),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  ClipRRect staticSearchBar() {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(6)),
      child: Container(
        decoration: BoxDecoration(color: grey2.withOpacity(0.2)),
        height: height * 0.06,
        width: width * 0.9,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Icon(
                Icons.search,
                color: grey2,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

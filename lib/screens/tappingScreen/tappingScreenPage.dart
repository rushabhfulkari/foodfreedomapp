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
    print(tappingDataFetched.toString() + "sdjvnaskvnakjdn");
    if (!tappingDataFetched) {
      favoritesList.clear();
      downloadList.clear();
      loremIpsumDolo1List.clear();
      loremIpsumDolo2List.clear();
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
            // print(downloadString);
            // print("object");
            if (downloadList.length <= 15) {
              downloadList.add(tappingDataServices(valueTapping, keyTapping));
            }
          }

          if (valueTapping['category'] == "Lorem ipsum dolo 1") {
            if (loremIpsumDolo1List.length <= 15) {
              loremIpsumDolo1List
                  .add(tappingDataServices(valueTapping, keyTapping));
            }
          } else if (valueTapping['category'] == "Lorem ipsum dolo 2") {
            if (loremIpsumDolo2List.length <= 15) {
              loremIpsumDolo2List
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
                                      listTitleAndSeeAll("Lorem ipsum dolo 1",
                                          "${loremIpsumDolo1List.length}", () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => SeeAllPage(
                                              category: "Lorem ipsum dolo 1",
                                            ),
                                          ),
                                        );
                                      }, false, null),
                                      buildHorizontalScrollTappingList(
                                          loremIpsumDolo1List,
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
                                      listTitleAndSeeAll("Lorem ipsum dolo 2",
                                          "${loremIpsumDolo2List.length}", () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => SeeAllPage(
                                              category: "Lorem ipsum dolo 2",
                                            ),
                                          ),
                                        );
                                      }, false, null),
                                      buildHorizontalScrollTappingList(
                                          loremIpsumDolo2List,
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

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/configs.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/models/tappingDataModel.dart';
import 'package:foodfreedomapp/screens/seeAllScreen/seeAllScreenWidgets.dart';
import 'package:foodfreedomapp/screens/tappingScreen/tappingScreenServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeeAllPage extends StatefulWidget {
  SeeAllPage({
    Key key,
    this.category,
    this.favoritesList,
    this.downloadList,
  }) : super(key: key);
  final String category;
  final List<TappingDataModel> favoritesList;
  final List<TappingDataModel> downloadList;
  @override
  _SeeAllPageState createState() =>
      _SeeAllPageState(category, favoritesList, downloadList);
}

class _SeeAllPageState extends State<SeeAllPage> {
  String category;
  List<TappingDataModel> favoritesList;
  List<TappingDataModel> downloadList;

  _SeeAllPageState(this.category, this.favoritesList, this.downloadList);
  double height, width;
  SharedPreferences prefs;
  bool tappingCategoryDataFetched = false;
  DatabaseReference refFirebase = FirebaseDatabase.instance.reference();
  List<TappingDataModel> categoryList = [];

  getCategoryTappingData() {
    if (category == "Favorites") {
      categoryList = favoritesList;
      setState(() {
        tappingCategoryDataFetched = true;
      });
    } else if (category == "Downloads") {
      categoryList = downloadList;
      setState(() {
        tappingCategoryDataFetched = true;
      });
    } else {
      refFirebase
          .child('Tapping Data')
          .limitToFirst(30)
          .orderByChild('category')
          .equalTo('$category')
          .once()
          .then((DataSnapshot tappingSnapshot) {
        tappingSnapshot.value.forEach((keyTapping, valueTapping) {
          categoryList.add(tappingDataServices(valueTapping, keyTapping));
        });
      }).then((value) {
        setState(() {
          tappingCategoryDataFetched = true;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCategoryTappingData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [darkModerateBlue2, veryDarkBlue]),
          ),
          child: Column(
            children: [
              GradientAppBar("$category", true, veryDarkGrayishViolet,
                  blueVeryDark.withOpacity(1), white),
              Container(
                height: height * 0.885,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: defaultPadding,
                      ),
                      tappingCategoryDataFetched
                          ? categoryList.length != 0
                              ? Padding(
                                  padding: const EdgeInsets.all(
                                      defaultPadding * 0.5),
                                  child: Column(
                                    children: [
                                      buildVerticalGridScrollTappingList(
                                          categoryList, height, width, context)
                                    ],
                                  ),
                                )
                              : noDataDoundWidget(
                                  height,
                                  width,
                                  category == "Favorites"
                                      ? "Looks like you haven’t marked any content as a favorite yet."
                                      : "No Data Found")
                          : buildCPIWidget(height, width)
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

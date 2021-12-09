import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/configs.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/screens/customizeTappingScreen/customizeTappingScreenWidgets.dart';
import 'package:foodfreedomapp/services/snackBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomizeTappingPage extends StatefulWidget {
  CustomizeTappingPage({
    Key key,
    this.fromWhere,
  }) : super(key: key);
  final String fromWhere;
  @override
  _CustomizeTappingPageState createState() =>
      _CustomizeTappingPageState(fromWhere);
}

class _CustomizeTappingPageState extends State<CustomizeTappingPage> {
  final String fromWhere;
  _CustomizeTappingPageState(this.fromWhere);
  double height, width;

  int avatarSelected = 0;
  int bgMusicSelected = 0;

  SharedPreferences prefs;

  getSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    var avatarSelectedTemp = prefs.getString('avatarSelected');
    if (avatarSelectedTemp != null) {
      setState(() {
        if (avatarSelectedTemp == "male") {
          avatarSelected = 1;
        } else {
          avatarSelected = 0;
        }
      });
    } else {
      setState(() {
        avatarSelected = 0;
      });
    }
    var bgMusicSelectedTemp = prefs.getString('bgMusicSelected');
    if (bgMusicSelectedTemp != null) {
      setState(() {
        bgMusicSelected = int.parse(bgMusicSelectedTemp);
      });
    } else {
      setState(() {
        bgMusicSelected = 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          appBar: appBarWithBackButtonVeryDarkDesaturatedOrange2(
              context, "Customize Tapping", () {
            Navigator.pop(context);
          }),
          body: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[veryDarkDesaturatedOrange2, veryDarkBlue2],
              ),
            ),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      titleText("Choose your Avatar"),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          avatarWidget("female", () {
                            setState(() {
                              avatarSelected = 0;
                            });
                          }, 0, avatarSelected, height, width),
                          SizedBox(
                            width: 20,
                          ),
                          avatarWidget("male", () {
                            setState(() {
                              avatarSelected = 1;
                            });
                          }, 1, avatarSelected, height, width),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      titleText("Choose Background Music"),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: width,
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              bgMusicWidget('birds', () {
                                setState(() {
                                  bgMusicSelected = 0;
                                });
                              },
                                  0,
                                  bgMusicSelected,
                                  height,
                                  width,
                                  darkModerateBlue.withOpacity(0.8),
                                  strongRed.withOpacity(0.8),
                                  "Birds"),
                              SizedBox(
                                width: 20,
                              ),
                              bgMusicWidget('rain', () {
                                setState(() {
                                  bgMusicSelected = 1;
                                });
                              },
                                  1,
                                  bgMusicSelected,
                                  height,
                                  width,
                                  moderateCyanLimeGreen.withOpacity(0.8),
                                  veryDarkDesaturatedCyanLimeGreen
                                      .withOpacity(0),
                                  "Rain"),
                              SizedBox(
                                width: 20,
                              ),
                              bgMusicWidget('rain', () {
                                setState(() {
                                  bgMusicSelected = 2;
                                });
                              },
                                  2,
                                  bgMusicSelected,
                                  height,
                                  width,
                                  darkModerateBlue.withOpacity(0.8),
                                  strongRed.withOpacity(0.8),
                                  "No Music"),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      buttonRegular2(() {
                        if (fromWhere == "Settings") {
                          Navigator.pop(context);
                        } else if (fromWhere == "Audio Player") {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                        prefs.setString(
                            'bgMusicSelected', '${bgMusicSelected.toString()}');
                        prefs.setString(
                            'avatarSelected',
                            '${avatarSelected.toString()}' == '0'
                                ? "female"
                                : "male");
                        showSnackBar(context, "Changed Saved");
                      }, "Save")
                    ],
                  )),
            ),
          )),
    );
  }
}

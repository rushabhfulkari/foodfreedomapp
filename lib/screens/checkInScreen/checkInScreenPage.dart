import 'dart:io';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/configs.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/screens/activityScreen/activityScreenPage.dart';
import 'package:foodfreedomapp/screens/checkInScreen/checkInScreenConfigs.dart';
import 'package:foodfreedomapp/screens/checkInScreen/checkInScreenWidgets.dart';
import 'package:foodfreedomapp/screens/navigationBar/navigationBar.dart';
import 'package:foodfreedomapp/services/snackBar.dart';
import 'package:foodfreedomapp/services/userDetails.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CheckInPage extends StatefulWidget {
  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  DatabaseReference refFirebase = FirebaseDatabase.instance.reference();
  final _formKey = new GlobalKey<FormState>();

  PageController _pageController = PageController();
  double howIsYourDayIndex = 2.0;
  int checkInPage1Index = 0;
  String iAlsoFeelText = '';
  int whatMakesYouFeelIndex = 0;

  SharedPreferences prefs;

  TextEditingController _titleController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  TextEditingController _thoughtsController = TextEditingController();
  final FocusNode _thoughtsFocusNode = FocusNode();

  final _formKeyIAlsoFeel = new GlobalKey<FormState>();

  TextEditingController _iAlsoFeelTextController = TextEditingController();
  final FocusNode _iAlsoFeelTextFocusNode = FocusNode();

  var timeNow;

  getSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    timeNow = DateTime.now();
    getSharedPref();
  }

  // ignore: missing_return
  Future<bool> onWillPop() {
    confirmDialogue(context, "Go Back", "All the data will be lost?", () {
      Navigator.pop(context);
      Navigator.pop(context);
    }, () {
      Navigator.pop(context);
    });
    // return exit(0);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          body: SafeArea(
        child: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              checkInPage0(size),
              checkInPage1(size),
              checkInPage2(size),
              checkInPage3(size),
              checkInPage4(size),
              checkInPage5(size),
            ]),
      )),
    );
  }

  Scaffold checkInPage0(Size size) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarWithBackButtonDarkBlue(
          context, "Emotional Temperature Check", () {
        confirmDialogue(context, "Go Back", "All the data will be lost?", () {
          Navigator.pop(context);
          Navigator.pop(context);
        }, () {
          Navigator.pop(context);
        });
      }),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [blueDark, grey2.withOpacity(1)])),
        child: Stack(
          children: [
            Container(
                child: Column(
              children: [
                SizedBox(
                  height: defaultPadding * 1,
                ),
                AutoSizeText(
                  "Good Morning",
                  maxLines: 1,
                  style: TextStyle(
                      color: white,
                      fontSize: 36.0,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: defaultPadding * 0.5,
                ),
                AutoSizeText(
                  "How has your day been ?",
                  maxLines: 1,
                  style: TextStyle(
                      color: white,
                      fontSize: 25.0,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 60,
                ),
                howIsYourDayOptions(size.height, size.width)
              ],
            )),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: buttonRegularCheckIn(() {
                    _pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }, "Continue"),
                ))
          ],
        ),
      ),
    );
  }

  Column howIsYourDayOptions(height, width) {
    return Column(
      children: [
        Stack(
          children: [
            Center(
              child: Container(
                height: height * 0.55,
                width: width * 0.9,
                child: Container(
                  child: assetImage(
                    height,
                    width,
                    "assets/emotionalthermometerwithwords.png",
                    0.55,
                    0.9,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(right: width * 0.154, top: height * 0.048),
              child: Container(
                height: height * 0.4,
                child: SfSlider.vertical(
                  min: 0.0,
                  max: 4.0,
                  value: howIsYourDayIndex,
                  interval: 5,
                  activeColor: veryDarkBlue.withOpacity(howIsYourDayIndex / 10),
                  thumbIcon: Icon(Icons.circle, color: white, size: 18),
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) {
                    setState(() {
                      howIsYourDayIndex = value;
                      print(howIsYourDayIndex);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column howIsYourDayOptionWidget(
      onPressed, pngName, text, clickedIndex, index) {
    return Column(
      children: [
        TextButton(
            onPressed: onPressed,
            style: selectButtonStyle(clickedIndex, index),
            child: Container(
              height: 55,
              width: 55,
              child: Image.asset("assets/$pngName.png"),
            )),
        SizedBox(
          height: 10,
        ),
        Text(
          "$text",
          style: TextStyle(
              color: white, fontWeight: FontWeight.w400, fontSize: 14),
        ),
      ],
    );
  }

  Column isAlsoFeelTitleOptionWidget(
      onPressed, pngName, text, clickedIndex, index) {
    return Column(
      children: [
        TextButton(
            onPressed: onPressed,
            style: selectButtonStyle4(),
            child: Container(
              height: 55,
              width: 55,
              child: Image.asset("assets/$pngName.png"),
            )),
        SizedBox(
          height: 10,
        ),
        Text(
          "$text",
          style: TextStyle(
              color: white, fontWeight: FontWeight.w400, fontSize: 14),
        ),
      ],
    );
  }

  Row lastPageOptionWidget(onPressed, pngName, text, clickedIndex, index) {
    return Row(
      children: [
        TextButton(
            onPressed: onPressed,
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

  Column iAlsoFeelWidget(
    pngName,
    text,
  ) {
    return Column(
      children: [
        TextButton(
            onPressed: () {},
            style: selectButtonStyle2(),
            child: Container(
              height: 55,
              width: 55,
              child: Image.asset("assets/$pngName.png"),
            )),
        SizedBox(
          height: 10,
        ),
        Text(
          "$text",
          style: TextStyle(
              color: white, fontWeight: FontWeight.w400, fontSize: 14),
        ),
      ],
    );
  }

  Scaffold checkInPage1(Size size) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarWithBackButtonDarkBlueFontSizeMore(context,
          returnAppBarText(int.parse(howIsYourDayIndex.toStringAsFixed(0))),
          () {
        confirmDialogue(context, "Go Back", "All the data will be lost?", () {
          Navigator.pop(context);
          Navigator.pop(context);
        }, () {
          Navigator.pop(context);
        });
      }),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [blueDark, grey2.withOpacity(1)])),
        child: Stack(
          children: [
            Container(
                child: Column(
              children: [
                SizedBox(
                  height: defaultPadding,
                ),
                AutoSizeText(
                  "How do you feel right now in this\nmoment ?",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: white,
                      fontSize: 22.0,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 60,
                ),
                checkInPage1Options(size.height)
              ],
            )),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: buttonRegularCheckIn(() {
                    _pageController.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }, "Continue"),
                ))
          ],
        ),
      ),
    );
  }

  Column checkInPage1Options(height) {
    var dataCheckInTemp = dataCheckIn[returnHowWasYourDayText(
        int.parse(howIsYourDayIndex.toStringAsFixed(0)))];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            checkInPage1Widget(() {
              if (checkInPage1Index != 0) {
                setState(() {
                  checkInPage1Index = 0;
                });
              }
            }, "${dataCheckInTemp['emoji'][0]}",
                "${dataCheckInTemp['name'][0]}", checkInPage1Index, 0),
            SizedBox(
              width: defaultPadding * 0.6,
            ),
            checkInPage1Widget(() {
              if (checkInPage1Index != 1) {
                setState(() {
                  checkInPage1Index = 1;
                });
              }
            }, "${dataCheckInTemp['emoji'][1]}",
                "${dataCheckInTemp['name'][1]}", checkInPage1Index, 1),
            SizedBox(
              width: defaultPadding * 0.6,
            ),
            checkInPage1Widget(() {
              if (checkInPage1Index != 2) {
                setState(() {
                  checkInPage1Index = 2;
                });
              }
            }, "${dataCheckInTemp['emoji'][2]}",
                "${dataCheckInTemp['name'][2]}", checkInPage1Index, 2),
          ],
        ),
        SizedBox(
          height: defaultPadding * 0.6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            checkInPage1Widget(() {
              if (checkInPage1Index != 3) {
                setState(() {
                  checkInPage1Index = 3;
                });
              }
            }, "${dataCheckInTemp['emoji'][3]}",
                "${dataCheckInTemp['name'][3]}", checkInPage1Index, 3),
            SizedBox(
              width: defaultPadding * 0.6,
            ),
            checkInPage1Widget(() {
              if (checkInPage1Index != 4) {
                setState(() {
                  checkInPage1Index = 4;
                });
              }
            }, "${dataCheckInTemp['emoji'][4]}",
                "${dataCheckInTemp['name'][4]}", checkInPage1Index, 4),
            SizedBox(
              width: defaultPadding * 0.6,
            ),
            checkInPage1Widget(() {
              if (checkInPage1Index != 5) {
                setState(() {
                  checkInPage1Index = 5;
                });
              }
            }, "${dataCheckInTemp['emoji'][5]}",
                "${dataCheckInTemp['name'][5]}", checkInPage1Index, 5),
          ],
        ),
        SizedBox(
          height: defaultPadding * 0.6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            checkInPage1Widget(() {
              if (checkInPage1Index != 6) {
                setState(() {
                  checkInPage1Index = 6;
                });
              }
            }, "${dataCheckInTemp['emoji'][6]}",
                "${dataCheckInTemp['name'][6]}", checkInPage1Index, 6),
            SizedBox(
              width: defaultPadding * 0.6,
            ),
            checkInPage1Widget(() {
              if (checkInPage1Index != 7) {
                setState(() {
                  checkInPage1Index = 7;
                });
              }
            }, "${dataCheckInTemp['emoji'][7]}",
                "${dataCheckInTemp['name'][7]}", checkInPage1Index, 7),
            SizedBox(
              width: defaultPadding * 0.6,
            ),
            checkInPage1Widget(() {
              if (checkInPage1Index != 8) {
                setState(() {
                  checkInPage1Index = 8;
                });
              }
            }, "${dataCheckInTemp['emoji'][8]}",
                "${dataCheckInTemp['name'][8]}", checkInPage1Index, 8),
          ],
        ),
        SizedBox(
          height: defaultPadding * 0.6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            checkInPage1Widget(() {
              if (checkInPage1Index != 9) {
                setState(() {
                  checkInPage1Index = 9;
                });
              }
            }, "${dataCheckInTemp['emoji'][9]}",
                "${dataCheckInTemp['name'][9]}", checkInPage1Index, 9),
            SizedBox(
              width: defaultPadding * 0.6,
            ),
            checkInPage1Widget(() {
              if (checkInPage1Index != 10) {
                setState(() {
                  checkInPage1Index = 10;
                });
              }
            }, "${dataCheckInTemp['emoji'][10]}",
                "${dataCheckInTemp['name'][10]}", checkInPage1Index, 10),
            SizedBox(
              width: defaultPadding * 0.6,
            ),
            checkInPage1Widget(() {
              if (checkInPage1Index != 11) {
                setState(() {
                  checkInPage1Index = 11;
                });
              }
            }, "${dataCheckInTemp['emoji'][11]}",
                "${dataCheckInTemp['name'][11]}", checkInPage1Index, 11),
          ],
        ),
      ],
    );
  }

  Scaffold checkInPage2(Size size) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            containerBackgroundImage(
                "assets/image-3.jpg", size.height, size.width),
            containerBackgroundLinearGradient(desaturatedBlue.withOpacity(0.5),
                blueVeryDark.withOpacity(0.5), size.height, size.height),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                height: size.height,
                width: size.width,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        height: 65,
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: white,
                                  size: 25.0,
                                ),
                                onPressed: () {
                                  confirmDialogue(context, "Go Back",
                                      "All the data will be lost?", () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  }, () {
                                    Navigator.pop(context);
                                  });
                                }),
                            SizedBox(
                              width: size.width * 0.25,
                            ),
                            Text("Check-Ins",
                                style: TextStyle(color: white, fontSize: 22))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: defaultPadding * 1,
                      ),
                      isAlsoFeelTitleOptionWidget(
                          () {},
                          "${returnHowWasYourDayText(int.parse(howIsYourDayIndex.toStringAsFixed(0)))}"
                              .replaceAll(" ", "")
                              .toLowerCase(),
                          "${returnHowWasYourDayText(int.parse(howIsYourDayIndex.toStringAsFixed(0)))}",
                          int.parse(howIsYourDayIndex.toStringAsFixed(0)),
                          0),
                      SizedBox(
                        height: 40,
                      ),
                      Text("I also feel",
                          style: TextStyle(
                              color: white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: size.width,
                        height: size.height * 0.2,
                        child: GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 10.0,
                                    childAspectRatio: 4 / 9),
                            physics: AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: iAlsoFeel.length,
                            itemBuilder: (BuildContext context, int index) {
                              return iAlsoFeelButton(() {
                                if (iAlsoFeelText != "") {
                                  if (!iAlsoFeelText
                                      .contains("${iAlsoFeel[index]}")) {
                                    setState(() {
                                      iAlsoFeelText = iAlsoFeelText +
                                          "${iAlsoFeel[index]}//";
                                    });
                                  } else {
                                    setState(() {
                                      iAlsoFeelText = iAlsoFeelText.replaceAll(
                                          "${iAlsoFeel[index]}//", "");
                                    });
                                  }
                                } else {
                                  setState(() {
                                    iAlsoFeelText =
                                        iAlsoFeelText + "${iAlsoFeel[index]}//";
                                  });
                                }
                              },
                                  "${iAlsoFeel[index]}",
                                  iAlsoFeelText
                                      .contains("${iAlsoFeel[index]}"));
                            }),
                      ),
                      SizedBox(height: 20),
                      Form(
                        key: _formKeyIAlsoFeel,
                        child: textFormFieldWidgetSettingsPageSmaller(
                          size.height,
                          size.width,
                          context,
                          _iAlsoFeelTextController,
                          _iAlsoFeelTextFocusNode,
                          "or enter your own feeling...",
                          "Enter how you feel",
                        ),
                      ),
                      SizedBox(height: size.height * 0.15),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40.0),
                        child: buttonRegularCheckIn(() {
                          _iAlsoFeelTextFocusNode.unfocus();
                          if (iAlsoFeelText != "") {
                            _pageController.animateToPage(
                              3,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            showSnackBar(
                                context, "Please Select Atleast One Option");
                          }
                        }, "Continue"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Scaffold checkInPage3(Size size) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            containerBackgroundImage(
                "assets/image-3.jpg", size.height, size.height),
            containerBackgroundLinearGradient(grey2.withOpacity(0),
                blueVeryDark.withOpacity(0.5), size.height, size.width),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
              child: Column(
                children: [
                  Container(
                    height: 65,
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: white,
                              size: 25.0,
                            ),
                            onPressed: () {
                              confirmDialogue(context, "Go Back",
                                  "All the data will be lost?", () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }, () {
                                Navigator.pop(context);
                              });
                            }),
                        SizedBox(
                          width: size.width * 0.25,
                        ),
                        Text("Check-Ins",
                            style: TextStyle(color: white, fontSize: 22))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: defaultPadding * 1,
                  ),
                  AutoSizeText(
                    "Okay.",
                    maxLines: 1,
                    style: TextStyle(
                        color: white,
                        fontSize: 36.0,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: defaultPadding * 0.5,
                  ),
                  AutoSizeText(
                    "What makes you feel\n${returnHowWasYourDayText(int.parse(howIsYourDayIndex.toStringAsFixed(0)))} today ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: white,
                        fontSize: 25.0,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      whatMakesYouFeelWidget(() {
                        if (whatMakesYouFeelIndex != 0) {
                          setState(() {
                            whatMakesYouFeelIndex = 0;
                          });
                        }
                      },
                          "${whatMakesYouFeelData['image'][0]}",
                          "${whatMakesYouFeelData['name'][0]}",
                          0,
                          whatMakesYouFeelIndex),
                      SizedBox(
                        width: defaultPadding * 0.6,
                      ),
                      whatMakesYouFeelWidget(() {
                        if (whatMakesYouFeelIndex != 1) {
                          setState(() {
                            whatMakesYouFeelIndex = 1;
                          });
                        }
                      },
                          "${whatMakesYouFeelData['image'][1]}",
                          "${whatMakesYouFeelData['name'][1]}",
                          1,
                          whatMakesYouFeelIndex),
                      SizedBox(
                        width: defaultPadding * 0.6,
                      ),
                      whatMakesYouFeelWidget(() {
                        if (whatMakesYouFeelIndex != 2) {
                          setState(() {
                            whatMakesYouFeelIndex = 2;
                          });
                        }
                      },
                          "${whatMakesYouFeelData['image'][2]}",
                          "${whatMakesYouFeelData['name'][2]}",
                          2,
                          whatMakesYouFeelIndex),
                    ],
                  ),
                  SizedBox(
                    height: defaultPadding * 0.6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      whatMakesYouFeelWidget(() {
                        if (whatMakesYouFeelIndex != 3) {
                          setState(() {
                            whatMakesYouFeelIndex = 3;
                          });
                        }
                      },
                          "${whatMakesYouFeelData['image'][3]}",
                          "${whatMakesYouFeelData['name'][3]}",
                          3,
                          whatMakesYouFeelIndex),
                      SizedBox(
                        width: defaultPadding * 0.6,
                      ),
                      whatMakesYouFeelWidget(() {
                        if (whatMakesYouFeelIndex != 4) {
                          setState(() {
                            whatMakesYouFeelIndex = 4;
                          });
                        }
                      },
                          "${whatMakesYouFeelData['image'][4]}",
                          "${whatMakesYouFeelData['name'][4]}",
                          4,
                          whatMakesYouFeelIndex),
                      SizedBox(
                        width: defaultPadding * 0.6,
                      ),
                      whatMakesYouFeelWidget(() {
                        if (whatMakesYouFeelIndex != 5) {
                          setState(() {
                            whatMakesYouFeelIndex = 5;
                          });
                        }
                      },
                          "${whatMakesYouFeelData['image'][5]}",
                          "${whatMakesYouFeelData['name'][5]}",
                          5,
                          whatMakesYouFeelIndex),
                    ],
                  ),
                  SizedBox(
                    height: defaultPadding * 0.6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      whatMakesYouFeelWidget(() {
                        if (whatMakesYouFeelIndex != 6) {
                          setState(() {
                            whatMakesYouFeelIndex = 6;
                          });
                        }
                      },
                          "${whatMakesYouFeelData['image'][6]}",
                          "${whatMakesYouFeelData['name'][6]}",
                          6,
                          whatMakesYouFeelIndex),
                      SizedBox(
                        width: defaultPadding * 0.6,
                      ),
                      whatMakesYouFeelWidget(() {
                        if (whatMakesYouFeelIndex != 7) {
                          setState(() {
                            whatMakesYouFeelIndex = 7;
                          });
                        }
                      },
                          "${whatMakesYouFeelData['image'][7]}",
                          "${whatMakesYouFeelData['name'][7]}",
                          7,
                          whatMakesYouFeelIndex),
                      SizedBox(
                        width: defaultPadding * 0.6,
                      ),
                      whatMakesYouFeelWidget(() {
                        if (whatMakesYouFeelIndex != 8) {
                          setState(() {
                            whatMakesYouFeelIndex = 8;
                          });
                        }
                      },
                          "${whatMakesYouFeelData['image'][8]}",
                          "${whatMakesYouFeelData['name'][8]}",
                          8,
                          whatMakesYouFeelIndex),
                    ],
                  ),
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: buttonRegularCheckIn(() {
                    _pageController.animateToPage(
                      4,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }, "Continue"),
                ))
          ],
        ),
      ),
    );
  }

  Scaffold checkInPage4(Size size) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            containerBackgroundImage(
                "assets/image-3.jpg", size.height, size.height),
            containerBackgroundLinearGradient(grey2.withOpacity(0),
                blueVeryDark.withOpacity(0.5), size.height, size.width),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
              child: Container(
                height: size.height,
                width: size.width,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        height: 65,
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: white,
                                  size: 25.0,
                                ),
                                onPressed: () {
                                  confirmDialogue(context, "Go Back",
                                      "All the data will be lost?", () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  }, () {
                                    Navigator.pop(context);
                                  });
                                }),
                            SizedBox(
                              width: size.width * 0.25,
                            ),
                            Text("Check-Ins",
                                style: TextStyle(color: white, fontSize: 22))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: defaultPadding * 1,
                      ),
                      AutoSizeText(
                        "${Jiffy(timeNow).format("EEEE,  dd MMM,  h:mm a")}"
                            .toUpperCase(),
                        maxLines: 1,
                        style: TextStyle(
                            color: white,
                            fontSize: 20.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: defaultPadding * 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                lastPageOptionWidget(
                                    () {},
                                    "${returnHowWasYourDayText(int.parse(howIsYourDayIndex.toStringAsFixed(0)))}"
                                        .replaceAll(" ", "")
                                        .toLowerCase(),
                                    "${returnHowWasYourDayText(int.parse(howIsYourDayIndex.toStringAsFixed(0)))}",
                                    int.parse(
                                        howIsYourDayIndex.toStringAsFixed(0)),
                                    0),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            lastPageWhatMakesYouFeelWidget(
                              "${whatMakesYouFeelData['image'][whatMakesYouFeelIndex]}",
                              "${whatMakesYouFeelData['name'][whatMakesYouFeelIndex]}",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  titleTextField(
                                      size,
                                      context,
                                      _titleController,
                                      _titleFocusNode,
                                      "Enter Title",
                                      "Add a Title"),
                                ],
                              ),
                            ),
                            textFormFieldWidgetSettingsPage(
                              size.height,
                              size.width,
                              context,
                              _thoughtsController,
                              _thoughtsFocusNode,
                              "Add more thoughts",
                              "Enter Something",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            buttonRegularCheckIn(() {
                              if (_formKey.currentState.validate()) {
                                _titleFocusNode.unfocus();
                                _thoughtsFocusNode.unfocus();
                                buildCPI(context);
                                prefs.setString('checkInDone', "true");
                                var dataCheckInTemp = dataCheckIn[
                                    returnHowWasYourDayText(int.parse(
                                        howIsYourDayIndex.toStringAsFixed(0)))];
                                refFirebase
                                    .child('Users')
                                    .child('$keyGlobal')
                                    .child('CheckIn')
                                    .push()
                                    .set({
                                  'howIsYourDay':
                                      '${returnHowWasYourDayText(int.parse(howIsYourDayIndex.toStringAsFixed(0)))}',
                                  'howDoYouFeelRightNow':
                                      '${dataCheckInTemp['name'][checkInPage1Index]}',
                                  'iAlsoFeel': '$iAlsoFeelText',
                                  'iAlsoFeelText':
                                      _iAlsoFeelTextController.text.toString(),
                                  'whatMakesYouFeel':
                                      "${whatMakesYouFeelData['name'][whatMakesYouFeelIndex]}",
                                  'title': _titleController.text.toString(),
                                  'thoughts':
                                      _thoughtsController.text.toString(),
                                  'dateTime': "$timeNow",
                                }).then((value) {
                                  Navigator.pop(context);
                                  checkDataFetchedActivity = false;
                                  showSnackBar(context, "Check In Submitted");
                                  _pageController.animateToPage(
                                    5,
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                  );
                                });
                              }
                            }, "Continue"),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Scaffold checkInPage5(Size size) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            containerBackgroundImage(
                "assets/image-3.jpg", size.height, size.height),
            containerBackgroundLinearGradient(grey2.withOpacity(0),
                blueVeryDark.withOpacity(0.5), size.height, size.width),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
              child: Stack(
                children: [
                  Container(
                    height: size.height,
                    width: size.width,
                    child: Column(
                      children: [
                        Container(
                          height: 65,
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: white,
                                    size: 25.0,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                              SizedBox(
                                width: size.width * 0.25,
                              ),
                              Text("Check-Ins",
                                  style: TextStyle(color: white, fontSize: 22))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: defaultPadding * 3,
                        ),
                        AutoSizeText(
                          "Excellent Work!",
                          maxLines: 1,
                          style: TextStyle(
                              color: white,
                              fontSize: 36.0,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: defaultPadding * 0.5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: AutoSizeText(
                            "Now would be a great time to do some Tapping",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: white,
                                fontSize: 25.0,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 40.0),
                        child: buttonRegularCheckIn(() {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => NavigationBar(indexSent: 1),
                            ),
                          );
                        }, "Start Tapping"),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

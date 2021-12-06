import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/models/tappingDataModel.dart';
import 'package:foodfreedomapp/screens/activityScreen/activityScreenPage.dart';
import 'package:foodfreedomapp/screens/audioPlayerTappingScreen/audioPlayerTappingScreenPage.dart';
import 'package:foodfreedomapp/screens/tappingScreen/tappingScreenPage.dart';
import 'package:foodfreedomapp/services/share.dart';
import 'package:foodfreedomapp/services/snackBar.dart';
import 'package:foodfreedomapp/services/userDetails.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TappingDetailsPage extends StatefulWidget {
  TappingDetailsPage({
    Key key,
    this.tappingDetailsObject,
  }) : super(key: key);
  final TappingDataModel tappingDetailsObject;
  @override
  _TappingDetailsPageState createState() =>
      _TappingDetailsPageState(tappingDetailsObject);
}

class _TappingDetailsPageState extends State<TappingDetailsPage> {
  TappingDataModel tappingDetailsObject;

  _TappingDetailsPageState(this.tappingDetailsObject);
  double height, width;
  bool isRatingsSwitched = false;
  SharedPreferences prefs;
  DatabaseReference refFirebase = FirebaseDatabase.instance.reference();
  bool favorite = false;
  bool download = false;
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCachePlayer = AudioCache();

  var timeNow;

  getSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    var favouriteString = prefs.getString('favorites');

    if (favouriteString != null) {
      setState(() {
        favorite =
            favouriteString.contains('${tappingDetailsObject.tappingKey}');
      });
    } else {
      favorite = false;
    }

    var downloadString = prefs.getString('downloads');

    if (downloadString != null) {
      setState(() {
        download =
            downloadString.contains('${tappingDetailsObject.tappingKey}');

        print(downloadString.contains('${tappingDetailsObject.tappingKey}'));
        print(downloadString);
      });
    } else {
      download = false;
    }
  }

  @override
  void initState() {
    super.initState();
    getSharedPref();
    timeNow = DateTime.now();
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
          child: Column(
            children: [
              Stack(
                children: [
                  backGroundImage(),
                  Container(
                    height: height,
                    width: width,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(22),
                            topRight: Radius.circular(22)),
                        child: Container(
                          height: height * 0.65,
                          width: width,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [darkModerateBlue2, veryDarkBlue],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: shadowColor,
                                    blurRadius: 3,
                                    offset: Offset(0, -6))
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                titleTapping(),
                                SizedBox(
                                  height: 10,
                                ),
                                authorDetails(),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buttonOptions(
                                        "assets/download.png", "Download",
                                        () async {
                                      if (!download) {
                                        buildCPIDownloading(context);

                                        var directory =
                                            await getApplicationDocumentsDirectory();
                                        Dio dio = Dio();
                                        try {
                                          await dio.download(
                                            '${tappingDetailsObject.audioLink}',
                                            "${directory.path}/${tappingDetailsObject.tappingKey}.mp3",
                                          );

                                          var downloadPrefs =
                                              prefs.getString('downloads');
                                          if (downloadPrefs != null) {
                                            downloadPrefs = downloadPrefs +
                                                "${directory.path}/${tappingDetailsObject.tappingKey}.mp3\\${tappingDetailsObject.tappingKey}\\${tappingDetailsObject.title}//";
                                          } else {
                                            downloadPrefs =
                                                "${directory.path}/${tappingDetailsObject.tappingKey}.mp3\\${tappingDetailsObject.tappingKey}\\${tappingDetailsObject.title}//";
                                          }

                                          prefs.setString(
                                              'downloads', "$downloadPrefs");

                                          setState(() {
                                            download = true;
                                          });
                                          tappingDataFetched = false;
                                          Navigator.pop(context);
                                          showSnackBar(context, "Downloaded");

                                          // final file = new File(
                                          //     "${directory.path}/${tappingDetailsObject.tappingKey}.mp3");

                                          // final result = await audioPlayer
                                          //     .play(file.path, isLocal: true);
                                          // audioPlayer.stop();

                                          // print(result);

                                        } catch (e) {
                                          print(e.toString());
                                        }
                                      } else {
                                        showSnackBar(
                                            context, "Already Downloaded");
                                      }
                                    }),
                                    buttonOptions(
                                        favorite
                                            ? "assets/heartfilled.png"
                                            : "assets/heart.png",
                                        "Favorite", () {
                                      var fav = prefs.getString('favorites');
                                      if (!favorite) {
                                        if (fav != null) {
                                          fav = fav +
                                              "${tappingDetailsObject.tappingKey}//";
                                        } else {
                                          fav =
                                              "${tappingDetailsObject.tappingKey}//";
                                        }
                                      } else {
                                        fav = fav.replaceAll(
                                            "${tappingDetailsObject.tappingKey}//",
                                            "");
                                      }

                                      prefs.setString('favorites', "$fav");
                                      setState(() {
                                        favorite = !favorite;
                                      });
                                      tappingDataFetched = false;
                                    }),
                                    buttonOptions("assets/share.png", "Share",
                                        () {
                                      share(
                                          "The Shared Content is ${tappingDetailsObject.title} by ${tappingDetailsObject.authorName}");
                                    }),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                buttonRegular4(() {
                                  buildCPI(context);
                                  refFirebase
                                      .child('Users')
                                      .child('$keyGlobal')
                                      .child('Tapping')
                                      .child(tappingDetailsObject.tappingKey)
                                      .update({
                                    'title': '${tappingDetailsObject.title}',
                                    'dateTime': "$timeNow",
                                    'tappingKey':
                                        '${tappingDetailsObject.tappingKey}',
                                    'status': 'inprogress',
                                    'description':
                                        '${tappingDetailsObject.description}',
                                    'category':
                                        '${tappingDetailsObject.category}',
                                    'image': '${tappingDetailsObject.image}',
                                    'audioLength':
                                        '${tappingDetailsObject.audioLength}',
                                  }).then((value) {
                                    Navigator.pop(context);

                                    tappingDataFetchedActivity = false;
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AudioPlayerTappingPage(
                                                audioLink: tappingDetailsObject
                                                    .audioLink,
                                                skipIntro: tappingDetailsObject
                                                    .skipIntro,
                                                tappingKey: tappingDetailsObject
                                                    .tappingKey,
                                                skipRating: isRatingsSwitched,
                                                blinkingModelData:
                                                    tappingDetailsObject
                                                        .blinkingModel,
                                                rateIntensityData:
                                                    tappingDetailsObject
                                                        .rateIntensity,
                                                title:
                                                    tappingDetailsObject.title),
                                      ),
                                    );
                                  });
                                }, "Play"),
                                SizedBox(
                                  height: 15,
                                ),
                                Divider(
                                  height: 10,
                                  color: white.withOpacity(0.5),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                descriptionTappingDetails(),
                                SizedBox(
                                  height: 20,
                                ),
                                skipRatingCheck(size),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: GradientAppBar(
                        "${tappingDetailsObject.category}",
                        true,
                        veryDarkGrayishViolet,
                        blueVeryDark.withOpacity(1),
                        white),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Row skipRatingCheck(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            height: 20, width: 20, child: Image.asset('assets/timer.png')),
        SizedBox(
          width: 10,
        ),
        Container(
          width: size.width * 0.62,
          child: RichText(
            text: TextSpan(
              children: const <TextSpan>[
                TextSpan(
                    text: 'Skip Rating for this Tapping Session',
                    style: TextStyle(
                      color: white,
                      fontSize: 14,
                      fontFamily: 'Raleway',
                    )),
              ],
            ),
          ),
        ),
        Switch(
          value: isRatingsSwitched,
          onChanged: (value) {
            setState(() {
              isRatingsSwitched = value;
            });
          },
          activeTrackColor: blueSoft,
          activeColor: blueDark,
          inactiveThumbColor: white,
          inactiveTrackColor: grey2,
        ),
      ],
    );
  }

  Row descriptionTappingDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: width * 0.87,
          child: AutoSizeText(
            "${tappingDetailsObject.description}",
            maxFontSize: 14,
            minFontSize: 14,
            maxLines: 8,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: white,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Row authorDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              foregroundImage: NetworkImage(
                "${tappingDetailsObject.authorImage}",
              ),
              backgroundColor: darkModerateBlue2,
              backgroundImage: AssetImage('assets/logo.png'),
            ),
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width * 0.5,
              child: AutoSizeText(
                "${tappingDetailsObject.authorName}",
                maxFontSize: 16,
                maxLines: 1,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              width: width * 0.5,
              child: AutoSizeText(
                "${tappingDetailsObject.audioLength}",
                maxFontSize: 14,
                maxLines: 1,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row titleTapping() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AutoSizeText(
          "${tappingDetailsObject.title}",
          maxFontSize: 18,
          maxLines: 1,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: white,
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Container backGroundImage() {
    return Container(
      height: height * 0.4,
      width: width,
      color: black,
      child: Image.network(
        "${tappingDetailsObject.image}",
        fit: BoxFit.fill,
      ),
    );
  }
}

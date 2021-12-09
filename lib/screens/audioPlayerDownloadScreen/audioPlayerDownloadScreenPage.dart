import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/configs.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/screens/audioPlayerTappingScreen/audioPlayerTappingScreenWidgets.dart';
import 'package:foodfreedomapp/screens/customizeTappingScreen/customizeTappingScreenPage.dart';
import 'package:foodfreedomapp/screens/tappingScreen/tappingScreenPage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class AudioPlayerDownloadPage extends StatefulWidget {
  AudioPlayerDownloadPage({
    Key key,
    this.title,
    this.tappingKey,
    this.audioLink,
  }) : super(key: key);
  final String title;
  final String tappingKey;
  final String audioLink;
  @override
  _AudioPlayerDownloadPageState createState() => _AudioPlayerDownloadPageState(
        title,
        tappingKey,
        audioLink,
      );
}

class _AudioPlayerDownloadPageState extends State<AudioPlayerDownloadPage> {
  final String title;
  final String tappingKey;
  final String audioLink;
  bool isPlaying = true;
  bool favorite = false;
  double speed = 1;
  double volume;

  _AudioPlayerDownloadPageState(
    this.title,
    this.tappingKey,
    this.audioLink,
  );
  double height, width;

  SharedPreferences prefs;
  DatabaseReference refFirebase = FirebaseDatabase.instance.reference();
  String favouriteString = "";
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayer bgMusicPlayer = AudioPlayer();
  AudioCache bgMusicCachePlayer = AudioCache();

  Duration _duration = new Duration();
  Duration _position = new Duration();

  String avatarAudioPlayer = "female";

  String bgMusicName;

  double tempRate = 0.0;

  getSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    avatarAudioPlayer = prefs.getString('avatarSelected');

    if (avatarAudioPlayer == null) {
      avatarAudioPlayer = "female";
    }

    bgMusicName = prefs.getString('bgMusicSelected');

    if (bgMusicName == null) {
      bgMusicName = "0";
    }

    var favouriteString = prefs.getString('favorites');

    if (favouriteString != null) {
      setState(() {
        favorite = favouriteString.contains('$tappingKey');
      });
    } else {
      favorite = false;
    }
  }

  void changeVolume(double value) {
    audioPlayer.setVolume(value);

    if (value == 0.0) {
      bgMusicPlayer.setVolume(0);
    } else {
      bgMusicPlayer.setVolume(0.25);
    }
  }

  _playAudio() async {
    try {
      // ignore: unused_local_variable
      int result = await audioPlayer.play("$audioLink");
      if (bgMusicName == "0") {
        bgMusicPlayer = await bgMusicCachePlayer.loop("birdsound.mp3");
      } else if (bgMusicName == "1") {
        bgMusicPlayer = await bgMusicCachePlayer.loop("rainsound.mp3");
      } else if (bgMusicName == "2") {}
      bgMusicPlayer.setVolume(0.25);
    } catch (e) {
      print(e.toString());
    }
  }

  _pauseAudio() async {
    // ignore: unused_local_variable
    int resultAudio = await audioPlayer.pause();
    // ignore: unused_local_variable
    int resultBgMusic = await bgMusicPlayer.pause();
  }

  _stopAudio() async {
    // ignore: unused_local_variable
    int resultAudio = await audioPlayer.stop();
    // ignore: unused_local_variable
    int resultBgMusic = await bgMusicPlayer.stop();
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    audioPlayer.seek(newDuration);
  }

  @override
  void initState() {
    super.initState();
    getSharedPref();
    _playAudio();

    volume = 10.0;

    audioPlayer.onDurationChanged.listen((Duration d) {
      print('Max duration: $d');
      setState(() => _duration = d);
    });

    audioPlayer.onAudioPositionChanged.listen((Duration p) {
      setState(() => _position = p);
    });

    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _position = _duration;
      });
    });
  }

  showRatingDialogueBox() {
    tempRate = 0.0;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return WillPopScope(
            onWillPop: () async => (false),
            child: StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                backgroundColor: desaturatedBlue.withOpacity(0.9),
                title: Center(
                    child: Text(
                  "Rate your Intensity",
                  style: TextStyle(color: white, fontSize: 20),
                )),
                content: Stack(
                  children: [
                    Center(
                      child: Container(
                        height: height * 0.65,
                        width: width * 0.4,
                        child: Container(
                          child: assetImage(
                            height,
                            width,
                            "assets/thermometer.png",
                            0.65,
                            0.4,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.033, top: height * 0.03),
                      child: Container(
                        height: height * 0.55,
                        child: SfSlider.vertical(
                          min: 0.0,
                          max: 10.0,
                          value: tempRate,
                          interval: 10,
                          activeColor: veryDarkBlue.withOpacity(tempRate / 10),
                          thumbIcon: Icon(Icons.circle, color: white, size: 18),
                          minorTicksPerInterval: 1,
                          onChanged: (dynamic value) {
                            setState(() {
                              tempRate = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: buttonRegular2(() {
                          setState(() {
                            _playAudio();
                            isPlaying = !isPlaying;
                          });
                          print("$tempRate");
                          Navigator.pop(context);
                        }, "Rate"),
                      ),
                    ],
                  ),
                ],
              );
            }),
          );
        });
    // Timer(Duration(seconds: 10), () {
    //   Navigator.pop(context);
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _stopAudio();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    return Scaffold(
        extendBody: true,
        body: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [softOrange, veryDarkDesaturatedOrange]),
            ),
            child: Column(children: [
              GradientAppBarAudioPlayer("$title"),
              Container(
                height: height * 0.88,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: defaultPadding * 0.5,
                      ),
                      Container(
                        height: height * 0.47,
                        width: width * 0.8,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              "assets/$avatarAudioPlayer.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 30),
                        child: AutoSizeText(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(color: white, fontSize: 15),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          buttonOptionsAudioPlayer(
                              "assets/audioplayertappingsettings.png", () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CustomizeTappingPage(
                                  fromWhere: "Audio Player",
                                ),
                              ),
                            );
                          }),
                          buttonOptionsAudioPlayer("assets/backward.png", () {
                            if (_position.inSeconds.toInt() - 15 > 0) {
                              seekToSecond(_position.inSeconds.toInt() - 15);
                            } else {
                              seekToSecond(0);
                            }
                          }),
                          buttonOptionsAudioPlayer(
                              !isPlaying
                                  ? "assets/play.png"
                                  : "assets/pause.png", () {
                            if (isPlaying) {
                              setState(() {
                                _pauseAudio();
                                isPlaying = !isPlaying;
                              });
                            } else {
                              setState(() {
                                _playAudio();
                                isPlaying = !isPlaying;
                              });
                            }
                          }),
                          buttonOptionsAudioPlayer("assets/forward.png", () {
                            if (_position.inSeconds.toInt() + 15 <
                                _duration.inSeconds) {
                              setState(() {
                                seekToSecond(_position.inSeconds.toInt() + 15);
                              });
                            } else {
                              setState(() {
                                seekToSecond(_duration.inSeconds.toInt());
                              });
                            }
                          }),
                          buttonOptionsAudioPlayer(
                              favorite
                                  ? "assets/favoritefilled.png"
                                  : "assets/favorite.png", () {
                            var fav = prefs.getString('favorites');
                            if (!favorite) {
                              if (fav != null) {
                                fav = fav + "$tappingKey//";
                              } else {
                                fav = "$tappingKey//";
                              }
                            } else {
                              fav = fav.replaceAll("$tappingKey//", "");
                            }
                            prefs.setString('favorites', "$fav");
                            setState(() {
                              favorite = !favorite;
                            });
                            tappingDataFetched = false;
                          }),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: AutoSizeText(
                              "$_position".substring(2, 7),
                              style: TextStyle(color: white, fontSize: 15),
                            ),
                          ),
                          Container(
                            width: width * 0.7,
                            child: Slider(
                                value: _position.inSeconds.toDouble(),
                                min: 0.0,
                                activeColor: white,
                                inactiveColor: grey2,
                                max: _duration.inSeconds.toDouble(),
                                onChanged: (double value) {
                                  print(value);
                                  setState(() {
                                    seekToSecond(value.toInt());
                                    value = value;
                                  });
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: AutoSizeText(
                              "$_duration".substring(2, 7),
                              style: TextStyle(color: white, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            bottomOptionWidgets(() {
                              if (speed != 1.5) {
                                setState(() {
                                  speed = speed + 0.25;
                                  audioPlayer.setPlaybackRate(
                                      playbackRate: speed);
                                });
                              } else {
                                setState(() {
                                  speed = 0.75;
                                  audioPlayer.setPlaybackRate(
                                      playbackRate: speed);
                                });
                              }
                            }, "$speed" + "x"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: width * 0.9,
                        decoration: BoxDecoration(
                          color: grayishRed.withOpacity(0.19),
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                MdiIcons.volumeHigh,
                                color: white,
                              ),
                              Container(
                                width: width * 0.75,
                                child: Slider(
                                    value: volume.toDouble(),
                                    min: 0.0,
                                    activeColor: white,
                                    inactiveColor: grey2,
                                    max: 10.0,
                                    onChanged: (double value) {
                                      print(value);
                                      setState(() {
                                        changeVolume(value);
                                        value = value;
                                        volume = value;
                                      });
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ])));
  }

  InkWell bottomOptionWidgets(onPressed, text) {
    return InkWell(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(7)),
        child: Container(
          decoration: BoxDecoration(color: veryDarkGrey3.withOpacity(0.4)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "$text",
              style: TextStyle(color: white),
            ),
          ),
        ),
      ),
    );
  }
}

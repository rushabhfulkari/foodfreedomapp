import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/screens/appSettingsScreen/appSettingsScreenWidgets.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsPage extends StatefulWidget {
  @override
  _AppSettingsPageState createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  double height, width;
  bool isSwitchedNotifications = false;
  bool isSwitchedTappingReminder = false;
  bool alarm1 = false;
  bool alarm2 = false;
  bool alarm3 = false;
  bool alarm4 = false;
  bool alarm5 = false;
  SharedPreferences prefs;
  String alarmTime1 = "";
  String alarmTime2 = "";
  String alarmTime3 = "";
  String alarmTime4 = "";
  String alarmTime5 = "";

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isSwitchedNotifications = prefs.getBool("Notifications");
      isSwitchedTappingReminder = prefs.getBool("Tapping Reminder");
      var alarmList = [];
      alarmList = prefs.getStringList("alarmList");

      if (alarmList != null) {
        alarmTime1 = alarmList[0].toString().split('_').first;
        alarmTime2 = alarmList[1].toString().split('_').first;
        alarmTime3 = alarmList[2].toString().split('_').first;
        alarmTime4 = alarmList[3].toString().split('_').first;
        alarmTime5 = alarmList[4].toString().split('_').first;

        alarm1 = alarmList[0].toString().split('_').last == "true";
        alarm2 = alarmList[1].toString().split('_').last == "true";
        alarm3 = alarmList[2].toString().split('_').last == "true";
        alarm4 = alarmList[3].toString().split('_').last == "true";
        alarm5 = alarmList[4].toString().split('_').last == "true";
      }
    });
    if (isSwitchedNotifications == null) {
      isSwitchedNotifications = false;
    }
    if (isSwitchedTappingReminder == null) {
      isSwitchedTappingReminder = false;
    }
  }

  showNotificationLocally(time) {
    if (isSwitchedTappingReminder) {
      // ignore: deprecated_member_use
      flutterLocalNotificationsPlugin.showDailyAtTime(
        2,
        "Your gentle tapping reminder",
        "Now is a great time to tap.",
        time,
        NotificationDetails(
          android: AndroidNotificationDetails(
            "",
            "Daily Tapping Reminder",
            "Description",
            playSound: true,
            fullScreenIntent: true,
            enableVibration: true,
            priority: Priority.high,
            icon: '@mipmap/app_logo_trans',
            ticker: 'ticker',
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        extendBody: true,
        appBar: appBarWithBackButton(context, "App Settings", () {
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
          child: Column(children: [
            appSettingsOptions(
              height,
              width,
              "notification.png",
              "Notifications",
              context,
              Switch(
                value: isSwitchedNotifications,
                onChanged: (value) {
                  setState(() {
                    isSwitchedNotifications = value;
                    prefs.setBool("Notifications", value);
                  });
                },
                activeTrackColor: blueSoft,
                activeColor: blueDark,
                inactiveThumbColor: white,
                inactiveTrackColor: grey2,
              ),
            ),
            appSettingsOptions(
              height,
              width,
              "reminder.png",
              "Daily Tapping Reminders",
              context,
              Switch(
                value: isSwitchedTappingReminder,
                onChanged: (value) {
                  setState(() {
                    isSwitchedTappingReminder = value;
                    prefs.setBool("Tapping Reminder", value);
                  });
                },
                activeTrackColor: blueSoft,
                activeColor: blueDark,
                inactiveThumbColor: white,
                inactiveTrackColor: grey2,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            isSwitchedTappingReminder
                ? Container(
                    height: height * 0.6,
                    width: width * 0.9,
                    child: Column(
                      children: [
                        dailyTappingReminderOption(
                            0,
                            context,
                            (time) {
                              if (alarm1) {
                                var dateTimeHere = DateTime.parse(alarmTime1);
                                showNotificationLocally(Time(dateTimeHere.hour,
                                    dateTimeHere.minute, dateTimeHere.second));
                              }
                              setState(() {
                                alarmTime1 = "$time";
                                prefs.setStringList('alarmList', [
                                  '$alarmTime1' + '_$alarm1',
                                  '$alarmTime2' + '_$alarm2',
                                  '$alarmTime3' + '_$alarm3',
                                  '$alarmTime4' + '_$alarm4',
                                  '$alarmTime5' + '_$alarm5',
                                ]);
                              });
                            },
                            alarmTime1,
                            (value) {
                              if (value && alarmTime1 != "") {
                                var dateTimeHere = DateTime.parse(alarmTime1);

                                showNotificationLocally(Time(dateTimeHere.hour,
                                    dateTimeHere.minute, dateTimeHere.second));
                              }
                              setState(() {
                                alarm1 = value;
                                prefs.setStringList('alarmList', [
                                  '$alarmTime1' + '_$alarm1',
                                  '$alarmTime2' + '_$alarm2',
                                  '$alarmTime3' + '_$alarm3',
                                  '$alarmTime4' + '_$alarm4',
                                  '$alarmTime5' + '_$alarm5',
                                ]);
                              });
                            },
                            alarm1),
                        dailyTappingReminderOption(
                            1,
                            context,
                            (time) {
                              if (alarm2) {
                                var dateTimeHere = DateTime.parse(alarmTime2);
                                showNotificationLocally(Time(dateTimeHere.hour,
                                    dateTimeHere.minute, dateTimeHere.second));
                              }

                              setState(() {
                                alarmTime2 = "$time";
                                prefs.setStringList('alarmList', [
                                  '$alarmTime1' + '_$alarm1',
                                  '$alarmTime2' + '_$alarm2',
                                  '$alarmTime3' + '_$alarm3',
                                  '$alarmTime4' + '_$alarm4',
                                  '$alarmTime5' + '_$alarm5',
                                ]);
                              });
                            },
                            alarmTime2,
                            (value) {
                              if (value && alarmTime2 != "") {
                                var dateTimeHere = DateTime.parse(alarmTime2);
                                showNotificationLocally(Time(dateTimeHere.hour,
                                    dateTimeHere.minute, dateTimeHere.second));
                              }
                              setState(() {
                                alarm2 = value;
                                prefs.setStringList('alarmList', [
                                  '$alarmTime1' + '_$alarm1',
                                  '$alarmTime2' + '_$alarm2',
                                  '$alarmTime3' + '_$alarm3',
                                  '$alarmTime4' + '_$alarm4',
                                  '$alarmTime5' + '_$alarm5',
                                ]);
                              });
                            },
                            alarm2),
                        dailyTappingReminderOption(
                            2,
                            context,
                            (time) {
                              if (alarm3) {
                                var dateTimeHere = DateTime.parse(alarmTime3);
                                showNotificationLocally(Time(dateTimeHere.hour,
                                    dateTimeHere.minute, dateTimeHere.second));
                              }

                              setState(() {
                                alarmTime3 = "$time";
                                prefs.setStringList('alarmList', [
                                  '$alarmTime1' + '_$alarm1',
                                  '$alarmTime2' + '_$alarm2',
                                  '$alarmTime3' + '_$alarm3',
                                  '$alarmTime4' + '_$alarm4',
                                  '$alarmTime5' + '_$alarm5',
                                ]);
                              });
                            },
                            alarmTime3,
                            (value) {
                              if (value && alarmTime3 != "") {
                                var dateTimeHere = DateTime.parse(alarmTime3);
                                showNotificationLocally(Time(dateTimeHere.hour,
                                    dateTimeHere.minute, dateTimeHere.second));
                              }
                              setState(() {
                                alarm3 = value;
                                prefs.setStringList('alarmList', [
                                  '$alarmTime1' + '_$alarm1',
                                  '$alarmTime2' + '_$alarm2',
                                  '$alarmTime3' + '_$alarm3',
                                  '$alarmTime4' + '_$alarm4',
                                  '$alarmTime5' + '_$alarm5',
                                ]);
                              });
                            },
                            alarm3),
                        dailyTappingReminderOption(
                            3,
                            context,
                            (time) {
                              if (alarm4) {
                                var dateTimeHere = DateTime.parse(alarmTime4);
                                showNotificationLocally(Time(dateTimeHere.hour,
                                    dateTimeHere.minute, dateTimeHere.second));
                              }

                              setState(() {
                                alarmTime4 = "$time";
                                prefs.setStringList('alarmList', [
                                  '$alarmTime1' + '_$alarm1',
                                  '$alarmTime2' + '_$alarm2',
                                  '$alarmTime3' + '_$alarm3',
                                  '$alarmTime4' + '_$alarm4',
                                  '$alarmTime5' + '_$alarm5',
                                ]);
                              });
                            },
                            alarmTime4,
                            (value) {
                              if (value && alarmTime4 != "") {
                                var dateTimeHere = DateTime.parse(alarmTime4);
                                showNotificationLocally(Time(dateTimeHere.hour,
                                    dateTimeHere.minute, dateTimeHere.second));
                              }
                              setState(() {
                                alarm4 = value;
                                prefs.setStringList('alarmList', [
                                  '$alarmTime1' + '_$alarm1',
                                  '$alarmTime2' + '_$alarm2',
                                  '$alarmTime3' + '_$alarm3',
                                  '$alarmTime4' + '_$alarm4',
                                  '$alarmTime5' + '_$alarm5',
                                ]);
                              });
                            },
                            alarm4),
                        dailyTappingReminderOption(
                            4,
                            context,
                            (time) {
                              if (alarm5) {
                                var dateTimeHere = DateTime.parse(alarmTime5);
                                showNotificationLocally(Time(dateTimeHere.hour,
                                    dateTimeHere.minute, dateTimeHere.second));
                              }
                              setState(() {
                                alarmTime5 = "$time";
                                prefs.setStringList('alarmList', [
                                  '$alarmTime1' + '_$alarm1',
                                  '$alarmTime2' + '_$alarm2',
                                  '$alarmTime3' + '_$alarm3',
                                  '$alarmTime4' + '_$alarm4',
                                  '$alarmTime5' + '_$alarm5',
                                ]);
                              });
                            },
                            alarmTime5,
                            (value) {
                              if (value && alarmTime5 != "") {
                                var dateTimeHere = DateTime.parse(alarmTime5);
                                showNotificationLocally(Time(dateTimeHere.hour,
                                    dateTimeHere.minute, dateTimeHere.second));
                              }
                              setState(() {
                                alarm5 = value;
                                prefs.setStringList('alarmList', [
                                  '$alarmTime1' + '_$alarm1',
                                  '$alarmTime2' + '_$alarm2',
                                  '$alarmTime3' + '_$alarm3',
                                  '$alarmTime4' + '_$alarm4',
                                  '$alarmTime5' + '_$alarm5',
                                ]);
                              });
                            },
                            alarm5),
                      ],
                    ),
                  )
                : Container()
          ]),
        ));
  }

  Padding dailyTappingReminderOption(index, BuildContext context, onConfirm,
      String alarm, onChanged, bool alarmBool) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Column(
        children: [
          Container(
            width: width * 0.9,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    DatePicker.showTimePicker(context,
                        showTitleActions: true,
                        theme: DatePickerTheme(
                            backgroundColor: vividCyan,
                            cancelStyle: TextStyle(
                                color: white,
                                fontSize: 14,
                                fontFamily: 'Raleway'),
                            itemStyle: TextStyle(
                                color: white,
                                fontSize: 16,
                                fontFamily: 'Raleway'),
                            doneStyle: TextStyle(
                                color: white,
                                fontSize: 14,
                                fontFamily: 'Raleway')),
                        onConfirm: onConfirm,
                        currentTime: alarm != ""
                            ? DateTime.parse(alarm)
                            : DateTime.now(),
                        locale: LocaleType.en);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      assetImage(
                          height, width, "assets/reminder.png", 0.06, 0.13),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: width * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            autoSizeTextWidget("Reminder ${index + 1}", white,
                                "Raleway", FontWeight.w400, 14.0),
                            AutoSizeText(
                              alarm != ""
                                  ? "${Jiffy(alarm).format("h:mm a")}"
                                  : "Pick a Time",
                              maxLines: 1,
                              style: TextStyle(
                                  color: white,
                                  fontSize: 40.0,
                                  fontFamily: "Raleway",
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: width * 0.25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Switch(
                              value: alarmBool,
                              onChanged: onChanged,
                              activeTrackColor: blueSoft,
                              activeColor: blueDark,
                              inactiveThumbColor: white,
                              inactiveTrackColor: grey2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

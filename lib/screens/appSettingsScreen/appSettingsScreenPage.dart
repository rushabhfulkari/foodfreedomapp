import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/screens/appSettingsScreen/appSettingsScreenWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsPage extends StatefulWidget {
  @override
  _AppSettingsPageState createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  double height, width;
  bool isSwitchedNotifications = false;
  bool isSwitchedTappingReminder = false;
  SharedPreferences prefs;

  getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isSwitchedNotifications = prefs.getBool("Notifications");
      isSwitchedTappingReminder = prefs.getBool("Tapping Reminder");
    });
    if (isSwitchedNotifications == null) {
      isSwitchedNotifications = false;
    }
    if (isSwitchedTappingReminder == null) {
      isSwitchedTappingReminder = false;
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
          ]),
        ));
  }
}

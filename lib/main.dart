import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/strings.dart';
import 'package:foodfreedomapp/screens/introScreen/introScreenPage.dart';
import 'package:foodfreedomapp/screens/navigationBar/navigationBar.dart';
import 'package:foodfreedomapp/services/scrollBehavior.dart';
import 'package:foodfreedomapp/services/userDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  'This channel is used for important notifications.',
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.instance.requestPermission();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  bool loggedIn = false;

  SharedPreferences prefs = await SharedPreferences.getInstance();
  loggedIn = prefs.getBool('loggedIn');

  List userDetails = prefs.getStringList('userDetails');

  if (userDetails != null) {
    firstNameGlobal = userDetails[0];
    lastNameGlobal = userDetails[1];
    emailGlobal = userDetails[2];
    phoneNumberGlobal = userDetails[3];
    keyGlobal = userDetails[4];
  }

  if (loggedIn == null) {
    loggedIn = false;
  }
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (prefs.getBool("Notifications")) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                playSound: true,
                fullScreenIntent: true,
                enableVibration: true,
                priority: Priority.high,
                icon: '@mipmap/app_logo_trans',
                ticker: 'ticker',
              ),
            ));
      }
    }
  });

  runApp(MyApp(
    loggedIn: loggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool loggedIn;
  MyApp({Key key, this.loggedIn}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: blueDark,
      statusBarColor: blueDark,
    ));
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      debugShowCheckedModeBanner: false,
      title: '$appTitle',
      theme: ThemeData(
        fontFamily: 'Raleway',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: loggedIn ? NavigationBar() : IntroScreen(),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/screens/introScreen/introScreenWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  final int initailPage;

  const IntroScreen({Key key, this.initailPage}) : super(key: key);
  @override
  _IntroScreenState createState() => _IntroScreenState(initailPage);
}

class _IntroScreenState extends State<IntroScreen> {
  int initailPage;
  _IntroScreenState(this.initailPage);
  PageController _pageController;
  SharedPreferences prefs;
  double height, width;

  @override
  void initState() {
    super.initState();
    if (initailPage == null) {
      initailPage = 0;
    }
    _pageController = PageController(initialPage: initailPage);
  }

  getPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            introScreenPage(
                0,
                blueDark.withOpacity(0.6),
                blueVeryDark.withOpacity(0.6),
                "Tapping",
                "Tapping, also know as EFT (Emotional Freedom Technique is like acupressure for your emotions.\n\nAn anti-diet approach toward food freedom, health on your terms, and genuine self-love.",
                "Next", () {
              if (_pageController.hasClients) {
                _pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              }
            }, height, width, false, context),
            introScreenPage(
                1,
                desaturatedBlue.withOpacity(0.6),
                grey2.withOpacity(0.6),
                "Gentle Reminders",
                "Tapping is most effective when done regularly. You’ll have the Support, and accountability to prioritize this self-care practice on a consistent basis, so you get the results you want.",
                "Next", () {
              if (_pageController.hasClients) {
                _pageController.animateToPage(
                  2,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              }
            }, height, width, false, context),
            introScreenPage(
                2,
                desaturatedBlue.withOpacity(0.6),
                grey2.withOpacity(0.6),
                "Emotional Temperature Check-Ins",
                "Emotional Temperature Check-In Slow down a bit to get an accurate reading of how you feel. If you want to change how you feel later, start with how you feel now.",
                "",
                null,
                height,
                width,
                true,
                context),
          ],
        ),
      ),
    );
  }
}

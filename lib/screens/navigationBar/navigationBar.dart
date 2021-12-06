import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/screens/activityScreen/activityScreenPage.dart';
import 'package:foodfreedomapp/screens/homeScreen/homeScreenPage.dart';
import 'package:foodfreedomapp/screens/tappingScreen/tappingScreenPage.dart';

TextStyle sample = TextStyle(color: Colors.white, fontSize: 20);

List<Widget> _dynamicPageList = [
  HomePage(),
  TappingPage(),
  ActivityPage(),
];

class NavigationBar extends StatefulWidget {
  NavigationBar({
    Key key,
    this.indexSent,
  }) : super(key: key);
  final int indexSent;
  @override
  _NavigationBarState createState() => _NavigationBarState(indexSent);
}

class _NavigationBarState extends State<NavigationBar>
    with SingleTickerProviderStateMixin {
  int indexSent;

  _NavigationBarState(this.indexSent);
  final autoSizeGroup = AutoSizeGroup();
  int _index;

  CurvedAnimation curve;

  final iconList = [
    {
      "assetName": 'assets/home.png',
      "iconName": 'Home',
    },
    {
      "assetName": 'assets/tapping.png',
      "iconName": 'Tapping',
    },
    {
      "assetName": 'assets/activity.png',
      "iconName": 'Activity',
    },
  ];

  @override
  void initState() {
    if (indexSent != null) {
      _index = indexSent;
    } else {
      _index = 0;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _onNavBarTapped(index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _dynamicPageList[_index],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          border: Border.all(color: white, width: 0),
          color: Colors.transparent,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: AnimatedBottomNavigationBar.builder(
            itemCount: 3,
            tabBuilder: (int index, bool isActive) {
              final color = isActive ? white : grey2;
              return BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 0.0,
                  sigmaY: 0.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start, // center
                  children: [
                    const SizedBox(height: 4),
                    Container(
                      height: 30,
                      width: 30,
                      child: Image.asset(
                        iconList[index]['assetName'],
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: AutoSizeText(
                        iconList[index]['iconName'],
                        maxLines: 1,
                        style: TextStyle(color: color),
                        group: autoSizeGroup,
                      ),
                    )
                  ],
                ),
              );
            },
            elevation: 0.1,
            activeIndex: _index,
            backgroundColor: Colors.transparent,
            splashRadius: 0,
            splashSpeedInMilliseconds: 0,
            notchSmoothness: NotchSmoothness.sharpEdge,
            leftCornerRadius: 20,
            rightCornerRadius: 20,
            gapLocation: GapLocation.none,
            onTap: _onNavBarTapped,
          ),
        ),
      ),
    );
  }
}

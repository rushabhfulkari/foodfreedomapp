import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/configs.dart';
import 'package:foodfreedomapp/constants/styles.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/screens/introScreen/introScreenStyles.dart';
import 'package:foodfreedomapp/screens/logInScreen/logInScreenPage.dart';
import 'package:foodfreedomapp/screens/signUpScreen/signUpScreenPage.dart';

InkWell buttonSignUp(BuildContext context) {
  return InkWell(
    onTap: () => Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SignUpPage()),
    ),
    child: Container(
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: white,
      ),
      height: 45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Sign Up',
            style: TextStyle(
                fontSize: 16.0, fontWeight: FontWeight.bold, color: blueDark),
          ),
        ],
      ),
    ),
  );
}

InkWell buttonLogIn(BuildContext context) {
  return InkWell(
    onTap: () => Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => LogInPage()),
    ),
    child: Container(
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: Colors.transparent,
        border: Border.all(color: white),
      ),
      height: 45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Log In',
            style: TextStyle(
                fontSize: 16.0, fontWeight: FontWeight.bold, color: white),
          ),
        ],
      ),
    ),
  );
}

Container introScreenPage(
    imageIndex,
    linearGradientColor1,
    linearGradientColor2,
    title,
    info,
    buttonText,
    onPressed,
    height,
    width,
    lastPage,
    context) {
  return Container(
    height: height,
    width: width,
    child: Stack(
      children: [
        containerBackgroundImage("assets/image-$imageIndex.jpg", height, width),
        containerBackgroundLinearGradient(
            linearGradientColor1, linearGradientColor2, height, width),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: height,
            width: width,
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: defaultPadding * 3,
                  ),
                  Text(
                    "$title",
                    textAlign: TextAlign.center,
                    style: titleTextStyle(),
                  ),
                  !lastPage
                      ? SizedBox(height: height * 0.2)
                      : SizedBox(height: height * 0.1),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding * 3),
                    child: Container(
                      height: height * 0.2,
                      child: Text(
                        "$info",
                        textAlign: TextAlign.center,
                        style: infoTextStyle(),
                      ),
                    ),
                  ),
                  !lastPage
                      ? Column(
                          children: [
                            SizedBox(
                              height: height * 0.23,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: defaultPadding),
                              child: ElevatedButton(
                                onPressed: onPressed,
                                style: buttonStyleFilled(),
                                child: Text(
                                  '$buttonText',
                                  style: buttonTextStyle(),
                                ),
                              ),
                            )
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: height * 0.1,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: defaultPadding),
                              child: ElevatedButton(
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => SignUpPage()),
                                ),
                                style: buttonStyleFilled(),
                                child: Text(
                                  'Sign up',
                                  style: buttonTextStyle(),
                                ),
                              ),
                            ),
                            OutlinedButton(
                                onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) => LogInPage()),
                                    ),
                                child: Text(
                                  'Log in',
                                  style: logInButtonTextStyleWhite(),
                                ),
                                style: buttonStyleWithBorder())
                          ],
                        )
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}

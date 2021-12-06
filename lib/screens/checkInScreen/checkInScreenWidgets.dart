import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/configs.dart';
import 'package:foodfreedomapp/constants/styles.dart';
import 'package:foodfreedomapp/constants/widgets.dart';

ButtonStyle selectButtonStyle(clickedIndex, index) {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(black.withOpacity(0.25)),
    side: MaterialStateProperty.all(
      BorderSide(
        color: clickedIndex == index ? desaturatedCyan : Colors.transparent,
        style: BorderStyle.solid,
        width: clickedIndex == index ? 3 : 0,
      ),
    ),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
    fixedSize: MaterialStateProperty.all<Size>(
      Size(100, 100),
    ),
  );
}

ButtonStyle selectButtonStyle2() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      darkModerateBlue,
    ),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
    fixedSize: MaterialStateProperty.all<Size>(
      Size(100, 100),
    ),
  );
}

ButtonStyle selectButtonStyle3(clickedIndex, index) {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(black.withOpacity(0.3)),
    side: MaterialStateProperty.all(
      BorderSide(
        color: clickedIndex == index ? darkModerateBlue : Colors.transparent,
        style: BorderStyle.solid,
        width: clickedIndex == index ? 2 : 0,
      ),
    ),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
    fixedSize: MaterialStateProperty.all<Size>(
      Size(100, 30),
    ),
  );
}

ButtonStyle selectButtonStyle4() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      darkModerateBlue,
    ),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
    fixedSize: MaterialStateProperty.all<Size>(
      Size(100, 100),
    ),
  );
}

ButtonStyle selectButtonStyle5(stringTotalWhatMakesYouFeel, text) {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(black.withOpacity(0.3)),
    side: MaterialStateProperty.all(
      BorderSide(
        color: stringTotalWhatMakesYouFeel.toString().contains('$text')
            ? white
            : Colors.transparent,
        style: BorderStyle.solid,
        width: stringTotalWhatMakesYouFeel.toString().contains('$text') ? 2 : 0,
      ),
    ),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
    fixedSize: MaterialStateProperty.all<Size>(
      Size(100, 100),
    ),
  );
}

ButtonStyle selectButtonStyle6() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(darkModerateBlue),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
    fixedSize: MaterialStateProperty.all<Size>(
      Size(80, 80),
    ),
  );
}

ButtonStyle selectButtonStyle7() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(black.withOpacity(0.3)),
    side: MaterialStateProperty.all(
      BorderSide(
        color: white,
        style: BorderStyle.solid,
        width: 1,
      ),
    ),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
    fixedSize: MaterialStateProperty.all<Size>(
      Size(80, 80),
    ),
  );
}

ButtonStyle selectButtonStyle8() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(black.withOpacity(0.25)),
    side: MaterialStateProperty.all(
      BorderSide(
        color: Colors.transparent,
        style: BorderStyle.solid,
        width: 0,
      ),
    ),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
    fixedSize: MaterialStateProperty.all<Size>(
      Size(100, 100),
    ),
  );
}

Widget titleTextField(size, context, controller, validatorText, hintText) {
  return Container(
    width: size.width * 0.95,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return "$validatorText";
              } else {
                return null;
              }
            },
            controller: controller,
            scrollPadding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            keyboardType: TextInputType.text,
            cursorWidth: ((0.067 * size.height) / 100),
            cursorColor: Colors.grey,
            style: TextStyle(
              fontSize: ((2.032 * size.height) / 100),
              color: white,
            ),
            decoration: InputDecoration(
              disabledBorder: buildTextFieldOutlineInputBorder(size),
              focusedBorder: buildTextFieldOutlineInputBorder(size),
              errorBorder: buildTextFieldOutlineInputBorder(size),
              focusedErrorBorder: buildTextFieldOutlineInputBorder(size),
              border: buildTextFieldOutlineInputBorder(size),
              enabledBorder: buildTextFieldOutlineInputBorder(size),
              contentPadding: EdgeInsets.only(
                left: ((1.896 * size.height) / 100),
                right: ((1.896 * size.height) / 100),
              ),
              filled: true,
              fillColor: blackTextBox,
              hintText: "$hintText",
              hintStyle: hintTextStyle,
            ),
            textInputAction: TextInputAction.next,
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
            },
          ),
        ],
      ),
    ),
  );
}

InkWell iAlsoFeelButton(onPressed, text, index, iAlsoFeelIndex) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      decoration: BoxDecoration(
          color: black.withOpacity(0.3),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color:
                iAlsoFeelIndex == index ? darkModerateBlue : Colors.transparent,
            width: iAlsoFeelIndex == index ? 2 : 0,
            style: BorderStyle.solid,
          )),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$text",
              style: TextStyle(color: white, fontSize: 15),
            ),
          ],
        ),
      ),
    ),
  );
}

Column lastPageWhatMakesYouFeelWidget(pngName, text) {
  return Column(
    children: [
      Row(
        children: [
          TextButton(
              onPressed: () {},
              style: selectButtonStyle7(),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Image.asset(
                        "assets/$pngName.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: containerBackgroundLinearGradient(
                        black.withOpacity(0.3),
                        black.withOpacity(0.3),
                        80.0,
                        80.0),
                  ),
                ],
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
      ),
    ],
  );
}

Column whatMakesYouFeelWidget(onPressed, pngName, text, whatMakesYouFeel) {
  return Column(
    children: [
      TextButton(
          onPressed: onPressed,
          style: selectButtonStyle5(whatMakesYouFeel, '$text'),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  height: 100,
                  width: 100,
                  child: Image.asset(
                    "assets/$pngName.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: containerBackgroundLinearGradient(black.withOpacity(0.3),
                    black.withOpacity(0.3), 100.0, 100.0),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "$text",
                    style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
              ),
            ],
          )),
    ],
  );
}

String returnHowWasYourDayText(howIsYourDayIndex) {
  if (howIsYourDayIndex == 4) {
    return "Amazing";
  } else if (howIsYourDayIndex == 3) {
    return "Pretty Good";
  } else if (howIsYourDayIndex == 2) {
    return "Okay";
  } else if (howIsYourDayIndex == 1) {
    return "Somewhat Bad";
  } else if (howIsYourDayIndex == 0) {
    return "Horrible";
  }
  return "";
}

String returnAppBarText(howIsYourDayIndex) {
  if (howIsYourDayIndex == 4) {
    return "That’s Awesome";
  } else if (howIsYourDayIndex == 3) {
    return "That’s Great";
  } else if (howIsYourDayIndex == 2) {
    return "Alright";
  } else if (howIsYourDayIndex == 1) {
    return "Understandable";
  } else if (howIsYourDayIndex == 0) {
    return "Sorry to hear.";
  }
  return "";
}

List returnLastPageWhatMakesYouFeelData(
    whatMakesYouFeelData, whatMakesYouFeel) {
  List tempList = [];
  if (whatMakesYouFeel != "") {
    for (var i = 0; i < whatMakesYouFeelData['name'].length; i++) {
      if (whatMakesYouFeel
          .toString()
          .contains(whatMakesYouFeelData['name'][i])) {
        tempList.add({
          'name': '${whatMakesYouFeelData['name'][i]}',
          'image': '${whatMakesYouFeelData['image'][i]}'
        });
      }
    }
    return tempList;
  }
  return tempList;
}

ElevatedButton buttonRegularCheckIn(onPressed, buttonText) {
  return ElevatedButton(
    onPressed: onPressed,
    style: buttonStyleFilled2(),
    child: Text(
      '$buttonText',
      style: TextStyle(
          color: blueVeryDark2, fontSize: 16, fontWeight: FontWeight.w900),
    ),
  );
}

Column checkInPage1Widget(onPressed, pngName, text, clickedIndex, index) {
  return Column(
    children: [
      TextButton(
          onPressed: onPressed,
          style: selectButtonStyle(clickedIndex, index),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 40,
                child: Image.asset("assets/$pngName.png"),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "$text",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: white, fontWeight: FontWeight.w400, fontSize: 13),
              ),
            ],
          )),
    ],
  );
}

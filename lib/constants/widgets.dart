import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/configs.dart';
import 'package:foodfreedomapp/constants/styles.dart';
import 'package:foodfreedomapp/screens/settingScreen/settingScreenPage.dart';
import 'package:lottie/lottie.dart';

Container containerBackgroundLinearGradient(
    linearGradientColor1, linearGradientColor2, height, width) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          linearGradientColor1,
          linearGradientColor2,
        ],
      ),
    ),
  );
}

Container containerBackgroundImage(assetImagePath, height, width) {
  return Container(
      height: height,
      width: width,
      child: Image(
        image: AssetImage("$assetImagePath"),
        fit: BoxFit.fill,
      ));
}

Row backButton(onPressed) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      IconButton(
          onPressed: onPressed, icon: Icon(Icons.arrow_back, color: white)),
    ],
  );
}

ElevatedButton buttonRegular(onPressed, buttonText) {
  return ElevatedButton(
    onPressed: onPressed,
    style: buttonStyleFilled(),
    child: Text(
      '$buttonText',
      style: buttonTextStyle(),
    ),
  );
}

ElevatedButton buttonRegular2(onPressed, buttonText) {
  return ElevatedButton(
    onPressed: onPressed,
    style: buttonStyleFilled2(),
    child: Text(
      '$buttonText',
      style: buttonTextStyle(),
    ),
  );
}

OutlinedButton buttonRegular3(onTap, title) {
  return OutlinedButton(
      onPressed: onTap,
      child: Text(
        '$title',
        style: logInButtonTextStyleBlue(),
      ),
      style: buttonStyleWithBorderBlue());
}

ElevatedButton buttonRegular4(onPressed, buttonText) {
  return ElevatedButton(
    onPressed: onPressed,
    style: buttonStyleFilled2(),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.play_arrow,
          color: black,
        ),
        SizedBox(
          width: 5,
        ),
        Text('$buttonText',
            style: TextStyle(
                color: black, fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

Widget buildCPI(context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Container(
          decoration: BoxDecoration(color: black.withOpacity(0.4)),
          child: Center(
              child: Container(
                  height: 250,
                  width: 250,
                  child: Lottie.asset('assets/loading.json')))));
  return Container();
}

Widget buildCPIDownloading(context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Container(
          decoration: BoxDecoration(color: black.withOpacity(0.4)),
          child: Center(
              child: Container(
                  height: 150,
                  width: 150,
                  child: Lottie.asset('assets/downloading.json')))));
  return Container();
}

Widget buildCPIWidget(height, width) {
  return Container(
      height: height * 0.75,
      width: width,
      child: Center(
          child: Container(
              height: 250,
              width: 250,
              child: Lottie.asset('assets/loading.json'))));
}

Widget textFormFieldWidget(
  labelText,
  size,
  context,
  controller,
  focusNode,
  nextFocusNode,
  hintText,
  unFocus,
  keyboardNumberType,
  validatorText,
) {
  return Container(
    width: size.width * 0.9,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "$labelText",
                textAlign: TextAlign.start,
                style: textFieldTextStyle,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return "$validatorText";
              } else {
                return null;
              }
            },
            controller: controller,
            focusNode: focusNode,
            scrollPadding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            keyboardType:
                keyboardNumberType ? TextInputType.number : TextInputType.text,
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
              if (unFocus) {
                FocusScope.of(context).unfocus();
              } else {
                FocusScope.of(context).requestFocus(nextFocusNode);
              }
            },
          ),
        ],
      ),
    ),
  );
}

Widget textFormFieldWidgetSettingsPage(
  height,
  width,
  context,
  controller,
  hintText,
  validatorText,
) {
  return Container(
    width: width * 0.95,
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
            cursorWidth: ((0.067 * height) / 100),
            cursorColor: Colors.grey,
            style: TextStyle(
              fontSize: ((2.032 * height) / 100),
              color: white,
            ),
            decoration: InputDecoration(
              disabledBorder: buildTextFieldOutlineInputBorder(height),
              focusedBorder: buildTextFieldOutlineInputBorder(height),
              errorBorder: buildTextFieldOutlineInputBorder(height),
              focusedErrorBorder: buildTextFieldOutlineInputBorder(height),
              border: buildTextFieldOutlineInputBorder(height),
              enabledBorder: buildTextFieldOutlineInputBorder(height),
              contentPadding: EdgeInsets.only(
                left: ((1.896 * height) / 100),
                top: ((1.896 * height) / 100),
                right: ((1.896 * height) / 100),
              ),
              filled: true,
              fillColor: blackTextBox,
              hintText: "$hintText",
              hintStyle: hintTextStyle,
            ),
            textInputAction: TextInputAction.next,
            maxLines: 8,
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
            },
          ),
        ],
      ),
    ),
  );
}

class OtpTextField extends StatefulWidget {
  final String lastPin;
  final int fields;
  final onSubmit;
  final fieldWidth;
  final fontSize;
  final isTextObscure;
  final showFieldAsBox;

  OtpTextField(
      {this.lastPin,
      this.fields: 4,
      this.onSubmit,
      this.fieldWidth: 40.0,
      this.fontSize: 20.0,
      this.isTextObscure: false,
      this.showFieldAsBox: false})
      : assert(fields > 0);

  @override
  State createState() {
    return OtpTextFieldState();
  }
}

class OtpTextFieldState extends State<OtpTextField> {
  List<String> _pin;
  List<FocusNode> _focusNodes;
  List<TextEditingController> _textControllers;

  Widget textfields = Container();

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    _pin = List<String>(widget.fields);
    // ignore: deprecated_member_use
    _focusNodes = List<FocusNode>(widget.fields);
    // ignore: deprecated_member_use
    _textControllers = List<TextEditingController>(widget.fields);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (widget.lastPin != null) {
          for (var i = 0; i < widget.lastPin.length; i++) {
            _pin[i] = widget.lastPin[i];
          }
        }
        textfields = generateTextFields(context);
      });
    });
  }

  @override
  void dispose() {
    _textControllers.forEach((TextEditingController t) => t.dispose());
    super.dispose();
  }

  Widget generateTextFields(BuildContext context) {
    List<Widget> textFields = List.generate(widget.fields, (int i) {
      return buildTextField(i, context);
    });

    if (_pin.first != null) {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    }

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: textFields);
  }

  void clearTextFields() {
    _textControllers.forEach(
        (TextEditingController tEditController) => tEditController.clear());
    _pin.clear();
  }

  Widget buildTextField(int i, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (_focusNodes[i] == null) {
      _focusNodes[i] = FocusNode();
    }
    if (_textControllers[i] == null) {
      _textControllers[i] = TextEditingController();
      if (widget.lastPin != null) {
        _textControllers[i].text = widget.lastPin[i];
      }
    }

    _focusNodes[i].addListener(() {
      if (_focusNodes[i].hasFocus) {}
    });

    final String lastDigit = _textControllers[i].text;

    return Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.only(right: 10.0),
      child: TextField(
        controller: _textControllers[i],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        autofocus: true,
        maxLength: 1,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: white,
            fontSize: widget.fontSize),
        focusNode: _focusNodes[i],
        obscureText: widget.isTextObscure,
        decoration: InputDecoration(
          counterText: "",
          fillColor: blackTextBox,
          filled: true,
          border: buildTextFieldOutlineInputBorder(size),
          enabledBorder: buildTextFieldOutlineInputBorder(size),
          errorBorder: buildTextFieldOutlineInputBorder(size),
          disabledBorder: buildTextFieldOutlineInputBorder(size),
          focusedBorder: buildTextFieldOutlineInputBorder(size),
          focusedErrorBorder: buildTextFieldOutlineInputBorder(size),
        ),
        cursorColor: Colors.grey,
        cursorWidth: ((0.067 * size.height) / 100),
        onChanged: (String str) {
          setState(() {
            _pin[i] = str;
          });
          if (i + 1 != widget.fields) {
            _focusNodes[i].unfocus();
            if (lastDigit != null && _pin[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            } else {
              FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
            }
          } else {
            _focusNodes[i].unfocus();
            if (lastDigit != null && _pin[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            }
          }
          if (_pin.every((String digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
        onSubmitted: (String str) {
          if (_pin.every((String digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return textfields;
  }
}

class GradientAppBar extends StatelessWidget {
  final String title;
  final bool back;
  final Color color1;
  final Color color2;
  final Color colorTitle;
  final double barHeight = 60.0;

  GradientAppBar(
      this.title, this.back, this.color1, this.color2, this.colorTitle);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    double width = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: 0.5,
          child: new Container(
            padding: EdgeInsets.only(top: statusbarHeight),
            height: statusbarHeight + barHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [color1, color2],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  tileMode: TileMode.clamp),
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: 10.0, right: 10.0, top: statusbarHeight),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              back
                  ? IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: colorTitle,
                        size: 25.0,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                  : Container(
                      width: width * 0.1,
                    ),
              Container(
                width: width * 0.6,
                child: Center(
                  child: AutoSizeText(
                    title,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    maxFontSize: 16,
                    minFontSize: 12,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: colorTitle,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              CircleAvatar(
                child: IconButton(
                    icon: Icon(
                      Icons.settings_outlined,
                      color: white,
                      size: 25.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SettingsPage(),
                        ),
                      );
                    }),
                backgroundColor: black.withOpacity(0.25),
              )
            ],
          ),
        ),
      ],
    );
  }
}

Widget assetImage(
  height,
  width,
  img,
  h,
  w,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: height * h,
            width: width * w,
            child: Image.asset(
              "$img",
            )),
      ],
    ),
  );
}

Widget assetImageColor(height, width, img, h, w, color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: height * h,
            width: width * w,
            child: Image.asset(
              "$img",
              color: color,
            )),
      ],
    ),
  );
}

AutoSizeText autoSizeTextWidget(text, color, fontFamily, fontWeight, fontSize) {
  return AutoSizeText(
    "$text",
    maxFontSize: 16,
    maxLines: 1,
    style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight),
  );
}

AppBar appBarWithBackButton(BuildContext context, title, onPressed) {
  return AppBar(
    centerTitle: true,
    backgroundColor: strongCyan,
    toolbarHeight: 65,
    elevation: 0,
    title: Text("$title"),
    leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: white,
          size: 25.0,
        ),
        onPressed: onPressed),
  );
}

AppBar appBarWithBackButtonDarkBlue(BuildContext context, title, onPressed) {
  return AppBar(
    centerTitle: true,
    backgroundColor: blueDark,
    toolbarHeight: 65,
    elevation: 0,
    title: Text("$title"),
    leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: white,
          size: 25.0,
        ),
        onPressed: onPressed),
  );
}

AppBar appBarWithBackButtonCheckInDetails(
    BuildContext context, title, onPressed) {
  return AppBar(
    centerTitle: true,
    backgroundColor: vividCyan,
    toolbarHeight: 65,
    elevation: 0,
    title: Text("$title"),
    leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: white,
          size: 25.0,
        ),
        onPressed: onPressed),
  );
}

AppBar appBarWithBackButtonTransparent(BuildContext context, title, onPressed) {
  return AppBar(
    centerTitle: true,
    backgroundColor: desaturatedBlue.withOpacity(0.5),
    toolbarHeight: 65,
    elevation: 0,
    title: Text("$title"),
    leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: white,
          size: 25.0,
        ),
        onPressed: onPressed),
  );
}

AppBar appBarWithBackButtonVeryDarkDesaturatedOrange2(
    BuildContext context, title, onPressed) {
  return AppBar(
    centerTitle: true,
    backgroundColor: veryDarkDesaturatedOrange2,
    toolbarHeight: 65,
    elevation: 0,
    title: Text("$title"),
    leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: white,
          size: 25.0,
        ),
        onPressed: onPressed),
  );
}

AppBar appBarWithBackButtonDarkBlueFontSizeMore(
    BuildContext context, title, onPressed) {
  return AppBar(
    centerTitle: true,
    backgroundColor: blueDark,
    toolbarHeight: 65,
    elevation: 0,
    title: Text(
      "$title",
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
    leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: white,
          size: 25.0,
        ),
        onPressed: onPressed),
  );
}

Container titleTextSettingsScreen(text, width) {
  return Container(
    width: width,
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10),
      child: Text(
        "$text",
        textAlign: TextAlign.left,
        style: titleSettingsTextStyle,
      ),
    ),
  );
}

Container instructionTextSettingsScreen(text, width) {
  return Container(
    width: width,
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10),
      child: Text(
        "$text",
        textAlign: TextAlign.left,
        style: instructionSettingsTextStyle,
      ),
    ),
  );
}

void showDialogBoxWithOneButton(context, text, description) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(text),
          content: SingleChildScrollView(child: Text(description)),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "OK",
                  style: TextStyle(color: blueDark),
                ))
          ],
        );
      });
}

void confirmDialogue(context, text, description, onYes, onNo) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return AlertDialog(
          title: Text(text),
          content: SingleChildScrollView(child: Text(description)),
          actions: [
            TextButton(
                onPressed: onNo,
                child: Text(
                  "NO",
                  style: TextStyle(color: blueDark),
                )),
            TextButton(
                onPressed: onYes,
                child: Text(
                  "YES",
                  style: TextStyle(color: blueDark),
                )),
          ],
        );
      });
}

Widget noDataDoundWidget(height) {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: height * 0.7,
        width: 200,
        child: Center(
          child: Text(
            "No Data Found",
            textAlign: TextAlign.center,
            style: TextStyle(color: white, fontSize: 20),
          ),
        ),
      )
    ],
  ));
}

InkWell buttonOptions(image, text, onPressed) {
  return InkWell(
    onTap: onPressed,
    child: Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            new Container(
              width: 50,
              height: 50,
              decoration: new BoxDecoration(
                color: grey2.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
            Center(
              child: Container(
                height: 30,
                width: 30,
                child: Image.asset(
                  "$image",
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "$text",
          style: TextStyle(color: white, fontSize: 15),
        )
      ],
    ),
  );
}

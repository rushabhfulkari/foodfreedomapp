import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/configs.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/services/sendDataToFirebaseFromSettingsPage.dart';
import 'package:foodfreedomapp/services/snackBar.dart';
import 'package:foodfreedomapp/services/userDetails.dart';

class ResourcesPage extends StatefulWidget {
  @override
  _ResourcesPageState createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {
  final _formKey = new GlobalKey<FormState>();
  double height, width;
  bool checkBoxBool1 = false;
  bool checkBoxBool2 = false;
  bool checkBoxBool3 = false;
  bool checkBoxBool4 = false;
  bool checkBoxBool5 = false;
  bool checkBoxBool6 = false;
  bool checkBoxBool7 = false;
  bool checkBoxBool8 = false;
  bool other = false;
  TextEditingController _textController = TextEditingController();
  DatabaseReference refFirebase = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
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
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: defaultPadding * 0.5,
                      left: defaultPadding * 0.5,
                      right: defaultPadding * 0.5,
                      bottom: defaultPadding * 14),
                  child: Form(
                    key: _formKey,
                    child: Column(children: [
                      backButton(() {
                        Navigator.pop(context);
                      }),
                      SizedBox(
                        height: 10,
                      ),
                      titleTextSettingsScreen(
                          "Looking for a Weight Neutral Wellness Partner?",
                          width),
                      SizedBox(
                        height: 10,
                      ),
                      checkBoxTile("EFT Tapping Coach", (bool value) {
                        setState(() {
                          this.checkBoxBool1 = value;
                        });
                      }, this.checkBoxBool1),
                      checkBoxTile("Intuitive Eating/Anti-diet Therapist",
                          (bool value) {
                        setState(() {
                          this.checkBoxBool2 = value;
                        });
                      }, this.checkBoxBool2),
                      checkBoxTile("Intuitive Eating Dietitian", (bool value) {
                        setState(() {
                          this.checkBoxBool3 = value;
                        });
                      }, this.checkBoxBool3),
                      checkBoxTile("Weight Neutral Personal Trainer",
                          (bool value) {
                        setState(() {
                          this.checkBoxBool4 = value;
                        });
                      }, this.checkBoxBool4),
                      checkBoxTile("Intuitive Eating Coach", (bool value) {
                        setState(() {
                          this.checkBoxBool5 = value;
                        });
                      }, this.checkBoxBool5),
                      checkBoxTile("Anti-diet Doctor", (bool value) {
                        setState(() {
                          this.checkBoxBool6 = value;
                        });
                      }, this.checkBoxBool6),
                      checkBoxTile("Food Freedom Tapping Facebook Community",
                          (bool value) {
                        setState(() {
                          this.checkBoxBool7 = value;
                        });
                      }, this.checkBoxBool7),
                      checkBoxTile("Food Freedom Tapping on Instagram",
                          (bool value) {
                        setState(() {
                          this.checkBoxBool8 = value;
                        });
                      }, this.checkBoxBool8),
                      checkBoxTile("Other", (bool value) {
                        setState(() {
                          this.other = value;
                        });
                      }, this.other),
                      other
                          ? textFormFieldWidgetSettingsPage(
                              height,
                              width,
                              context,
                              _textController,
                              "Other",
                              "Enter a Resource",
                            )
                          : Container(),
                      SizedBox(
                        height: 20,
                      ),
                      buttonRegular(() {
                        if (checkBoxBool1 ||
                            checkBoxBool2 ||
                            checkBoxBool3 ||
                            checkBoxBool4 ||
                            checkBoxBool5 ||
                            checkBoxBool6 ||
                            checkBoxBool7 ||
                            checkBoxBool8 ||
                            other) {
                          sendDataToFirebaseFromSettingsPage(
                              firstNameGlobal,
                              lastNameGlobal,
                              returnResourceText(),
                              emailGlobal,
                              phoneNumberGlobal,
                              refFirebase,
                              context,
                              {
                                Navigator.pop(context),
                                showSnackBar(context, "Details Subbmitted")
                              },
                              "Resources");
                        } else {
                          showSnackBar(
                              context, "Please Select atleast one Resource");
                        }
                      }, "Submit")
                    ]),
                  ),
                ),
              ]),
            ),
          )),
    );
  }

  String returnResourceText() {
    String text = "";

    if (checkBoxBool1) {
      text = text + "EFT Tapping Coach//";
    }

    if (checkBoxBool2) {
      text = text + "Intuitive Eating/Anti-diet Therapist//";
    }

    if (checkBoxBool3) {
      text = text + "Intuitive Eating Dietitian//";
    }

    if (checkBoxBool4) {
      text = text + "Weight Neutral Personal Trainer//";
    }
    if (checkBoxBool5) {
      text = text + "Intuitive Eating Coach";
    }
    if (checkBoxBool6) {
      text = text + "Anti-diet Doctor";
    }
    if (checkBoxBool7) {
      text = text + "Food Freedom Tapping Facebook Community";
    }
    if (checkBoxBool8) {
      text = text + "Food Freedom Tapping on Instagram";
    }
    if (other) {
      text = text + "${_textController.text}";
    }

    return text;
  }

  CheckboxListTile checkBoxTile(text, function, value) {
    return CheckboxListTile(
        title: Text(
          '$text',
          style: TextStyle(fontSize: 16, color: white),
        ),
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.all(1),
        activeColor: white,
        tileColor: white,
        selectedTileColor: white,
        checkColor: strongCyan,
        value: value,
        onChanged: function);
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/configs.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/services/sendDataToFirebaseFromSettingsPage.dart';
import 'package:foodfreedomapp/services/snackBar.dart';
import 'package:foodfreedomapp/services/userDetails.dart';

class SuggestTappingTopicPage extends StatefulWidget {
  @override
  _SuggestTappingTopicPageState createState() =>
      _SuggestTappingTopicPageState();
}

class _SuggestTappingTopicPageState extends State<SuggestTappingTopicPage> {
  double height, width;
  final _formKey = new GlobalKey<FormState>();

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
          extendBody: true,
          resizeToAvoidBottomInset: false,
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
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding * 0.5),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  backButton(() {
                    Navigator.pop(context);
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  titleTextSettingsScreen("Suggest Tapping Topic", width),
                  SizedBox(
                    height: 10,
                  ),
                  instructionTextSettingsScreen(
                      "We’re all ears. Let us know other topics you’d like to tap on and we’ll do our best to oblige.",
                      width),
                  SizedBox(
                    height: 10,
                  ),
                  textFormFieldWidgetSettingsPage(
                    height,
                    width,
                    context,
                    _textController,
                    "Write your suggestion here",
                    "Enter Tapping Topic",
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  buttonRegular2(() {
                    if (_formKey.currentState.validate()) {
                      sendDataToFirebaseFromSettingsPage(
                          firstNameGlobal,
                          lastNameGlobal,
                          _textController.text,
                          emailGlobal,
                          phoneNumberGlobal,
                          refFirebase,
                          context,
                          {
                            Navigator.pop(context),
                            showSnackBar(
                                context, "Tapping Topic Suggestion Submitted")
                          },
                          "Tapping Topic Suggestions");
                    }
                  }, "Submit")
                ]),
              ),
            ),
          )),
    );
  }
}

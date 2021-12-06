import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/configs.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/services/sendDataToFirebaseFromSettingsPage.dart';
import 'package:foodfreedomapp/services/snackBar.dart';
import 'package:foodfreedomapp/services/userDetails.dart';

class SuggestAppFeaturePage extends StatefulWidget {
  @override
  _SuggestAppFeaturePageState createState() => _SuggestAppFeaturePageState();
}

class _SuggestAppFeaturePageState extends State<SuggestAppFeaturePage> {
  double height, width;

  final _formKey = new GlobalKey<FormState>();
  DatabaseReference refFirebase = FirebaseDatabase.instance.reference();

  TextEditingController _textController = TextEditingController();

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
                  titleTextSettingsScreen("Suggest App Feature", width),
                  SizedBox(
                    height: 10,
                  ),
                  instructionTextSettingsScreen(
                      "Thinking of something we haven't thought of? Let us know and we’ll consider it during or next update release.",
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
                    "Enter App Feature",
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
                                context, "App Feature Suggestion Submitted")
                          },
                          "App Feature Suggestions");
                    }
                  }, "Submit")
                ]),
              ),
            ),
          )),
    );
  }
}

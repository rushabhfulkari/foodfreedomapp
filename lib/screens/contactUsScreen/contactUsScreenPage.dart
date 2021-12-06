import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/configs.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/services/sendDataToFirebaseFromSettingsPage.dart';
import 'package:foodfreedomapp/services/snackBar.dart';
import 'package:foodfreedomapp/services/userDetails.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
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
                  titleTextSettingsScreen("Contact Us", width),
                  SizedBox(
                    height: 10,
                  ),
                  instructionTextSettingsScreen(
                      "For customer support please email self-love@foodfreedomtapping.com or leave a message below.",
                      width),
                  SizedBox(
                    height: 10,
                  ),
                  textFormFieldWidgetSettingsPage(
                    height,
                    width,
                    context,
                    _textController,
                    "Write your message here",
                    "Enter Something",
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
                            showSnackBar(context, "Details Submitted")
                          },
                          "Contact Us");
                    }
                  }, "Submit")
                ]),
              ),
            ),
          )),
    );
  }
}

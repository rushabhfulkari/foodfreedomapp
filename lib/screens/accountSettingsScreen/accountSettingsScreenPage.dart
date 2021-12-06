import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/configs.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/screens/accountSettingsScreen/accountSettingsScreenWidgets.dart';
import 'package:foodfreedomapp/screens/accountSettingsScreen/accountSettingsServices.dart';
import 'package:foodfreedomapp/screens/resetPasswordScreen/resetPasswordScreenPage.dart';
import 'package:foodfreedomapp/services/snackBar.dart';
import 'package:foodfreedomapp/services/userDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountSettingsPage extends StatefulWidget {
  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  double height, width;

  final _formKey = new GlobalKey<FormState>();

  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  SharedPreferences prefs;

  DatabaseReference refFirebase = FirebaseDatabase.instance.reference();

  getSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    getSharedPref();
    _firstNameController.text = "$firstNameGlobal";
    _lastNameController.text = "$lastNameGlobal";
    _emailController.text = "$emailGlobal";
    _phoneNumberController.text = "$phoneNumberGlobal";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        appBar: appBarWithBackButton(context, "Account Settings", () {
          Navigator.pop(context);
        }),
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
          child: Form(
            key: _formKey,
            child: Column(children: [
              SizedBox(height: 20),
              textFormFieldWidgetAccountSettings(
                Icons.person_outline,
                "First Name",
                size,
                context,
                _firstNameController,
                _firstNameFocusNode,
                _lastNameFocusNode,
                "Enter First Name",
                false,
                false,
                "Enter First Name",
              ),
              SizedBox(height: 10),
              textFormFieldWidgetAccountSettings(
                Icons.person_outline,
                "Last Name",
                size,
                context,
                _lastNameController,
                _lastNameFocusNode,
                _emailFocusNode,
                "Enter Last Name",
                false,
                false,
                "Enter Last Name",
              ),
              SizedBox(height: 10),
              textFormFieldWidgetAccountSettings(
                Icons.email_outlined,
                "Email Address",
                size,
                context,
                _emailController,
                _emailFocusNode,
                _phoneNumberFocusNode,
                "Enter Email Address",
                false,
                false,
                "Enter Email Address",
              ),
              SizedBox(height: 10),
              textFormFieldWidgetAccountSettings(
                Icons.phone_outlined,
                "Phone Number",
                size,
                context,
                _phoneNumberController,
                _phoneNumberFocusNode,
                _phoneNumberFocusNode,
                "Enter Phone Number",
                true,
                true,
                "Enter Phone Number",
              ),
              SizedBox(
                height: defaultPadding * 3,
              ),
              // buttonRegular2(() {
              //   refFirebase
              //       .child('Users')
              //       .limitToFirst(2)
              //       .orderByChild('Info/firstName')
              //       .equalTo('RUSH')
              //       .once()
              //       .then((value) => print(value.value));
              // }, "Fetch"),
              buttonRegular2(() {
                if (_formKey.currentState.validate()) {
                  if (_firstNameController.text == firstNameGlobal &&
                      _lastNameController.text == lastNameGlobal &&
                      _emailController.text == emailGlobal &&
                      _phoneNumberController.text == phoneNumberGlobal) {
                    showSnackBar(context, "No Changes");
                  } else {
                    accountSettingFirebaseUpdate(
                        _firstNameController.text,
                        _lastNameController.text,
                        _emailController.text,
                        _phoneNumberController.text,
                        refFirebase,
                        context,
                        prefs);
                  }
                }
              }, "Update"),
              SizedBox(
                height: defaultPadding,
              ),
              buttonRegular3(
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ResetPasswordPage(emailSent: emailGlobal),
                    ),
                  );
                },
                "Reset Password",
              )
            ]),
          ),
        ));
  }
}

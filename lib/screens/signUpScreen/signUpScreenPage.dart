import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/configs.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/screens/navigationBar/navigationBar.dart';
import 'package:foodfreedomapp/screens/signUpScreen/signUpScreenServices.dart';
import 'package:foodfreedomapp/screens/signUpScreen/signUpScreenWidgets.dart';
import 'package:foodfreedomapp/services/facebookServices.dart';
import 'package:foodfreedomapp/services/googleServices.dart';
import 'package:foodfreedomapp/services/snackBar.dart';
import 'package:foodfreedomapp/services/userDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = new GlobalKey<FormState>();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool isSwitched = false;
  DatabaseReference refFirebase = FirebaseDatabase.instance.reference();
  SharedPreferences prefs;

  _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  getSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  bool isLoggedIn = false;

  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[orangeDesaturated, blueVeryDark],
              ),
            ),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding * 0.5),
                child: Column(children: [
                  backButton(() {
                    Navigator.pop(context);
                  }),
                  signUpText(),
                  signUpTextInstructions(),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  buildFormWidget(
                      size,
                      _formKey,
                      context,
                      _firstNameController,
                      _lastNameController,
                      _phoneNumberController,
                      _emailController,
                      _passwordController,
                      _firstNameFocusNode,
                      _lastNameFocusNode,
                      _phoneNumberFocusNode,
                      _emailFocusNode,
                      _passwordFocusNode, () {
                    _toggle();
                  }, _obscureText),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width * 0.87,
                        child: RichText(
                          text: TextSpan(
                            children: const <TextSpan>[
                              TextSpan(
                                  text: 'Password requires minimum ',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 14,
                                    fontFamily: 'Raleway',
                                  )),
                              TextSpan(
                                  text:
                                      '1 Uppercase, 1 Lowercase, 1 Numeric Number & 1 Special Character ( ! @ # \$ & * ~ )',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      fontFamily: 'Raleway',
                                      color: slightlyDesaturatedBlue)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width * 0.7,
                        child: RichText(
                          text: TextSpan(
                            children: const <TextSpan>[
                              TextSpan(
                                  text: 'I have read and understand the ',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 14,
                                    fontFamily: 'Raleway',
                                  )),
                              TextSpan(
                                  text: 'terms of use ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      fontFamily: 'Raleway',
                                      color: slightlyDesaturatedBlue)),
                              TextSpan(
                                  text: 'and ',
                                  style: TextStyle(
                                    color: white,
                                    fontFamily: 'Raleway',
                                    fontSize: 14,
                                  )),
                              TextSpan(
                                  text: 'privacy policy',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Raleway',
                                      fontSize: 14,
                                      color: slightlyDesaturatedBlue)),
                            ],
                          ),
                        ),
                      ),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                        activeTrackColor: blueSoft,
                        activeColor: blueDark,
                        inactiveThumbColor: white,
                        inactiveTrackColor: grey2,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: defaultPadding * 2,
                  ),
                  buttonRegular(() {
                    if (_formKey.currentState.validate()) {
                      if (isSwitched) {
                        buildCPI(context);
                        refFirebase
                            .child('Users')
                            .limitToFirst(1)
                            .orderByChild('Info/email')
                            .equalTo('${_emailController.text}')
                            .once()
                            .then((DataSnapshot snapshot) {
                          Map<dynamic, dynamic> userValues = snapshot.value;
                          if (userValues != null) {
                            userValues.forEach((key, values) {
                              if (values['Info']['email'] ==
                                  _emailController.text) {
                                Navigator.pop(context);
                                showSnackBar(context,
                                    "Account already exist with this Email");
                              }
                            });
                          } else {
                            String newkey =
                                refFirebase.child('Users').push().key;
                            signUpDataSettingFirebase(
                                _firstNameController.text,
                                _lastNameController.text,
                                _emailController.text,
                                _phoneNumberController.text,
                                _passwordController.text,
                                refFirebase,
                                context,
                                'Normal',
                                {
                                  prefs.setStringList('userDetails', [
                                    _firstNameController.text.toString(),
                                    _lastNameController.text.toString(),
                                    _emailController.text.toString(),
                                    _phoneNumberController.text.toString(),
                                    newkey.toString()
                                  ]),
                                  firstNameGlobal =
                                      _firstNameController.text.toString(),
                                  lastNameGlobal =
                                      _lastNameController.text.toString(),
                                  emailGlobal =
                                      _emailController.text.toString(),
                                  phoneNumberGlobal =
                                      _phoneNumberController.text.toString(),
                                  keyGlobal = newkey.toString(),
                                  prefs.setBool('loggedIn', true),
                                  prefs.setString('logInMethod', 'Normal'),
                                  _firstNameFocusNode.unfocus(),
                                  _lastNameFocusNode.unfocus(),
                                  _phoneNumberFocusNode.unfocus(),
                                  _emailFocusNode.unfocus(),
                                  _passwordFocusNode.unfocus(),
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => NavigationBar(),
                                    ),
                                  ),
                                  showSnackBar(context, "Signed Up"),
                                },
                                "$newkey");
                          }
                        });
                      } else {
                        showSnackBar(context,
                            "Please Agree to Privacy Policy and Terms of Use");
                      }
                    }
                  }, "Sign Up"),
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding * 0.7),
                    child: Text(
                      "or connect using",
                      style: TextStyle(color: white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding * 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          child: MaterialButton(
                            onPressed: () async {
                              if (isSwitched) {
                                buildCPI(context);

                                User user =
                                    await Authentication.signInWithGoogle(
                                        context: context);
                                if (user != null) {
                                  refFirebase
                                      .child('Users')
                                      .limitToFirst(1)
                                      .orderByChild('Info/email')
                                      .equalTo('${user.email.toString()}')
                                      .once()
                                      .then((DataSnapshot snapshot) {
                                    Map<dynamic, dynamic> userValues =
                                        snapshot.value;
                                    if (userValues != null) {
                                      Navigator.pop(context);
                                      showSnackBar(context,
                                          "Account already exist with this Email");
                                    } else {
                                      String newkey =
                                          refFirebase.child('Users').push().key;
                                      signUpDataSettingFirebase(
                                          user.displayName.toString(),
                                          '',
                                          user.email.toString(),
                                          user.phoneNumber.toString() != "null"
                                              ? user.phoneNumber.toString()
                                              : "",
                                          '',
                                          refFirebase,
                                          context,
                                          'Google',
                                          {
                                            prefs.setStringList('userDetails', [
                                              user.displayName.toString(),
                                              '',
                                              user.email.toString(),
                                              user.phoneNumber.toString() !=
                                                      "null"
                                                  ? user.phoneNumber.toString()
                                                  : '',
                                              newkey.toString()
                                            ]),
                                            firstNameGlobal =
                                                user.displayName.toString(),
                                            lastNameGlobal = '',
                                            emailGlobal = user.email.toString(),
                                            phoneNumberGlobal = user.phoneNumber
                                                        .toString() !=
                                                    "null"
                                                ? user.phoneNumber.toString()
                                                : '',
                                            keyGlobal = newkey.toString(),
                                            prefs.setBool('loggedIn', true),
                                            prefs.setString(
                                                'logInMethod', 'Google'),
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    NavigationBar(),
                                              ),
                                            ),
                                            showSnackBar(context,
                                                "Signed Up with Google")
                                          },
                                          "$newkey");
                                    }
                                  });
                                } else {
                                  Navigator.pop(context);
                                  showSnackBar(context,
                                      "Encountered an error, Try Again");
                                }
                              } else {
                                showSnackBar(context,
                                    "Please Agree to Privacy Policy and Terms of Use");
                              }
                            },
                            color: white,
                            child: Image.asset("assets/google.png"),
                            padding: EdgeInsets.all(2),
                            shape: CircleBorder(),
                          ),
                        ),
                        SizedBox(
                          width: defaultPadding * 0.5,
                        ),
                        Container(
                          height: 35,
                          width: 35,
                          child: MaterialButton(
                            onPressed: () {
                              if (isSwitched) {
                                signInWithFacebook(context, true, refFirebase);
                              } else {
                                showSnackBar(context,
                                    "Please Agree to Privacy Policy and Terms of Use");
                              }
                            },
                            color: facebookBlue,
                            child: Image.asset("assets/facebook.png"),
                            padding: EdgeInsets.all(2),
                            shape: CircleBorder(),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ),
          ),
        ));
  }
}

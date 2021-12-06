import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/configs.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/screens/forgotPasswordScreen/forgotPasswordScreenPage.dart';
import 'package:foodfreedomapp/screens/homeScreen/homeScreenPage.dart';
import 'package:foodfreedomapp/screens/logInScreen/logInScreenWidgets.dart';
import 'package:foodfreedomapp/screens/navigationBar/navigationBar.dart';
import 'package:foodfreedomapp/screens/secureLogInScreen/secureLogInScreenPage.dart';
import 'package:foodfreedomapp/screens/signUpScreen/signUpScreenServices.dart';
import 'package:foodfreedomapp/services/facebookServices.dart';
import 'package:foodfreedomapp/services/googleServices.dart';
import 'package:foodfreedomapp/services/snackBar.dart';
import 'package:foodfreedomapp/services/userDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _formKey = new GlobalKey<FormState>();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  DatabaseReference refFirebase = FirebaseDatabase.instance.reference();
  bool _obscureText = true;
  SharedPreferences prefs;

  _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  getSharedPref() async {
    prefs = await SharedPreferences.getInstance();
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
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding * 0.5),
              child: Column(children: [
                backButton(() {
                  Navigator.pop(context);
                }),
                logInText(),
                logInInstructions(),
                SizedBox(
                  height: defaultPadding * 2.5,
                ),
                buildFormWidget(
                    size,
                    _formKey,
                    context,
                    _emailController,
                    _passwordController,
                    _emailFocusNode,
                    _passwordFocusNode, () {
                  _toggle();
                }, _obscureText),
                SizedBox(
                  height: defaultPadding * 2,
                ),
                buttonRegular(() async {
                  if (_formKey.currentState.validate()) {
                    buildCPI(context);
                    refFirebase
                        .child('Users')
                        .limitToFirst(1)
                        .orderByChild('Info/email')
                        .equalTo('${_emailController.text}')
                        .once()
                        .then((DataSnapshot snapshot) {
                      Map<dynamic, dynamic> userValues = snapshot.value;
                      bool emailAndPasswordVerified = false;
                      if (userValues != null) {
                        userValues.forEach((key, values) {
                          if (values['Info']['email'] ==
                                  _emailController.text &&
                              values['Info']['password'] ==
                                  _passwordController.text) {
                            emailAndPasswordVerified = true;

                            prefs.setStringList('userDetails', [
                              '${values['Info']['firstName']}',
                              '${values['Info']['lastName']}',
                              '${values['Info']['email']}',
                              '${values['Info']['phoneNumber']}',
                              '$key',
                            ]);

                            firstNameGlobal = '${values['Info']['firstName']}';
                            lastNameGlobal = '${values['Info']['lastName']}';
                            emailGlobal = '${values['Info']['email']}';
                            phoneNumberGlobal =
                                '${values['Info']['phoneNumber']}';
                            keyGlobal = '$key';
                          }
                        });
                        if (emailAndPasswordVerified) {
                          Navigator.pop(context);
                          showSnackBar(context, "Logged In");
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => NavigationBar(),
                            ),
                          );
                          prefs.setBool('loggedIn', true);
                          prefs.setString('logInMethod', 'Normal');
                        } else {
                          Navigator.pop(context);
                          showSnackBar(context, "Invalid Email or Password");
                        }
                      } else {
                        Navigator.pop(context);
                        showSnackBar(context, "Invalid Email or Password");
                      }
                    });
                  }
                }, "Log In"),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding * 0.7),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Forgot your password ?",
                      style: TextStyle(color: white),
                    ),
                  ),
                ),
                SizedBox(
                  height: defaultPadding * 2,
                ),
                buttonRegular(() {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => SecureLogInPage(),
                    ),
                  );
                }, "Secure Login"),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding * 0.7),
                  child: Text(
                    "or connect using",
                    style: TextStyle(color: white),
                  ),
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      child: MaterialButton(
                        onPressed: () async {
                          buildCPI(context);

                          User user = await Authentication.signInWithGoogle(
                              context: context);
                          if (user != null) {
                            refFirebase
                                .child('Users')
                                .limitToFirst(1)
                                .orderByChild('Info/email')
                                .equalTo('${user.email.toString()}')
                                .once()
                                .then((DataSnapshot snapshot) {
                              Map<dynamic, dynamic> userValues = snapshot.value;
                              if (userValues != null) {
                                userValues.forEach((key, value) {
                                  prefs.setStringList('userDetails', [
                                    user.displayName.toString(),
                                    '',
                                    user.email.toString(),
                                    user.phoneNumber.toString() != "null"
                                        ? user.phoneNumber.toString()
                                        : '',
                                    key.toString()
                                  ]);
                                  firstNameGlobal = user.displayName.toString();
                                  lastNameGlobal = '';
                                  emailGlobal = user.email.toString();
                                  phoneNumberGlobal =
                                      user.phoneNumber.toString() != "null"
                                          ? user.phoneNumber.toString()
                                          : '';
                                  keyGlobal = key.toString();
                                });

                                Navigator.pop(context);
                                prefs.setBool('loggedIn', true);
                                prefs.setString('logInMethod', 'Google');
                                showSnackBar(context, "Logged In with Google");
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => NavigationBar(),
                                  ),
                                );
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
                                        user.phoneNumber.toString() != "null"
                                            ? user.phoneNumber.toString()
                                            : '',
                                        newkey.toString()
                                      ]),
                                      firstNameGlobal =
                                          user.displayName.toString(),
                                      lastNameGlobal = '',
                                      emailGlobal = user.email.toString(),
                                      phoneNumberGlobal =
                                          user.phoneNumber.toString() != "null"
                                              ? user.phoneNumber.toString()
                                              : '',
                                      keyGlobal = newkey.toString(),
                                      prefs.setBool('loggedIn', true),
                                      prefs.setString('logInMethod', 'Google'),
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => NavigationBar(),
                                        ),
                                      ),
                                      showSnackBar(
                                          context, "Logged In with Google")
                                    },
                                    "$newkey");
                              }
                            });
                          } else {
                            Navigator.pop(context);
                            showSnackBar(
                                context, "Encountered an error, Try Again");
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
                          signInWithFacebook(context, false, refFirebase);
                        },
                        color: facebookBlue,
                        child: Image.asset("assets/facebook.png"),
                        padding: EdgeInsets.all(2),
                        shape: CircleBorder(),
                      ),
                    ),
                  ],
                )
              ]),
            ),
          ),
        ));
  }
}

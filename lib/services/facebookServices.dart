import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:foodfreedomapp/screens/navigationBar/navigationBar.dart';
import 'package:foodfreedomapp/screens/signUpScreen/signUpScreenServices.dart';
import 'package:foodfreedomapp/services/snackBar.dart';
import 'package:foodfreedomapp/services/userDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Resource> signInWithFacebook(context, signUp, refFirebase) async {
  SharedPreferences prefs;
  prefs = await SharedPreferences.getInstance();
  try {
    final LoginResult result = await FacebookAuth.instance.login();
    switch (result.status) {
      case LoginStatus.success:
        final AuthCredential facebookCredential =
            FacebookAuthProvider.credential(result.accessToken.token);
        // ignore: unused_local_variable
        final userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookCredential);

        refFirebase
            .child('Users')
            .limitToFirst(1)
            .orderByChild('Info/email')
            .equalTo(
                userCredential.additionalUserInfo.profile['email'].toString())
            .once()
            .then((DataSnapshot snapshot) {
          Map<dynamic, dynamic> userValues = snapshot.value;
          if (userValues != null) {
            userValues.forEach((key, values) {
              if (values['Info']['email'] ==
                  userCredential.additionalUserInfo.profile['email']
                      .toString()) {
                if (signUp) {
                  showSnackBar(
                      context, "Account already exist with this Email");
                } else {
                  showSnackBar(
                      context,
                      signUp
                          ? "Signed Up with Facebook"
                          : "Logged In with Facebook");
                  prefs.setString('logInMethod', 'Facebook');

                  prefs.setStringList('userDetails', [
                    userCredential.additionalUserInfo.profile['first_name']
                                .toString() !=
                            "null"
                        ? userCredential
                            .additionalUserInfo.profile['first_name']
                            .toString()
                        : "",
                    '',
                    userCredential.additionalUserInfo.profile['last_name']
                                .toString() !=
                            "null"
                        ? userCredential.additionalUserInfo.profile['last_name']
                            .toString()
                        : "",
                    userCredential.additionalUserInfo.profile['email']
                                .toString() !=
                            "null"
                        ? userCredential.additionalUserInfo.profile['email']
                            .toString()
                        : "",
                    userCredential.user.phoneNumber.toString() != "null"
                        ? userCredential.user.phoneNumber.toString()
                        : "",
                    key.toString()
                  ]);

                  firstNameGlobal = userCredential
                              .additionalUserInfo.profile['first_name']
                              .toString() !=
                          "null"
                      ? userCredential.additionalUserInfo.profile['first_name']
                          .toString()
                      : "";
                  lastNameGlobal = userCredential
                              .additionalUserInfo.profile['last_name']
                              .toString() !=
                          "null"
                      ? userCredential.additionalUserInfo.profile['last_name']
                          .toString()
                      : "";
                  emailGlobal = userCredential
                              .additionalUserInfo.profile['email']
                              .toString() !=
                          "null"
                      ? userCredential.additionalUserInfo.profile['email']
                          .toString()
                      : "";
                  phoneNumberGlobal =
                      userCredential.user.phoneNumber.toString() != "null"
                          ? userCredential.user.phoneNumber.toString()
                          : "";
                  keyGlobal = key.toString();

                  prefs.setBool('loggedIn', true);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => NavigationBar(),
                    ),
                  );
                }
              }
            });
          } else {
            String newkey = refFirebase.child('Users').push().key;
            userValues.forEach((key, value) {
              signUpDataSettingFirebase(
                  userCredential.additionalUserInfo.profile['first_name']
                              .toString() !=
                          "null"
                      ? userCredential.additionalUserInfo.profile['first_name']
                              .toString() !=
                          "null"
                      : "",
                  userCredential.additionalUserInfo.profile['last_name']
                              .toString() !=
                          "null"
                      ? userCredential.additionalUserInfo.profile['last_name']
                              .toString() !=
                          "null"
                      : "",
                  userCredential.additionalUserInfo.profile['email']
                              .toString() !=
                          "null"
                      ? userCredential.additionalUserInfo.profile['email']
                          .toString()
                      : "",
                  userCredential.user.phoneNumber.toString() != "null"
                      ? userCredential.user.phoneNumber.toString()
                      : "",
                  '',
                  refFirebase,
                  context,
                  'Facebook',
                  {
                    prefs.setString('logInMethod', 'Facebook'),
                    prefs.setStringList('userDetails', [
                      userCredential.additionalUserInfo.profile['first_name']
                                  .toString() !=
                              "null"
                          ? userCredential
                              .additionalUserInfo.profile['first_name']
                              .toString()
                          : "",
                      '',
                      userCredential.additionalUserInfo.profile['last_name']
                                  .toString() !=
                              "null"
                          ? userCredential
                              .additionalUserInfo.profile['last_name']
                              .toString()
                          : "",
                      userCredential.additionalUserInfo.profile['email']
                                  .toString() !=
                              "null"
                          ? userCredential.additionalUserInfo.profile['email']
                              .toString()
                          : "",
                      userCredential.user.phoneNumber.toString() != "null"
                          ? userCredential.user.phoneNumber.toString()
                          : "",
                      key.toString()
                    ]),
                    firstNameGlobal = userCredential
                                .additionalUserInfo.profile['first_name']
                                .toString() !=
                            "null"
                        ? userCredential
                            .additionalUserInfo.profile['first_name']
                            .toString()
                        : "",
                    lastNameGlobal = userCredential
                                .additionalUserInfo.profile['last_name']
                                .toString() !=
                            "null"
                        ? userCredential.additionalUserInfo.profile['last_name']
                            .toString()
                        : "",
                    emailGlobal = userCredential
                                .additionalUserInfo.profile['email']
                                .toString() !=
                            "null"
                        ? userCredential.additionalUserInfo.profile['email']
                            .toString()
                        : "",
                    phoneNumberGlobal =
                        userCredential.user.phoneNumber.toString() != "null"
                            ? userCredential.user.phoneNumber.toString()
                            : "",
                    keyGlobal = key.toString(),
                    prefs.setBool('loggedIn', true),
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => NavigationBar(),
                      ),
                    ),
                    showSnackBar(
                        context,
                        signUp
                            ? "Signed Up with Facebook"
                            : "Logged In with Facebook"),
                  },
                  "$newkey");
            });
          }
        });

        return Resource(status: Status.Success);
      case LoginStatus.cancelled:
        showSnackBar(context, "Encountered an error, Try Again");
        return Resource(status: Status.Cancelled);

      case LoginStatus.failed:
        showSnackBar(context, "Encountered an error, Try Again");
        return Resource(status: Status.Error);
      default:
        return null;
    }
  } on FirebaseAuthException catch (e) {
    showSnackBar(context, "Encountered an error, Try Again");
    throw e;
  }
}

class Resource {
  final Status status;
  Resource({this.status});
}

enum Status { Success, Error, Cancelled }

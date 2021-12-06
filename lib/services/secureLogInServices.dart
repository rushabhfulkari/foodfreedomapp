import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/screens/introScreen/introScreenPage.dart';
import 'package:foodfreedomapp/screens/navigationBar/navigationBar.dart';
import 'package:foodfreedomapp/screens/signUpScreen/signUpScreenServices.dart';
import 'package:foodfreedomapp/services/snackBar.dart';
import 'package:foodfreedomapp/services/userDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  signOut(BuildContext context) async {
    FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', false);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => IntroScreen()));
  }

  signIn(AuthCredential authCreds, String phone, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(authCreds);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      DatabaseReference refFirebase = FirebaseDatabase.instance.reference();
      refFirebase
          .child('Users')
          .limitToFirst(1)
          .orderByChild('Info/phoneNumber')
          .equalTo('${phone.toString()}')
          .once()
          .then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> userValues = snapshot.value;
        if (userValues != null) {
          userValues.forEach((key, values) {
            if (values['Info']['phoneNumber'] == phone.toString()) {
              prefs.setStringList('userDetails', [
                '${values['Info']['firstName']}',
                '${values['Info']['lastName']}',
                '${values['Info']['email']}',
                '${values['Info']['phoneNumber']}',
                key.toString()
              ]);

              firstNameGlobal = '${values['Info']['firstName']}';
              lastNameGlobal = '${values['Info']['lastName']}';
              emailGlobal = '${values['Info']['email']}';
              phoneNumberGlobal = '${values['Info']['phoneNumber']}';
              keyGlobal = key.toString();
              Navigator.pop(context);
              prefs.setBool('loggedIn', true);

              prefs.setString('logInMethod', 'OTP');
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => NavigationBar(),
                ),
              );
              showSnackBar(context, "Securely Logged In");
            }
          });
        } else {
          String newkey = refFirebase.child('Users').push().key;
          signUpDataSettingFirebase(
              '',
              '',
              '',
              phone,
              '',
              refFirebase,
              context,
              'OTP',
              {
                refFirebase
                    .child('Users')
                    .child(newkey)
                    .once()
                    .then((DataSnapshot snapshot) {
                  Map<dynamic, dynamic> userValues = snapshot.value;
                  userValues.forEach((key, value) {
                    prefs.setStringList(
                        'userDetails', ['', '', '', '$phone', '$key']);
                    firstNameGlobal = '';
                    lastNameGlobal = '';
                    emailGlobal = '';
                    phoneNumberGlobal = '$phone';
                    keyGlobal = '$key';
                  });
                }),
                Navigator.pop(context),
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => NavigationBar())),
                prefs.setBool('loggedIn', true),
                prefs.setString('logInMethod', 'OTP'),
                showSnackBar(context, "Securely Logged In"),
              },
              "$newkey");
        }
      });
    } catch (e) {
      Navigator.pop(context);
      showSnackBar(context, "Invalid Verification Code");
    }
  }

  signInWithOTP(smsCode, verId, phone, context) {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    signIn(authCreds, phone, context);
  }
}

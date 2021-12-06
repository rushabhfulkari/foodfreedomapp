import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/services/snackBar.dart';
import 'package:foodfreedomapp/services/userDetails.dart';

accountSettingFirebaseUpdate(firstName, lastName, email, phoneNumber,
    refFirebase, context, prefs) async {
  try {
    buildCPI(context);
    refFirebase.child('Users').child('$keyGlobal').child('Info').update({
      'firstName': '$firstName',
      'lastName': '$lastName',
      'email': '$email',
      'phoneNumber': '$phoneNumber',
    }).then({
      Navigator.pop(context),
      showSnackBar(context, "Account Updated"),
      prefs.setStringList('userDetails', [
        '${firstName.toString()}',
        '${lastName.toString()}',
        '${email.toString()}',
        '${phoneNumber.toString()}',
        '${keyGlobal.toString()}',
      ]),
      firstNameGlobal = firstName.toString(),
      lastNameGlobal = lastName.toString(),
      emailGlobal = email.toString(),
      phoneNumberGlobal = phoneNumber.toString(),
      keyGlobal = keyGlobal.toString(),
    });
  } catch (e) {
    print(e.toString());
  }
}

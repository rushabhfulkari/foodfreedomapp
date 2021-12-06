signUpDataSettingFirebase(firstName, lastName, email, phoneNumber, password,
    refFirebase, context, signUpType, onComplition, key) async {
  refFirebase.child('Users').child('$key').child('Info').set({
    'firstName': '$firstName',
    'lastName': '$lastName',
    'email': '$email',
    'phoneNumber': '$phoneNumber',
    'password': '$password',
    'signUpType': '$signUpType'
  }).then(onComplition);
}

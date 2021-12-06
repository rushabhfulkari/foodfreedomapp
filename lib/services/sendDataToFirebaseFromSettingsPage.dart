sendDataToFirebaseFromSettingsPage(firstName, lastName, content, email,
    phoneNumber, refFirebase, context, onComplition, toWhichNode) async {
  refFirebase.child('$toWhichNode').push().set({
    'firstName': '$firstName',
    'lastName': '$lastName',
    'content': '$content',
    'email': '$email',
    'phoneNumber': '$phoneNumber',
    'dateTime': '${DateTime.now()}',
  }).then(onComplition);
}

import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/configs.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/screens/secureLogInScreen/secureLogInScreenWidget.dart';
import 'package:foodfreedomapp/services/secureLogInServices.dart';
import 'package:foodfreedomapp/services/snackBar.dart';

class SecureLogInPage extends StatefulWidget {
  @override
  _SecureLogInPageState createState() => _SecureLogInPageState();
}

class _SecureLogInPageState extends State<SecureLogInPage> {
  final _formKeyMobileNumber = new GlobalKey<FormState>();

  final FocusNode _mobileNumberFocusNode = FocusNode();

  String phoneNo, verificationId;

  TextEditingController _mobileNumberController = TextEditingController();

  PageController _pageController = PageController();

  String cc = "+1";
  String countryflagname = "us";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                secureLogInPage0(size, context),
                secureLogInPage1(size, context),
              ]),
        ));
  }

  Container secureLogInPage0(Size size, BuildContext context) {
    return Container(
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
          secureLogInText("Login with your\nMobile Number"),
          SizedBox(
            height: defaultPadding * 1.5,
          ),
          Form(
            key: _formKeyMobileNumber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      countryPicker(context),
                      Icon(
                        Icons.arrow_drop_down_sharp,
                        color: white,
                        size: 30,
                      ),
                    ],
                  ),
                ),
                textFormFieldWidgetSecureLogIn(
                  "Enter Mobile Number",
                  size,
                  context,
                  _mobileNumberController,
                  _mobileNumberFocusNode,
                  null,
                  "Phone Number",
                  true,
                  true,
                  "Enter Phone Number",
                ),
              ],
            ),
          ),
          SizedBox(
            height: defaultPadding * 4,
          ),
          buttonRegular(() {
            if (_formKeyMobileNumber.currentState.validate()) {
              buildCPI(context);
              verifyPhone("$cc" + "${_mobileNumberController.text}", context);
            } else {}
          }, "Continue"),
        ]),
      ),
    );
  }

  Container countryPicker(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      child: GestureDetector(
        onTap: () {
          showCountryPicker(
            context: context,
            exclude: <String>['KN', 'MF'],
            showPhoneCode: true,
            onSelect: (Country country) {
              setState(() {
                countryflagname = '${country.countryCode.toLowerCase()}';
                this.cc = "+" + "${country.phoneCode}";
              });
            },
            countryListTheme: CountryListThemeData(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0.0),
                topRight: Radius.circular(0.0),
              ),
              backgroundColor: blueSoft,
              inputDecoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Start typing to search',
                prefixIcon: const Icon(Icons.search_rounded),
              ),
            ),
          );
        },
        child: Image.asset('icons/flags/png/$countryflagname.png', errorBuilder:
            (BuildContext context, Object exception, StackTrace stackTrace) {
          return Container(
            child: Text(
              "$cc",
              style: TextStyle(color: white, fontSize: 25),
            ),
          );
        }, package: 'country_icons'),
      ),
    );
  }

  Container secureLogInPage1(Size size, BuildContext context) {
    return Container(
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
          secureLogInText("Security Code\nVerification"),
          SizedBox(
            height: defaultPadding * 3,
          ),
          secureLogInTextInstructions(),
          SizedBox(
            height: defaultPadding * 2.5,
          ),
          OtpTextField(
            onSubmit: (String pin) {
              buildCPI(context);
              AuthService().signInWithOTP(pin, verificationId,
                  "$cc" + "${_mobileNumberController.text}", context);
            },
            fields: 6,
          ),
          SizedBox(
            height: defaultPadding * 4,
          ),
          // buttonRegular(() {
          //   AuthService()
          //       .signInWithOTP(smsCode, verificationId, phoneNo, context);
          // }, "Continue"),
        ]),
      ),
    );
  }

  Future<void> verifyPhone(phoneNo, context) async {
    final PhoneVerificationCompleted verified =
        (AuthCredential authResult) async {
      AuthService().signIn(authResult, phoneNo, context);
    };
    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      Navigator.pop(context);
      showSnackBar(context, "Please Enter a Valid Phone Number");
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      Navigator.pop(context);
      _pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 30),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}

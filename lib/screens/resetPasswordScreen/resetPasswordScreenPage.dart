import 'package:email_auth/email_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/configs.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/screens/forgotPasswordScreen/forgotPasswordScreenWidgets.dart';
import 'package:foodfreedomapp/services/snackBar.dart';
import 'package:foodfreedomapp/services/userDetails.dart';

// ignore: must_be_immutable
class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({
    Key key,
    this.emailSent,
  }) : super(key: key);
  var emailSent;
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState(emailSent);
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  var emailSent;
  _ResetPasswordPageState(this.emailSent);
  final _formKeyChangePassword = new GlobalKey<FormState>();

  final FocusNode _newPasswordFocusNode = FocusNode();
  final FocusNode _reEnterNewPasswordFocusNode = FocusNode();

  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _reEnterNewPasswordController = TextEditingController();

  DatabaseReference refFirebase = FirebaseDatabase.instance.reference();

  EmailAuth emailAuth = new EmailAuth(sessionName: "Food Freedom App");

  PageController _pageController = PageController();

  bool _obscureText = true;

  bool validated = false;

  sendOtp() async {
    var res = await emailAuth.sendOtp(
      recipientMail: emailSent,
    );
    if (res) {
      _pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      Navigator.pop(context);
      showSnackBar(context, "Verification Code Sent");
    } else {
      Navigator.pop(context);
      showSnackBar(context, "Encountered an Error, Please try again");
    }
  }

  valitedPasscode(email, otp) {
    var res = emailAuth.validateOtp(recipientMail: email, userOtp: otp);
    if (res) {
      _pageController.animateToPage(
        2,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      Navigator.pop(context);
      showSnackBar(context, "Code Verified");
    } else {
      Navigator.pop(context);
      showSnackBar(context, "Invalid Code");
    }
  }

  _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    emailAuth.config({
      "server": "https://email-auth-bottlecap.herokuapp.com",
      "serverKey": "DOm9r0"
    });
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
                resetPasswordPage0(size, context),
                resetPasswordPage1(size, context),
                resetPasswordPage2(size, context),
              ]),
        ));
  }

  Container resetPasswordPage0(Size size, BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[vividCyan, darkCyan],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding * 0.5),
        child: Column(children: [
          backButton(() {
            Navigator.pop(context);
          }),
          forgotPasswordText("Reset\nPassword", size.width),
          SizedBox(
            height: defaultPadding * 3,
          ),
          forgotPasswordTextInstructions(
              size.width, "Please enter your registered email address"),
          forgotPasswordTextInstructions2(size.width,
              "We will send a verification code to your\nregistered email ID"),
          SizedBox(
            height: defaultPadding * 1.5,
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Container(
              height: size.height * 0.07,
              decoration: BoxDecoration(color: blackTextBox),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  autoSizeTextWidget(
                      "$emailSent", white, "Raleway", FontWeight.w400, 16.0),
                ],
              ),
            ),
          ),
          SizedBox(
            height: defaultPadding * 13,
          ),
          buttonRegular(() {
            buildCPI(context);
            sendOtp();
          }, "Next"),
        ]),
      ),
    );
  }

  Container resetPasswordPage1(Size size, BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[vividCyan, darkCyan],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding * 0.5),
        child: Column(children: [
          backButton(() {
            Navigator.pop(context);
          }),
          forgotPasswordText("Verification\nCode", size.width),
          SizedBox(
            height: defaultPadding * 3,
          ),
          forgotPasswordTextInstructions(
              size.width, "Please enter your verification code"),
          forgotPasswordTextInstructions2(size.width,
              "We have sent a verification code to your registered email address"),
          SizedBox(
            height: defaultPadding * 2,
          ),
          OtpTextField(
            onSubmit: (String pin) {
              buildCPI(context);
              valitedPasscode(emailSent, pin);
            },
            fields: 6,
          ),
        ]),
      ),
    );
  }

  Container resetPasswordPage2(Size size, BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
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
          key: _formKeyChangePassword,
          child: Column(children: [
            backButton(() {
              Navigator.pop(context);
            }),
            forgotPasswordText("Change\nPassword", size.width),
            SizedBox(
              height: defaultPadding * 3,
            ),
            forgotPasswordTextInstructions(
                size.width, "Please enter a new password"),
            SizedBox(
              height: defaultPadding * 1.5,
            ),
            passwordFieldForgotPassword("New Password", size, context,
                _newPasswordController, _newPasswordFocusNode, () {
              _toggle();
            }, _obscureText, "Enter new password", "New Password"),
            passwordFieldForgotPassword(
                "Re-enter New Password",
                size,
                context,
                _reEnterNewPasswordController,
                _reEnterNewPasswordFocusNode, () {
              _toggle();
            }, _obscureText, "Enter New password", "Re-Enter New password"),
            SizedBox(
              height: defaultPadding * 10,
            ),
            buttonRegular(() {
              if (_formKeyChangePassword.currentState.validate()) {
                if (_newPasswordController.text ==
                    _reEnterNewPasswordController.text) {
                  buildCPI(context);
                  refFirebase
                      .child('Users')
                      .child('$keyGlobal')
                      .child('Info')
                      .update({
                    'password': '${_newPasswordController.text}',
                  }).then((value) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    showSnackBar(context, "Password Changed");
                  });
                } else {
                  showSnackBar(context, "New Password doesn't Match");
                }
              }
            }, "Confirm"),
          ]),
        ),
      ),
    );
  }
}

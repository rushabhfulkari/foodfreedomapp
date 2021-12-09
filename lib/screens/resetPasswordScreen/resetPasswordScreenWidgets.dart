import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/configs.dart';
import 'package:foodfreedomapp/constants/styles.dart';
import 'package:foodfreedomapp/screens/forgotPasswordScreen/forgotPasswordScreenStyles.dart';
import 'package:foodfreedomapp/screens/logInScreen/logInScreenConfigs.dart';

Container forgotPasswordText(text, width) {
  return Container(
    width: width,
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10),
      child: Text(
        "$text",
        textAlign: TextAlign.left,
        style: forgotPasswordTextStyle,
      ),
    ),
  );
}

Container forgotPasswordTextInstructions(width, text) {
  return Container(
    width: width,
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10),
      child: Text(
        // "Please enter your registered email address",
        "$text",
        textAlign: TextAlign.left,
        style: forgotPasswordInstructionsStyle,
      ),
    ),
  );
}

Container forgotPasswordTextInstructions2(width, text) {
  return Container(
    width: width,
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10),
      child: Text(
        "$text",
        // "We will send a verification code to your\nregistered email ID",
        textAlign: TextAlign.left,
        style: forgotPasswordInstructionsStyle2,
      ),
    ),
  );
}

Widget emailFieldForgotPassword(
  size,
  context,
  emailController,
  emailFocusNode,
) {
  return Container(
    width: size.width * 0.95,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return "Enter Email";
              } else {
                if (!regex.hasMatch(value)) {
                  return "Enter Valid Email";
                } else {
                  return null;
                }
              }
            },
            controller: emailController,
            focusNode: emailFocusNode,
            scrollPadding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            keyboardType: TextInputType.text,
            cursorWidth: ((0.067 * size.height) / 100),
            cursorColor: Colors.grey,
            style: TextStyle(
              fontSize: ((2.032 * size.height) / 100),
              color: white,
            ),
            decoration: InputDecoration(
              disabledBorder: buildTextFieldOutlineInputBorder(size),
              focusedBorder: buildTextFieldOutlineInputBorder(size),
              errorBorder: buildTextFieldOutlineInputBorder(size),
              focusedErrorBorder: buildTextFieldOutlineInputBorder(size),
              border: buildTextFieldOutlineInputBorder(size),
              enabledBorder: buildTextFieldOutlineInputBorder(size),
              contentPadding: EdgeInsets.only(
                left: ((1.896 * size.height) / 100),
                right: ((1.896 * size.height) / 100),
              ),
              filled: true,
              fillColor: blackTextBox,
              hintText: "Enter Your Email",
              hintStyle: hintTextStyle,
            ),
            textInputAction: TextInputAction.next,
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
            },
          ),
        ],
      ),
    ),
  );
}

Widget passwordFieldForgotPassword(title, size, context, passwordController,
    passwordFocusNode, onPressed, obscureText, validatorText, hintText) {
  return Container(
    width: size.width * 0.95,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "$title",
                textAlign: TextAlign.start,
                style: textFieldTextStyle,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return "$validatorText";
              } else if (value.length < 8) {
                return "Password length should not be less than 8";
              } else {
                if (!regexPassword.hasMatch(value)) {
                  return "Minimum 1 Uppercase, 1 Numeric Number & 1 Special Character required";
                } else {
                  return null;
                }
              }
            },
            controller: passwordController,
            focusNode: passwordFocusNode,
            obscureText: obscureText,
            scrollPadding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            keyboardType: TextInputType.text,
            cursorWidth: ((0.067 * size.height) / 100),
            cursorColor: Colors.grey,
            style: TextStyle(
              fontSize: ((2.032 * size.height) / 100),
              color: white,
            ),
            decoration: InputDecoration(
              disabledBorder: buildTextFieldOutlineInputBorder(size),
              focusedBorder: buildTextFieldOutlineInputBorder(size),
              errorBorder: buildTextFieldOutlineInputBorder(size),
              focusedErrorBorder: buildTextFieldOutlineInputBorder(size),
              border: buildTextFieldOutlineInputBorder(size),
              enabledBorder: buildTextFieldOutlineInputBorder(size),
              suffixIcon: IconButton(
                onPressed: onPressed,
                // splashColor: c2,
                splashRadius: 1,
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: grey2,
                  size: ((2.980 * size.height) / 100),
                ),
              ),
              contentPadding: EdgeInsets.only(
                left: ((1.896 * size.height) / 100),
                right: ((1.896 * size.height) / 100),
              ),
              filled: true,
              fillColor: blackTextBox,
              hintText: "$hintText",
              hintStyle: hintTextStyle,
            ),
            textInputAction: TextInputAction.next,
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
            },
          ),
        ],
      ),
    ),
  );
}

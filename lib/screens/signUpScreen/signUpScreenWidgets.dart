import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/configs.dart';
import 'package:foodfreedomapp/constants/styles.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/screens/logInScreen/logInScreenConfigs.dart';
import 'package:foodfreedomapp/screens/signUpScreen/signUpScreenStyles.dart';

Text signUpText() {
  return Text(
    "Let's Get Started",
    style: signUpTitleTextStyle,
  );
}

Text signUpTextInstructions() {
  return Text(
    "Create an account with us",
    style: signUpInstructionsTextStyle,
  );
}

Widget emailField(
  size,
  context,
  emailController,
  emailFocusNode,
  nextFocusNode,
) {
  return Container(
    width: size.width * 0.9,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Email",
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
              hintText: "Email",
              hintStyle: hintTextStyle,
            ),
            textInputAction: TextInputAction.next,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(nextFocusNode);
            },
          ),
        ],
      ),
    ),
  );
}

Widget passwordField(size, context, passwordController, passwordFocusNode,
    onPressed, obscureText) {
  return Container(
    width: size.width * 0.9,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Password",
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
                return "Enter Password";
              } else if (value.length < 8) {
                return "Password length should not be less than 8";
              } else {
                return null;
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
              hintText: "Password",
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

Widget buildFormWidget(
    Size size,
    formKey,
    context,
    firstNameController,
    lastNameController,
    phoneNumberController,
    emailController,
    passwordController,
    firstNameFocusNode,
    lastNameFocusNode,
    phoneNumberFocusNode,
    emailFocusNode,
    passwordFocusNode,
    onPressed,
    obscureText) {
  return Form(
    key: formKey,
    child: Column(
      children: [
        Container(
          width: size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: textFormFieldWidget(
                  "First Name",
                  size,
                  context,
                  firstNameController,
                  firstNameFocusNode,
                  lastNameFocusNode,
                  "First Name",
                  false,
                  false,
                  "Enter First Name",
                ),
              ),
              Expanded(
                child: textFormFieldWidget(
                  "Last Name",
                  size,
                  context,
                  lastNameController,
                  lastNameFocusNode,
                  lastNameFocusNode,
                  "Last Name",
                  false,
                  false,
                  "Enter Last Name",
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: defaultPadding * 1,
        ),
        emailField(
          size,
          context,
          emailController,
          emailFocusNode,
          phoneNumberFocusNode,
        ),
        SizedBox(
          height: defaultPadding * 1,
        ),
        textFormFieldWidget(
          "Phone Number",
          size,
          context,
          phoneNumberController,
          phoneNumberFocusNode,
          passwordFocusNode,
          "Phone Number",
          false,
          true,
          "Enter Phone Number",
        ),
        SizedBox(
          height: defaultPadding * 1,
        ),
        passwordField(size, context, passwordController, passwordFocusNode,
            onPressed, obscureText),
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/configs.dart';
import 'package:foodfreedomapp/constants/styles.dart';
import 'package:foodfreedomapp/screens/secureLogInScreen/secureLogInScreenStyles.dart';

Text secureLogInText(text) {
  return Text(
    "$text",
    textAlign: TextAlign.center,
    style: secureLogInTextStyle,
  );
}

Text secureLogInTextInstructions() {
  return Text(
    "Enter the one-time security code\nyou received via text.",
    textAlign: TextAlign.center,
    style: secureLogInInstructionsStyle,
  );
}

Widget textFormFieldWidgetSecureLogIn(
  labelText,
  size,
  context,
  controller,
  focusNode,
  nextFocusNode,
  hintText,
  unFocus,
  keyboardNumberType,
  validatorText,
) {
  return Container(
    width: size.width * 0.7,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "$labelText",
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
                return "Enter Valid Phone Number";
              } else {
                return null;
              }
            },
            controller: controller,
            focusNode: focusNode,
            scrollPadding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            keyboardType:
                keyboardNumberType ? TextInputType.number : TextInputType.text,
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
                bottom: ((1.896 * size.height) / 100),
              ),
              filled: true,
              fillColor: blackTextBox,
              hintText: "$hintText",
              hintStyle: hintTextStyle,
            ),
            textInputAction: TextInputAction.next,
            onEditingComplete: () {
              if (unFocus) {
                FocusScope.of(context).unfocus();
              } else {
                FocusScope.of(context).requestFocus(nextFocusNode);
              }
            },
          ),
        ],
      ),
    ),
  );
}

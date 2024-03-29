import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'body.dart';

Widget loginSignUpSelect(Function callSetState) {
  return Row(
    children: [
      Column(
        children: [
          TextButton(
            onPressed: () {
              callSetState(() {
                SignUpBody.signup = false;
              });
            },
            child: Text(
              "Login",
              style: TextStyle(
                color: SignUpBody.signup == false ? kPrimaryColor : kTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => kPrimaryColor.withOpacity(.3)),
            ),
          ),
          Container(
            height: 2,
            width: 75,
            color:
                SignUpBody.signup == false ? kPrimaryColor : Colors.transparent,
          )
        ],
      ),
      const SizedBox(
        width: 10,
      ),
      Column(
        children: [
          TextButton(
            onPressed: () {
              callSetState(() {
                SignUpBody.signup = true;
              });
            },
            style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => kPrimaryColor.withOpacity(.3)),
            ),
            child: Text(
              "SignUp",
              style: TextStyle(
                color: SignUpBody.signup == true ? kPrimaryColor : kTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            height: 2,
            width: 80,
            color:
                SignUpBody.signup == true ? kPrimaryColor : Colors.transparent,
          )
        ],
      ),
    ],
  );
}

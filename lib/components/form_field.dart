import 'package:flutter/material.dart';

import '../constants.dart';

Widget formField(
    TextEditingController controller, String label, TextInputType type) {
  return TextFormField(
    style: const TextStyle(fontSize: 18),
    cursorColor: kPrimaryColor,
    keyboardType: type,
    controller: controller,
    decoration: InputDecoration(
      focusColor: kPrimaryColor,
      labelText: label,
      labelStyle: const TextStyle(fontSize: 16, color: kPrimaryColor),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(width: 2.5, color: kTextColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(width: 2.5, color: kPrimaryColor),
      ),
    ),
  );
}

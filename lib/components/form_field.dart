import 'package:flutter/material.dart';

import '../constants.dart';

Widget formField(TextEditingController controller, String label,
    TextInputType type, String? Function(String? value) validator) {
  return TextFormField(
    style: const TextStyle(fontSize: 16),
    validator: (value) => validator(value),
    cursorColor: kPrimaryColor,
    keyboardType: type,
    controller: controller,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      focusColor: kPrimaryColor,
      labelText: label,
      labelStyle: const TextStyle(fontSize: 15, color: kPrimaryColor),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(width: 2.5, color: kTextColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(width: 2.5, color: kPrimaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(width: 2.5, color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(width: 2.5, color: kPrimaryColor),
      ),
    ),
  );
}

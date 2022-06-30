import 'package:flutter/material.dart';

import '../../../constants.dart';

class TextInputField extends StatefulWidget {
  TextInputField(
      {Key? key,
      this.isPass = false,
      required this.textInputType,
      required this.textEditingController,
      required this.label,
      required this.validator})
      : super(key: key);
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final String label;
  final String? Function(String? value) validator;
  bool isPass;
  @override
  State<TextInputField> createState() => TextInputFieldState(isPass);
}

class TextInputFieldState extends State<TextInputField> {
  final bool isPressed;
  TextInputFieldState(this.isPressed);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPass,
      style: const TextStyle(fontSize: 18),
      keyboardType: widget.textInputType,
      controller: widget.textEditingController,
      cursorColor: kPrimaryColor,
      validator: widget.validator,
      decoration: InputDecoration(
        suffixIcon: isPressed
            ? IconButton(
                icon: widget.isPass
                    ? const Icon(Icons.remove_red_eye_sharp)
                    : const Icon(Icons.remove_red_eye_outlined),
                onPressed: () {
                  setState(() {
                    widget.isPass = !widget.isPass;
                  });
                },
                color: kPrimaryColor,
              )
            : const SizedBox.shrink(),
        contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
        label: Text(
          widget.label,
        ),
        labelStyle: const TextStyle(fontSize: 18, color: Colors.black87),
        filled: true,
        fillColor: const Color(0xffe1e1e1),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(width: 2, color: kPrimaryColor)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(width: 2, color: kPrimaryColor)),
      ),
    );
  }
}

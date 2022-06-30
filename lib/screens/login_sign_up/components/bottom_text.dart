import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

Widget bottomText() {
  return Center(
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: "By submitting you are agreeing to\n",
          style:
              const TextStyle(fontSize: 14, color: Colors.black, height: 1.2),
          children: [
            TextSpan(
                text: "terms and conditions",
                recognizer: TapGestureRecognizer()
                  ..onTap = () => const Text('Term and condition'),
                style: const TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.bold)),
            const TextSpan(text: " & "),
            TextSpan(
                text: "privacy policy",
                recognizer: TapGestureRecognizer()
                  ..onTap = () => const Text('privacy policy'),
                style: const TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.bold))
          ]),
    ),
  );
}

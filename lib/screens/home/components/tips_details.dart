import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/models/tips_model.dart';

import '../../../constants.dart';

Future tipsDetails(BuildContext context, Tip tip) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
              child: Text(tip.title, style: TextStyle(color: kPrimaryColor))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(tip.imgPath),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 2,
                color: kPrimaryColor,
              ),
              Center(child: Text(tip.description)),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("Ok"),
            ),
          ],
        );
      });
}

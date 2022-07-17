import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/authentication/form_validation.dart';
import 'package:plant_watch/controllers/user_controller.dart';
import 'package:plant_watch/models/user_model.dart';

import '../../../components/form_field.dart';
import '../../../constants.dart';

Future editProfile(BuildContext context, UserCustom user) {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  UploadProfile uploadProfile = UploadProfile();
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      scrollable: true,
      contentPadding:
          const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            formField(name, "Name", TextInputType.name,
                (value) => profileNameValidator(value)),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              ),
              onPressed: () {
                uploadProfile.showPicker(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    uploadProfile.fileName == null
                        ? "Select Image"
                        : "File Selected",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(primary: kPrimaryColor),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel')),
        ElevatedButton(
            style: ElevatedButton.styleFrom(primary: kPrimaryColor),
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                await uploadProfile.edit(
                  name: name.text,
                  context: context,
                );
                await FirebaseAuth.instance.currentUser!.reload();
                await Future.delayed(const Duration(seconds: 2));
                Navigator.pop(context);
              }
            },
            child: const Text('Submit')),
      ],
    ),
  );
}

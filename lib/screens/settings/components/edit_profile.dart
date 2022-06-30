import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/controllers/user_controller.dart';
import 'package:plant_watch/models/user_model.dart';

import '../../../components/form_field.dart';
import '../../../constants.dart';

Future editProfile(BuildContext context, UserCustom user) {
  dynamic formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  UploadProfile uploadProfile = UploadProfile();
  return showDialog(
      context: context,
      builder: (context) => Center(
            child: Card(
              margin: const EdgeInsets.all(10),
              elevation: 10,
              child: Form(
                key: formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        formField(name, "Name", TextInputType.name),
                        const SizedBox(
                          height: 15,
                        ),
                        formField(address, "Address", TextInputType.text),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: kPrimaryColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
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
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: kPrimaryColor),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel')),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: kPrimaryColor),
                                onPressed: () async {
                                  await uploadProfile.edit(
                                    id: user.id,
                                    userType: user.userType,
                                    totalSaved: user.totalSaved,
                                    context: context,
                                    address: address.text,
                                  );
                                  await FirebaseAuth.instance.currentUser!
                                      .reload();
                                  Navigator.pushReplacementNamed(
                                      context, '/settings');
                                },
                                child: const Text('Submit')),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ));
}

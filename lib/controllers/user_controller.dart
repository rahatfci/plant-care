import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../constants.dart';
import '../models/user_model.dart';
import '../screens/settings/components/body.dart';

class UserController {
  static final CollectionReference reference =
      FirebaseFirestore.instance.collection('users');
  static Stream<List<UserCustom>> allUser() {
    return reference.snapshots().map((event) =>
        event.docs.map((e) => UserCustom.fromJson(e.data())).toList());
  }

  static Future<UserCustom> loggedUser(String id) {
    return reference.doc(id).get().then((value) => UserCustom.fromJson(value));
  }
}

class UploadProfile {
  Function? set;
  FirebaseStorage storage = FirebaseStorage.instance;
  UploadProfile();
  File? _photo;
  String? fileName;
  final ImagePicker _picker = ImagePicker();

  void showPicker(context, Function setState) {
    set = setState;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () async {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                const Divider(
                  thickness: 1.5,
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      fileName = basename(_photo!.path);
    }

    set!(() {
      if (fileName != null) {
        SettingsBody.imageName = fileName!;
      } else {
        SettingsBody.imageName = "Something went wrong";
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      fileName = basename(_photo!.path);
    }

    set!(() {
      if (_photo != null) {
        SettingsBody.imageName = fileName!;
      } else {
        SettingsBody.imageName = "Something went wrong";
      }
    });
  }

  Future edit(
      {required String name,
      required BuildContext context,
      required String id,
      required String imgName}) async {
    showDialog(
        context: context,
        builder: (context) => const Center(
                child: CircularProgressIndicator(
              color: kPrimaryColor,
            )));
    try {
      if (name.isNotEmpty) {
        FirebaseAuth.instance.currentUser!.updateDisplayName(name);
        FirebaseAuth.instance.currentUser!.reload();
      }
      if (fileName != null) {
        final dynamic ref;
        if (imgName.isNotEmpty) {
          ref = FirebaseStorage.instance.ref().child('images/users/$imgName');
          await ref.delete();
        } else {
          ref = FirebaseStorage.instance.ref().child('images/users/$fileName');
        }

        await ref.putFile(_photo!);
        FirebaseAuth.instance.currentUser!
            .updatePhotoURL(await ref.getDownloadURL());

        FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update({'imgName': imgName.isNotEmpty ? imgName : fileName});
        FirebaseAuth.instance.currentUser!.reload();
      }
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      Future.error(e.toString());
    }
  }
}

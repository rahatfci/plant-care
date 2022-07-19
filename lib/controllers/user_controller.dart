import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../constants.dart';
import '../models/user_model.dart';

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
  FirebaseStorage storage = FirebaseStorage.instance;

  File? _photo;

  final ImagePicker _picker = ImagePicker();

  String? fileName;

  void showPicker(context) {
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
                    onTap: () {
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
    } else {
      fileName = "Something went wrong";
    }
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      fileName = basename(_photo!.path);
    } else {
      fileName = "Something went wrong";
    }
  }

  Future edit({required String name, required BuildContext context}) async {
    showDialog(
        context: context,
        builder: (context) => const Center(
                child: CircularProgressIndicator(
              color: kPrimaryColor,
            )));
    try {
      FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      FirebaseAuth.instance.currentUser!.reload();

      if (_photo != null) {
        final ref =
            FirebaseStorage.instance.ref().child('images/users/$fileName');
        await ref.delete();
        await ref.putFile(_photo!);
        FirebaseAuth.instance.currentUser!
            .updatePhotoURL(await ref.getDownloadURL());
        FirebaseAuth.instance.currentUser!.reload();
      }
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      Future.error(e.toString());
    }
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:plant_watch/screens/tips_admin/components/body.dart';

import '../constants.dart';
import '../models/tips_model.dart';

class TipsController {
  static final CollectionReference reference =
      FirebaseFirestore.instance.collection('tip');
  static Stream<List<Tip>> allTip() {
    return reference
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((event) => event.docs.map((e) => Tip.fromJson(e.data())).toList());
  }

  static Stream<List<Tip>> topTip() {
    return reference
        .orderBy('createdAt', descending: true)
        .limit(1)
        .snapshots()
        .map((event) => event.docs.map((e) => Tip.fromJson(e.data())).toList());
  }
}

class UploadTips {
  Function? set;
  FirebaseStorage storage = FirebaseStorage.instance;
  UploadTips();
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
        Body.imageName = fileName!;
      } else {
        Body.imageName = "Something went wrong";
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
        Body.imageName = fileName!;
      } else {
        Body.imageName = "Something went wrong";
      }
    });
  }

  Future upload(
      {required String title,
      required String description,
      required BuildContext context}) async {
    if (_photo == null) {
      Body.imageName = "Please select a picture";
      set!(() {});
    } else {
      showDialog(
          context: context,
          builder: (context) => const Center(
                  child: CircularProgressIndicator(
                color: kPrimaryColor,
              )));
      try {
        final ref =
            FirebaseStorage.instance.ref().child('images/tips/$fileName');
        await ref.putFile(_photo!);
        dynamic dbref = FirebaseFirestore.instance.collection('tip').doc();

        dynamic data = Tip(
            id: dbref.id,
            title: title,
            imgName: fileName!,
            imgPath: await ref.getDownloadURL(),
            description: description,
            createdAt: Timestamp.now());

        dbref.set(data.toJson());
        Navigator.pop(context);
      } catch (e) {
        Future.error(e.toString());
      }
      Navigator.pop(context);
    }
  }

  Future edit(
      {required String title,
      required String description,
      required String imgName,
      required String id,
      required BuildContext context}) async {
    showDialog(
        context: context,
        builder: (context) => const Center(
                child: CircularProgressIndicator(
              color: kPrimaryColor,
            )));
    try {
      dynamic ref =
          FirebaseStorage.instance.ref().child('images/tips/$imgName');
      if (fileName != null) {
        await ref.delete();
        ref = FirebaseStorage.instance.ref().child('images/tips/$fileName');
        await ref.putFile(_photo!);
      }
      Tip data = Tip(
          id: id,
          title: title,
          imgPath: await ref.getDownloadURL(),
          description: description,
          imgName: fileName == null ? imgName : fileName!,
          createdAt: Timestamp.now());
      DocumentReference dbref =
          FirebaseFirestore.instance.collection('tip').doc(id);

      await dbref.update(data.toJson());
      Navigator.pop(context);
    } catch (e) {
      Future.error(e.toString());
    }
    Navigator.pop(context);
  }
}

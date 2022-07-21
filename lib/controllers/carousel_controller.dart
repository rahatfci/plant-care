import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:plant_watch/screens/carousel_admin/components/body.dart';

import '../constants.dart';
import '../models/carousel_model.dart';

class CarouselControllerCustom {
  static Stream<List<CarouselCustom>> allCarousel() {
    final CollectionReference reference =
        FirebaseFirestore.instance.collection('carousel');
    return reference.snapshots().map((event) =>
        event.docs.map((e) => CarouselCustom.fromJson(e.data())).toList());
  }
}

class UploadCarousel {
  Function? set;
  UploadCarousel();
  FirebaseStorage storage = FirebaseStorage.instance;
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  String? fileName;

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
      required String link,
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
            FirebaseStorage.instance.ref().child('images/carousel/$fileName');
        await ref.putFile(_photo!);
        dynamic dbref = FirebaseFirestore.instance.collection('carousel').doc();

        dynamic data = CarouselCustom(
            id: dbref.id,
            title: title,
            imgName: fileName!,
            imgPath: await ref.getDownloadURL(),
            description: description,
            link: link);

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
      required String link,
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
      final ref =
          FirebaseStorage.instance.ref().child('images/carousel/$imgName');
      if (fileName != null) {
        await ref.delete();
        await ref.putFile(_photo!);
      }
      CarouselCustom editedCarousel = CarouselCustom(
          id: id,
          title: title,
          imgPath: await ref.getDownloadURL(),
          description: description,
          imgName: fileName == null ? imgName : fileName!,
          link: link);
      DocumentReference dbref =
          FirebaseFirestore.instance.collection('carousel').doc(id);

      await dbref.update(editedCarousel.toJson());
      Navigator.pop(context);
    } catch (e) {
      Future.error(e.toString());
    }
    Navigator.pop(context);
  }
}

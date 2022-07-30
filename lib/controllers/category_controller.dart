import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:path/path.dart';
import 'package:plant_watch/constants.dart';
import 'package:plant_watch/screens/categories_admin/components/body.dart';

import '../models/category_model.dart';

class CategoryController {
  static final CollectionReference reference =
      FirebaseFirestore.instance.collection('categories');
  static Stream<List<Category>> allCategory() {
    return reference.snapshots().map(
        (event) => event.docs.map((e) => Category.fromJson(e.data())).toList());
  }
}

class UploadCategory {
  Function? set;
  FirebaseStorage storage = FirebaseStorage.instance;
  UploadCategory();
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

  upload({required String name, required BuildContext context}) async {
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
            FirebaseStorage.instance.ref().child('images/categories/$fileName');
        await ref.putFile(_photo!);
        dynamic dbref =
            FirebaseFirestore.instance.collection('categories').doc();

        dynamic data = Category(
            id: dbref.id,
            name: name,
            imgPath: await ref.getDownloadURL(),
            imgName: fileName!,
            color: await PaletteGenerator.fromImageProvider(FileImage(_photo!))
                .then((value) {
              if (value.vibrantColor != null) {
                return value.vibrantColor!.color.value;
              } else {
                return value.dominantColor!.color.value;
              }
            }));

        dbref.set(data.toJson());
        Navigator.pop(context);
      } catch (e) {
        Future.error(e.toString());
      }
      Navigator.pop(context);
    }
  }

  edit(
      {required String name,
      required String imgName,
      required String id,
      required int color,
      required BuildContext context}) async {
    showDialog(
        context: context,
        builder: (context) => const Center(
                child: CircularProgressIndicator(
              color: kPrimaryColor,
            )));
    try {
      dynamic ref =
          FirebaseStorage.instance.ref().child('images/categories/$imgName');
      if (fileName != null) {
        await ref.delete();
        ref =
            FirebaseStorage.instance.ref().child('images/categories/$fileName');
        await ref.putFile(_photo!);
      }
      Category editedProduct = Category(
          id: id,
          name: name,
          imgPath: await ref.getDownloadURL(),
          imgName: fileName == null ? imgName : fileName!,
          color: fileName == null
              ? color
              : await PaletteGenerator.fromImageProvider(FileImage(_photo!))
                  .then((value) => value.vibrantColor!.color.value));
      DocumentReference dbref =
          FirebaseFirestore.instance.collection('categories').doc(id);
      await dbref.update(editedProduct.toJson());
      Navigator.pop(context);
    } catch (e) {
      Future.error(e.toString());
    }
    Navigator.pop(context);
  }
}

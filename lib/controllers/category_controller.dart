import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:path/path.dart';
import 'package:plant_watch/constants.dart';

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
  Function set;

  UploadCategory(this.set);

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
    set(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        fileName = basename(_photo!.path);
      } else {
        fileName = "Something went wrong";
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    set(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        fileName = basename(_photo!.path);
      } else {
        fileName = "Something went wrong";
      }
    });
  }

  Future upload({required String name, required BuildContext context}) async {
    if (_photo == null) {
      Future.error("Please select a valid picture");
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
                .then((value) => value.vibrantColor!.color.value));

        dbref.set(data.toJson());
        Navigator.pop(context);
        set(() {});
      } catch (e) {
        Future.error(e.toString());
      }
      Navigator.pop(context);
    }
  }

  Future edit(
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
      final ref =
          FirebaseStorage.instance.ref().child('images/categories/$imgName');
      if (fileName != null) {
        await ref.delete();
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
      set(() {});
    } catch (e) {
      Future.error(e.toString());
    }
    Navigator.pop(context);
  }
}

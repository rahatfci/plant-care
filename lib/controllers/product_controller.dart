import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:plant_watch/constants.dart';
import 'package:plant_watch/screens/products_admin/components/body.dart';

import '../models/product_model.dart';

class ProductController {
  static final CollectionReference reference =
      FirebaseFirestore.instance.collection('products');
  static Stream<List<Product>> allProduct() {
    return reference.snapshots().map(
        (event) => event.docs.map((e) => Product.fromJson(e.data())).toList());
  }

  static Stream<List<Product>> topProduct() {
    return reference.limit(10).snapshots().map(
        (event) => event.docs.map((e) => Product.fromJson(e.data())).toList());
  }

  static Stream<List<Product>> findProduct(String category) {
    return reference.where('category', isEqualTo: category).snapshots().map(
        (event) => event.docs.map((e) => Product.fromJson(e.data())).toList());
  }
}

class UploadProduct {
  Function? set;
  FirebaseStorage storage = FirebaseStorage.instance;
  UploadProduct();
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
      {required String name,
      required String description,
      required int quantity,
      required String discount,
      required String price,
      required String category,
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
            FirebaseStorage.instance.ref().child('images/products/$fileName');
        await ref.putFile(_photo!);
        dynamic dbref = FirebaseFirestore.instance.collection('products').doc();

        dynamic data = Product(
            id: dbref.id,
            name: name,
            imgPath: await ref.getDownloadURL(),
            description: description,
            quantity: quantity,
            discount: discount,
            price: price,
            imgName: fileName!,
            category: category);

        dbref.set(data.toJson());
        Navigator.pop(context);
      } catch (e) {
        Future.error(e.toString());
      }
      Navigator.pop(context);
    }
  }

  Future edit(
      {required String name,
      required String description,
      required int quantity,
      required String discount,
      required String price,
      required String imgName,
      required String id,
      required String category,
      required BuildContext context}) async {
    showDialog(
        context: context,
        builder: (context) => const Center(
                child: CircularProgressIndicator(
              color: kPrimaryColor,
            )));
    try {
      final ref =
          FirebaseStorage.instance.ref().child('images/products/$imgName');
      if (fileName != null) {
        await ref.delete();
        await ref.putFile(_photo!);
      }
      Product editedProduct = Product(
          id: id,
          name: name,
          imgPath: await ref.getDownloadURL(),
          description: description,
          quantity: quantity,
          discount: discount,
          price: price,
          imgName: fileName == null ? imgName : fileName!,
          category: category);
      DocumentReference dbref =
          FirebaseFirestore.instance.collection('products').doc(id);

      await dbref.update(editedProduct.toJson());
      Navigator.pop(context);
    } catch (e) {
      Future.error(e.toString());
    }
    Navigator.pop(context);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Tip {
  final String id;
  final String title;
  final String description;
  final String imgName;
  final String imgPath;
  final Timestamp createdAt;

  Tip(
      {required this.id,
      required this.title,
      required this.description,
      required this.imgName,
      required this.imgPath,
      required this.createdAt});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imgName': imgName,
      'imgPath': imgPath,
      'createdAt': createdAt
    };
  }

  static Tip fromJson(data) {
    return Tip(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        imgName: data['imgName'],
        imgPath: data['imgPath'],
        createdAt: data['createdAt']);
  }
}

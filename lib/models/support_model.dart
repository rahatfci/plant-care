import 'package:cloud_firestore/cloud_firestore.dart';

class Support {
  final String id;
  final String title;
  final String description;
  final String imgName;
  final String imgPath;
  final String userId;
  final Timestamp createdAt;
  final String status;

  Support(
      {required this.id,
      required this.title,
      required this.description,
      required this.imgName,
      required this.imgPath,
      required this.userId,
      required this.createdAt,
      required this.status});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imgName': imgName,
      'imgPath': imgPath,
      'userId': userId,
      'createdAt': createdAt,
      'status': status
    };
  }

  static Support fromJson(data) {
    return Support(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        imgName: data['imgName'],
        imgPath: data['imgPath'],
        userId: data['userId'],
        createdAt: data['createdAt'],
        status: data['status']);
  }
}

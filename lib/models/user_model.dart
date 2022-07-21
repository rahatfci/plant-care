import 'package:cloud_firestore/cloud_firestore.dart';

class UserCustom {
  String id;
  String userType;
  Timestamp createdAt;
  int totalSaved;
  int totalOrder;
  String imgName;
  UserCustom(
      {required this.userType,
      required this.createdAt,
      required this.id,
      required this.totalSaved,
      required this.totalOrder,
      required this.imgName});

  Map<String, dynamic> toJson() {
    return {
      'userType': userType,
      'createdAt': createdAt,
      'id': id,
      'totalSaved': totalSaved,
      'totalOrder': totalOrder,
      'imgName': imgName
    };
  }

  static UserCustom fromJson(data) {
    return UserCustom(
        id: data['id'],
        userType: data['userType'],
        createdAt: data['createdAt'],
        totalSaved: data['totalSaved'],
        totalOrder: data['totalOrder'],
        imgName: data['imgName']);
  }
}

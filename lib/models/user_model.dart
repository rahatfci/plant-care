import 'package:cloud_firestore/cloud_firestore.dart';

class UserCustom {
  String id;
  String userType;
  String? address;
  Timestamp createdAt;
  int totalSaved;
  UserCustom(
      {required this.userType,
      this.address,
      required this.createdAt,
      required this.id,
      required this.totalSaved});

  Map<String, dynamic> toJson() {
    return {
      'userType': userType,
      'address': address,
      'createdAt': createdAt,
      'id': id,
      'totalSaved': totalSaved
    };
  }

  static UserCustom fromJson(data) {
    return UserCustom(
        id: data['id'],
        userType: data['userType'],
        address: data['address'],
        createdAt: data['createdAt'],
        totalSaved: data['totalSaved']);
  }
}

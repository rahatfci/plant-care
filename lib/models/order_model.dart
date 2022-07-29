import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String id;
  final String userId;
  final Timestamp date;
  final String status;
  final String paymentMethod;
  final String details;
  final String phone;
  final String total;
  final Map<String, int> products;
  Order(
      {required this.id,
      required this.userId,
      required this.date,
      required this.status,
      required this.paymentMethod,
      required this.details,
      required this.phone,
      required this.products,
      required this.total});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date,
      'status': status,
      'paymentMethod': paymentMethod,
      'details': details,
      'phone': phone,
      'products': products,
      'total': total
    };
  }

  static Order fromJson(data) {
    return Order(
        id: data['id'],
        userId: data['userId'],
        date: data['date'],
        status: data['status'],
        paymentMethod: data['paymentMethod'],
        details: data['details'],
        phone: data['phone'],
        products: data['products'],
        total: data['total']);
  }
}

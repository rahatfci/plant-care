import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/order_model.dart';

class OrdersController {
  static CollectionReference reference =
      FirebaseFirestore.instance.collection('orders');
  static Stream<List<Order>> allOrders(String userId) {
    return reference.where('userId', isEqualTo: userId).snapshots().map(
        (event) => event.docs.map((e) => Order.fromJson(e.data())).toList());
  }
}

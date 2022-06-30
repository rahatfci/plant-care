import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/seller_model.dart';

class SellersController {
  static final CollectionReference reference =
      FirebaseFirestore.instance.collection('sellers');

  static Stream<List<Seller>> allSellers() {
    return reference.snapshots().map(
        (event) => event.docs.map((e) => Seller.fromJson(e.data())).toList());
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartController {
  static final CollectionReference reference =
      FirebaseFirestore.instance.collection('cart');

  static Stream<List<Cart>> allCart() {
    return reference.snapshots().map(
        (event) => event.docs.map((e) => Cart.fromJson(e.data())).toList());
  }

  static Stream<Product> cartProduct(String productId) {
    return FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .snapshots()
        .map((event) => Product.fromJson(event.data()));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartController {
  static final CollectionReference reference =
      FirebaseFirestore.instance.collection('cart');

  static Stream<List<Cart>> allCart() {
    return reference
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map(
            (event) => event.docs.map((e) => Cart.fromJson(e.data())).toList());
  }

  static Stream<List<Product>> cartProduct(String productId) {
    return FirebaseFirestore.instance
        .collection('products')
        .where('id', isEqualTo: productId)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Product.fromJson(e.data())).toList());
  }

  static Future addToCart(String productId, int quantity, String userId) async {
    dynamic dbRef = reference.doc();
    Cart data = Cart(
        id: dbRef.id, productId: productId, quantity: quantity, userId: userId);
    await dbRef.set(data.toJson());
  }

  static Future removeCart(String id) async {
    reference.doc(id).delete();
  }
}

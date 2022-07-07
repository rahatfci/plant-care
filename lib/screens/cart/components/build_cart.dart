import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/controllers/cart_controller.dart';
import 'package:plant_watch/screens/cart/components/body.dart';

import '../../../constants.dart';
import '../../../models/cart_model.dart';
import '../../../models/product_model.dart';

Widget buildCart(Cart cart, Function set) {
  return StreamBuilder<List<Product>>(
      stream: CartController.cartProduct(cart.productId),
      builder: (context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.hasData) {
          Product product = snapshot.data![0];
          Body.totalPrice = 0;
          Body.totalPrice += cart.quantity * int.parse(product.price);
          return Card(
            elevation: 8,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Image.network(product.imgPath),
                    flex: 2,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          product.price,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 35,
                              child: InkWell(
                                child: const Icon(Icons.remove),
                                onTap: () {
                                  if (cart.quantity > 1) {
                                    FirebaseFirestore.instance
                                        .collection('cart')
                                        .doc(cart.id)
                                        .update(
                                            {'quantity': cart.quantity - 1});
                                    set(() {});
                                  }
                                },
                              ),
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                cart.quantity.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22),
                              ),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Container(
                              width: 35,
                              child: InkWell(
                                onTap: () {
                                  if (cart.quantity < product.quantity) {
                                    FirebaseFirestore.instance
                                        .collection('cart')
                                        .doc(cart.id)
                                        .update(
                                            {'quantity': cart.quantity + 1});
                                    set(() {});
                                  }
                                },
                                child: const Icon(Icons.add),
                              ),
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    flex: 3,
                  ),
                  GestureDetector(
                      onTap: () => CartController.removeCart(cart.id),
                      child: const Icon(Icons.delete_forever,
                          color: Colors.black, size: 35))
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        }
      });
}

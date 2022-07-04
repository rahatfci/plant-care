import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/controllers/cart_controller.dart';

import '../../../constants.dart';
import '../../../models/cart_model.dart';
import '../../../models/product_model.dart';

Widget buildCart(Cart cart, Function set) {
  return StreamBuilder<List<Product>>(
      stream: CartController.cartProduct(cart.productId),
      builder: (context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.hasData) {
          Product product = snapshot.data![0];
          return Card(
            elevation: 10,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 6),
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        product.price,
                        style: TextStyle(fontSize: 16),
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
                              onTap: null,
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
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "0",
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
                              child: const Icon(Icons.add),
                              onTap: null,
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
                IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 35,
                    onPressed: () {
                      CartController.removeCart(cart.id);
                    },
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.black,
                    ))
              ],
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

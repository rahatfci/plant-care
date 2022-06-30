import 'package:flutter/material.dart';

import '../../../models/product_model.dart';

Widget buildTile(Product product) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 10,
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFf1f1f1),
                Colors.grey,
              ])),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(product.name),
                CircleAvatar(
                  backgroundImage: NetworkImage(product.imgPath),
                )
              ],
            ),
            Text(product.price)
          ]),
    ),
  );
}

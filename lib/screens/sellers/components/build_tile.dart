import 'package:flutter/material.dart';

import '../../../models/seller_model.dart';

Widget buildTile(Seller seller) {
  return GestureDetector(
    onTap: () {},
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: AssetImage(seller.imgPath), fit: BoxFit.fill)),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(seller.name,
                  style: const TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 16,
                      fontWeight: FontWeight.bold))
            ]),
      ),
    ),
  );
}

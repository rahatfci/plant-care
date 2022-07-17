import 'package:flutter/material.dart';
import 'package:plant_watch/screens/cart/components/body.dart';

import '../../../constants.dart';

Widget priceDetails(Function set, BuildContext context) {
  set(() {});
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: kPrimaryColor, borderRadius: BorderRadius.circular(15)),
      child: Text(
        "Total Price - ${CartBody.totalPrice} tk",
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
      ),
    ),
  );
}

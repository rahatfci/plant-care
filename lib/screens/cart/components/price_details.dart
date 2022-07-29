import 'package:flutter/material.dart';
import 'package:plant_watch/screens/cart/components/body.dart';

import '../../../constants.dart';

Widget priceDetails(Function set, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      TextButton(
          onPressed: () async {
            set(() {});
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            primary: Colors.white,
            backgroundColor: kPrimaryColor,
          ),
          child: Text(
            "Total Price - ${CartBody.totalPrice / 2} tk",
            style: const TextStyle(fontSize: 18, color: Colors.white),
          )),
      TextButton(
        onPressed: () => Navigator.pushNamed(context, '/buy'),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: kPrimaryColor,
        ),
        child: const Text(
          "Buy",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    ],
  );
}

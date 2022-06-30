import 'package:flutter/material.dart';

import '../../../constants.dart';

Widget priceDetails() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: kPrimaryColor, borderRadius: BorderRadius.circular(15)),
      child: Text(
        "Total Price - 100tk",
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
      ),
    ),
  );

  // return Container(
  //     padding: const EdgeInsets.all(12),
  //     decoration: const BoxDecoration(
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black26,
  //             offset: Offset(
  //               0.0,
  //               0.0,
  //             ),
  //             blurRadius: 10.0,
  //             spreadRadius: 2.0,
  //           ), //BoxShadow
  //           BoxShadow(
  //             color: Colors.white,
  //             offset: Offset(0.0, 0.0),
  //             blurRadius: 0.0,
  //             spreadRadius: 0.0,
  //           ), //BoxShadow
  //         ],
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(20), topRight: Radius.circular(20))),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Container(
  //           width: 100,
  //           height: 3,
  //           color: Colors.black26,
  //         ),
  //         const SizedBox(
  //           height: 15,
  //         ),
  //         const Text(
  //           "Price Details",
  //           style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
  //         ),
  //         const Divider(),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               "Price ($sum items)",
  //               style: const TextStyle(fontSize: 16),
  //             ),
  //             Text(
  //               "\$${80 * sum}",
  //               style:
  //                   const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(
  //           height: 5,
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: const [
  //             Text(
  //               "Discount",
  //               style: TextStyle(fontSize: 16),
  //             ),
  //             Text(
  //               "-\$0",
  //               style: TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w500,
  //                   color: kPrimaryColor),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(
  //           height: 5,
  //         ),
  //         const Divider(),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             const Text(
  //               "Total Amount",
  //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //             ),
  //             Text(
  //               "\$${80 * sum}",
  //               style:
  //                   const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(
  //           height: 5,
  //         ),
  //         ElevatedButton.icon(
  //           icon: const Icon(Icons.arrow_forward),
  //           onPressed: () {},
  //           label: const Text(
  //             "CheckOut",
  //             style: TextStyle(fontWeight: FontWeight.w500),
  //           ),
  //           style: ElevatedButton.styleFrom(primary: kPrimaryColor),
  //         ),
  //         const Divider(
  //           thickness: 2,
  //         )
  //       ],
  //     ));
}

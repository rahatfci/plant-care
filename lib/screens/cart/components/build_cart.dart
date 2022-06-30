import 'package:flutter/material.dart';
import 'package:plant_watch/controllers/cart_controller.dart';

import '../../../constants.dart';
import '../../../models/cart_model.dart';
import '../../../models/product_model.dart';

Widget buildCart(Cart cart, Function set) {
  return StreamBuilder<Product>(
      stream: CartController.cartProduct(cart.id),
      builder: (context, AsyncSnapshot<Product> snapshot) {
        if (snapshot.hasData) {
          return Row(
            children: [
              Flexible(
                child: Image.network(snapshot.data!.imgPath),
                flex: 2,
              ),
              Flexible(
                child: Container(),
                flex: 3,
              )
            ],
          );
          // return Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       border: Border.all(color: Colors.black26, width: 2),
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     child: SingleChildScrollView(
          //       scrollDirection: Axis.horizontal,
          //       child: Row(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           ClipRRect(
          //             child: Image.asset(
          //               snapshot.data!.imgPath,
          //               height: 110,
          //             ),
          //             borderRadius: const BorderRadius.only(
          //                 topLeft: Radius.circular(20),
          //                 bottomLeft: Radius.circular(20)),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.all(10.0),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   snapshot.data!.name,
          //                   style: const TextStyle(
          //                       fontSize: 18, fontWeight: FontWeight.w500),
          //                 ),
          //                 const SizedBox(
          //                   height: 3,
          //                 ),
          //                 Text(
          //                   "In Stock",
          //                   style: TextStyle(
          //                       color: kPrimaryColor.withOpacity(.8),
          //                       fontSize: 14),
          //                 ),
          //                 const SizedBox(
          //                   height: 8,
          //                 ),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Container(
          //                       width: 30,
          //                       child: InkWell(
          //                         child: const Icon(
          //                           Icons.remove,
          //                           size: 20,
          //                         ),
          //                         onTap: () => setCount(false),
          //                       ),
          //                       padding: const EdgeInsets.all(3),
          //                       decoration: BoxDecoration(
          //                           border: Border.all(),
          //                           borderRadius: BorderRadius.circular(10)),
          //                     ),
          //                     const SizedBox(width: 5),
          //                     Text(
          //                       count.toString().padLeft(2, '0'),
          //                       style: const TextStyle(
          //                           fontWeight: FontWeight.w500, fontSize: 18),
          //                     ),
          //                     const SizedBox(
          //                       width: 5,
          //                     ),
          //                     Container(
          //                       width: 30,
          //                       child: InkWell(
          //                         child: const Icon(
          //                           Icons.add,
          //                           size: 20,
          //                         ),
          //                         onTap: () => setCount(true),
          //                       ),
          //                       padding: const EdgeInsets.all(3),
          //                       decoration: BoxDecoration(
          //                           border: Border.all(),
          //                           borderRadius: BorderRadius.circular(10)),
          //                     ),
          //                     const SizedBox(
          //                       width: 3,
          //                     ),
          //                     const Icon(
          //                       Icons.close,
          //                       size: 20,
          //                       color: Colors.black45,
          //                     ),
          //                     const SizedBox(width: 3),
          //                     Text(
          //                       snapshot.data!.price.toString(),
          //                       style: const TextStyle(
          //                           fontSize: 18,
          //                           color: kPrimaryColor,
          //                           fontWeight: FontWeight.w500),
          //                     ),
          //                   ],
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Column(
          //             children: [
          //               IconButton(
          //                 icon: const Icon(
          //                   Icons.close,
          //                   size: 30,
          //                   color: Colors.red,
          //                 ),
          //                 onPressed: () {
          //                   showDialog(
          //                       context: context,
          //                       builder: (context) => AlertDialog(
          //                             title: const Text(
          //                                 "Are you sure to delete this item? "),
          //                             titleTextStyle: const TextStyle(
          //                                 fontSize: 18, color: kTextColor),
          //                             titlePadding: const EdgeInsets.only(
          //                                 top: 15, left: 15, right: 15),
          //                             actions: [
          //                               ElevatedButton(
          //                                 style: ElevatedButton.styleFrom(
          //                                   primary: kPrimaryColor,
          //                                   padding: const EdgeInsets.symmetric(
          //                                       vertical: 8, horizontal: 8),
          //                                 ),
          //                                 onPressed: () {
          //                                   Navigator.pop(context);
          //                                 },
          //                                 child: const Text("Cancel"),
          //                               ),
          //                               ElevatedButton(
          //                                 style: ElevatedButton.styleFrom(
          //                                   primary: kPrimaryColor,
          //                                   padding: const EdgeInsets.symmetric(
          //                                       vertical: 8, horizontal: 8),
          //                                 ),
          //                                 onPressed: () async {
          //                                   await FirebaseFirestore.instance
          //                                       .collection('cart')
          //                                       .doc(cart.id)
          //                                       .delete()
          //                                       .then((value) {
          //                                     Navigator.pop(context);
          //                                     ScaffoldMessenger.of(context)
          //                                         .showSnackBar(
          //                                       const SnackBar(
          //                                         content: Text(
          //                                           "The item has been deleted successfully",
          //                                           style:
          //                                               TextStyle(fontSize: 18),
          //                                           textAlign: TextAlign.center,
          //                                         ),
          //                                         backgroundColor:
          //                                             kPrimaryColor,
          //                                       ),
          //                                     );
          //                                   });
          //                                 },
          //                                 child: const Text("Delete"),
          //                               ),
          //                             ],
          //                           ));
          //                 },
          //               ),
          //               const SizedBox(
          //                 height: 30,
          //               ),
          //               Container(
          //                 padding: const EdgeInsets.symmetric(
          //                     horizontal: 6, vertical: 3),
          //                 decoration: BoxDecoration(
          //                     borderRadius: BorderRadius.circular(15),
          //                     color: kPrimaryColor),
          //                 child: Text(
          //                   (count * 10).toString(),
          //                   style: const TextStyle(
          //                       fontSize: 16,
          //                       fontWeight: FontWeight.w500,
          //                       color: Colors.white),
          //                 ),
          //               ),
          //             ],
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // );
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

import 'package:flutter/material.dart';
import 'package:plant_watch/screens/home/components/products.dart';
import 'package:plant_watch/screens/home/components/search_box.dart';
import 'package:plant_watch/screens/home/components/sellers.dart';
import 'package:plant_watch/screens/home/components/tips.dart';
import 'package:plant_watch/screens/sellers/sellers_screen.dart';

import '../../../constants.dart';
import 'carousel.dart';
import 'categories.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            const SearchBox(),
            const SizedBox(
              height: 15,
            ),
            const Tips(),
            const SizedBox(
              height: 15,
            ),
            const Carousel(),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Categories",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            const Categories(),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Products",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            const Products(),
            // const SizedBox(
            //   height: 15,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const Text(
            //       "Sellers",
            //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //     ),
            //     GestureDetector(
            //         onTap: () {
            //           Navigator.push(context,
            //               MaterialPageRoute(builder: (context) {
            //             return SellerScreen();
            //           }));
            //         },
            //         child: const Text(
            //           'View All >',
            //           style: TextStyle(
            //               color: kPrimaryColor,
            //               fontWeight: FontWeight.w500,
            //               fontSize: 16),
            //         ))
            //   ],
            // ),
            // const SizedBox(
            //   height: 15,
            // ),
            // const Sellers(),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

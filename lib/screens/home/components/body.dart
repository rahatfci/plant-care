import 'package:flutter/material.dart';
import 'package:plant_watch/screens/home/components/products.dart';
import 'package:plant_watch/screens/home/components/search_box.dart';
import 'package:plant_watch/screens/home/components/tips.dart';

import 'carousel.dart';
import 'categories.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ListView(
        children: const [
          SizedBox(
            height: 15,
          ),
          SearchBox(),
          SizedBox(
            height: 15,
          ),
          Tips(),
          SizedBox(
            height: 15,
          ),
          Carousel(),
          SizedBox(
            height: 15,
          ),
          Text(
            "Categories",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Categories(),
          SizedBox(
            height: 15,
          ),
          Text(
            "Products",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Products(),
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
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

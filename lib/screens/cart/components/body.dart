import 'package:flutter/material.dart';
import 'package:plant_watch/controllers/cart_controller.dart';
import 'package:plant_watch/screens/cart/components/price_details.dart';

import '../../../constants.dart';
import '../../../models/cart_model.dart';
import 'build_cart.dart';

class CartBody extends StatefulWidget {
  const CartBody({Key? key}) : super(key: key);
  static int totalPrice = 0;
  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<List<Cart>>(
            stream: CartController.allCart(),
            builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
              if (snapshot.hasData) {
                CartBody.totalPrice = 0;
                return Expanded(
                  child: ListView(
                      padding: const EdgeInsets.only(top: 5),
                      children: snapshot.data!
                          .map((e) => buildCart(e, setState))
                          .toList()),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                );
              }
            }),
        const SizedBox(
          height: 10,
        ),
        priceDetails(setState, context),
      ],
    );
  }
}

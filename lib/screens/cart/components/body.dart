import 'package:flutter/material.dart';
import 'package:plant_watch/controllers/cart_controller.dart';
import 'package:plant_watch/screens/cart/components/build_cart.dart';
import 'package:plant_watch/screens/cart/components/price_details.dart';

import '../../../constants.dart';
import '../../../models/cart_model.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<List<Cart>>(
            stream: CartController.allCart(),
            builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.only(top: 5),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) =>
                          buildCart(snapshot.data![i], setState)),
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
        priceDetails()
      ],
    );
  }
}

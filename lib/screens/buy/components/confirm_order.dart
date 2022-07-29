import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/components/app_bar.dart';
import 'package:plant_watch/models/order_model.dart';
import 'package:plant_watch/screens/cart/components/body.dart';

import '../../../components/nav_drawer.dart';
import '../../../constants.dart';
import '../../../models/cart_model.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        key: scaffoldKey,
        appBar: buildAppBar(context, scaffoldKey),
        body: const Body(),
        drawer: const NavigationDrawer(),
        drawerEnableOpenDragGesture: false,
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int method = 1;
  @override
  Widget build(BuildContext context) {
    List<String> args =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Select Payment Method"),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        method = 1;
                      });
                    },
                    contentPadding: const EdgeInsets.all(7),
                    leading: Icon(Icons.money,
                        color: method == 1 ? Colors.white : kPrimaryColor),
                    title: Text(
                      "Cash on delivery",
                      style: TextStyle(
                          color: method == 1 ? Colors.white : Colors.blueGrey),
                    ),
                    trailing: Icon(Icons.check_circle,
                        color: method == 1 ? Colors.white : kPrimaryColor),
                    tileColor: method == 1
                        ? kPrimaryColor
                        : Colors.grey.withOpacity(.6),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        method = 2;
                      });
                    },
                    contentPadding: const EdgeInsets.all(7),
                    leading: Icon(Icons.money,
                        color: method == 2 ? Colors.white : kPrimaryColor),
                    title: Text(
                      "Card Payment",
                      style: TextStyle(
                          color: method == 2 ? Colors.white : Colors.blueGrey),
                    ),
                    trailing: Icon(Icons.credit_card,
                        color: method == 2 ? Colors.white : kPrimaryColor),
                    tileColor: method == 2
                        ? kPrimaryColor
                        : Colors.grey.withOpacity(.6),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        method = 3;
                      });
                    },
                    contentPadding: const EdgeInsets.all(7),
                    leading: Icon(Icons.money,
                        color: method == 3 ? Colors.white : kPrimaryColor),
                    title: Text(
                      "Bkash Payment",
                      style: TextStyle(
                          color: method == 3 ? Colors.white : Colors.blueGrey),
                    ),
                    trailing: Icon(Icons.payment,
                        color: method == 3 ? Colors.white : kPrimaryColor),
                    tileColor: method == 3
                        ? kPrimaryColor
                        : Colors.grey.withOpacity(.6),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Order Summery"),
                  const SizedBox(
                    height: 15,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Subtotal"),
                              Text((CartBody.totalPrice / 2).toString()),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Shipping"),
                              Text("100"),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.grey.withOpacity(.6),
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Total"),
                                Text(
                                    (CartBody.totalPrice / 2 + 100).toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: kPrimaryColor, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    "Back",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
                Container(
                  width: 2,
                  height: 20,
                  color: Colors.white,
                ),
                GestureDetector(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (context) => const Center(
                                child: CircularProgressIndicator(
                              color: kPrimaryColor,
                            )));
                    Map<String, int> productIds = {};
                    await FirebaseFirestore.instance
                        .collection('cart')
                        .where('userId',
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .get()
                        .then((value) => value.docs.map((e) {
                              Cart product = Cart.fromJson(e.data());
                              productIds.addAll(
                                  {product.productId: product.quantity});
                            }));
                    print(productIds);
                    var dbref =
                        FirebaseFirestore.instance.collection('orders').doc();
                    dynamic data = Order(
                        id: dbref.id,
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        date: Timestamp.now(),
                        status: "Completed",
                        paymentMethod: method.toString(),
                        details: args[0] + '/' + args[1],
                        phone: args[2],
                        products: productIds,
                        total: (CartBody.totalPrice / 2 + 100).toString());
                    await dbref.set(data.toJson());
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Confirm Order",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

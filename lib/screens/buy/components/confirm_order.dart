import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/components/app_bar.dart';
import 'package:plant_watch/models/order_model.dart';
import 'package:plant_watch/models/user_model.dart';
import 'package:plant_watch/screens/cart/components/body.dart';
import 'package:plant_watch/screens/home/home_screen.dart';

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
  bool orderDone = false;
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
                  const Text(
                    "Select Payment Method",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        method = 1;
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                    leading: Icon(Icons.money,
                        color: method == 1 ? Colors.white : kPrimaryColor),
                    title: Text(
                      "Cash on delivery",
                      style: TextStyle(
                          color: method == 1 ? Colors.white : Colors.black),
                    ),
                    trailing: method == 1
                        ? const Icon(Icons.check_circle, color: Colors.white)
                        : const SizedBox.shrink(),
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                    leading: Icon(Icons.credit_card,
                        color: method == 2 ? Colors.white : kPrimaryColor),
                    title: Text(
                      "Card Payment",
                      style: TextStyle(
                          color: method == 2 ? Colors.white : Colors.black),
                    ),
                    trailing: method == 2
                        ? const Icon(Icons.check_circle, color: Colors.white)
                        : const SizedBox.shrink(),
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                    leading: Icon(Icons.payment,
                        color: method == 3 ? Colors.white : kPrimaryColor),
                    title: Text(
                      "Bkash Payment",
                      style: TextStyle(
                          color: method == 3 ? Colors.white : Colors.black),
                    ),
                    trailing: method == 3
                        ? const Icon(Icons.check_circle, color: Colors.white)
                        : const SizedBox.shrink(),
                    tileColor: method == 3
                        ? kPrimaryColor
                        : Colors.grey.withOpacity(.6),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Order Summery",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Subtotal",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text((CartBody.totalPrice / 2).toString(),
                                    style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Shipping",
                                    style: TextStyle(fontSize: 16)),
                                Text("100", style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.6),
                                borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 13),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Total",
                                    style: TextStyle(fontSize: 16)),
                                Text((CartBody.totalPrice / 2 + 100).toString(),
                                    style: const TextStyle(fontSize: 16)),
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
                    if (orderDone) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 700),
                          content: Text(
                            "The Order has been placed successfully",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: kPrimaryColor,
                        ),
                      );
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => const Center(
                                  child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              )));
                      Map<String, dynamic> productIds = {};
                      FirebaseFirestore.instance
                          .collection('cart')
                          .where('userId',
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .snapshots()
                          .map((event) => event.docs.map((e) {
                                Cart product = Cart.fromJson(e.data());
                                productIds.addAll({
                                  product.productId: product.quantity.toString()
                                });
                              }));

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
                      UserCustom user = await FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .get()
                          .then((value) => UserCustom.fromJson(value.data()));
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({'totalOrder': user.totalOrder + 1});
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 900),
                          content: Text(
                            "The Order has been placed successfully",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: kPrimaryColor,
                        ),
                      );
                      orderDone = true;
                      HomeScreen.selectedIndex = 0;
                      await Future.delayed(const Duration(milliseconds: 500));
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/total_order', (route) => false);
                    }
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

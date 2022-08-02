import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/controllers/orders_controller.dart';
import 'package:plant_watch/models/order_model.dart';
import 'package:plant_watch/screens/home/home_screen.dart';

import '../components/app_bar.dart';
import '../components/nav_drawer.dart';
import '../constants.dart';

class TotalOrder extends StatelessWidget {
  TotalOrder({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: buildAppBar(context, scaffoldKey),
      drawer: const NavigationDrawer(),
      drawerEnableOpenDragGesture: false,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 25.0, right: 10),
        child: FloatingActionButton(
          child: const Icon(Icons.arrow_back),
          onPressed: () {
            HomeScreen.selectedIndex = 0;
            Navigator.pushNamed(context, '/');
          },
          backgroundColor: kPrimaryColor,
          elevation: 15,
        ),
      ),
      body: StreamBuilder<List<Order>>(
        stream:
            OrdersController.allOrders(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, AsyncSnapshot<List<Order>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10,
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5))),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Order Id:",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                            Text(snapshot.data![index].id,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white)),
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
                          children: [
                            const Text(
                              "Order Date:",
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(snapshot.data![index].date.toDate().toString(),
                                style: const TextStyle(fontSize: 15)),
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
                          children: [
                            const Text("Status",
                                style: TextStyle(fontSize: 15)),
                            Text(snapshot.data![index].status,
                                style: const TextStyle(fontSize: 15)),
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
                          children: [
                            const Text("Payment Method",
                                style: TextStyle(fontSize: 15)),
                            Text(
                                snapshot.data![index].paymentMethod == '1'
                                    ? 'Cash on Delivery'
                                    : snapshot.data![index].paymentMethod == '2'
                                        ? 'Card Payment'
                                        : 'Bkash Payment',
                                style: const TextStyle(fontSize: 15)),
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
                          children: [
                            const Text("Total", style: TextStyle(fontSize: 15)),
                            Text(snapshot.data![index].total,
                                style: const TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                );
              },
            );
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
        },
      ),
    );
  }
}

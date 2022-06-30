import 'package:flutter/material.dart';
import 'package:plant_watch/components/bottom_nav.dart';

import '../../components/app_bar.dart';
import '../../components/nav_drawer.dart';
import '../../constants.dart';
import '../../models/seller_model.dart';

class SellerDetails extends StatefulWidget {
  const SellerDetails(this.seller, {Key? key}) : super(key: key);
  final Seller seller;
  @override
  State<SellerDetails> createState() => _SellerDetailsState();
}

class _SellerDetailsState extends State<SellerDetails> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: buildAppBar(context, "Details", Icons.settings, scaffoldKey),
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
                tag: widget.seller.id,
                child: Image.asset(
                  widget.seller.imgPath,
                  height: 200,
                )),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Items",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          '10',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 26),
                        ),
                      ]),
                ),
                const SizedBox(height: 15),
                const Divider(
                  thickness: 2,
                  height: 0,
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(
                      top: 20, left: 20, right: 20, bottom: 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.seller.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Description",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                widget.seller.description,
                                style: TextStyle(
                                    color: kTextColor.withOpacity(.8),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      drawer: const NavigationDrawer(),
      drawerEnableOpenDragGesture: false,
      bottomNavigationBar: const MyBottomNavBar(),
    );
  }

  int count = 01;
  bool favorite = false;

  TextStyle textStyle() {
    return const TextStyle(height: 1.6);
  }

  void setCount(add) {
    add
        ? count++
        : count > 1
            ? count--
            : count;
    setState(() {});
  }

  void setFavorite() {
    favorite = !favorite;
    setState(() {});
  }
}

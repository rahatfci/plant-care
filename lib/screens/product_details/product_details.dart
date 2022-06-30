import 'package:flutter/material.dart';
import 'package:plant_watch/models/product_model.dart';

import '../../components/app_bar.dart';
import '../../components/nav_drawer.dart';
import '../../constants.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails(this.product, {Key? key}) : super(key: key);
  final Product product;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: buildAppBar(context, "Details", Icons.settings, scaffoldKey),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
                tag: widget.product.id,
                child: Image.network(
                  widget.product.imgPath,
                )),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Price",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          widget.product.price,
                          style: const TextStyle(
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
                        widget.product.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
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
                              widget.product.description,
                              style: TextStyle(
                                  color: kTextColor.withOpacity(.8),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Text(
                                  "Add to cart",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Text(
                                  "Buy now",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
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

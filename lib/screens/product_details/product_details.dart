import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/controllers/cart_controller.dart';
import 'package:plant_watch/models/product_model.dart';
import 'package:plant_watch/screens/home/home_screen.dart';

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
  Widget addToCart = const Text(
    "Add to cart",
    style: TextStyle(fontSize: 18, color: Colors.white),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: buildAppBar(context, scaffoldKey),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: widget.product.id,
              child: CachedNetworkImage(
                imageUrl: widget.product.imgPath,
                height: 300,
                progressIndicatorBuilder: (BuildContext context, String url,
                        DownloadProgress progress) =>
                    Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(
                        color: kPrimaryColor, value: progress.progress),
                  ),
                ),
                errorWidget: (context, url, error) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error,
                      color: kPrimaryColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: Text(
                        error.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 12, overflow: TextOverflow.fade),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Name: ",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              widget.product.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
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
                            SizedBox(
                              height: 150,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    widget.product.description,
                                    style: TextStyle(
                                        overflow: TextOverflow.fade,
                                        color: kTextColor.withOpacity(.8),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () async {
                                if (FirebaseAuth.instance.currentUser == null) {
                                  HomeScreen.selectedIndex = 2;
                                  Navigator.pushNamed(context, '/');
                                } else {
                                  if (widget.product.quantity <= 0) {
                                    setState(() {
                                      addToCart = const Text(
                                        "Sold Out",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      );
                                    });
                                  } else {
                                    setState(() {
                                      addToCart = const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                    await CartController.addToCart(
                                        widget.product.id,
                                        1,
                                        FirebaseAuth.instance.currentUser!.uid);
                                    setState(() {
                                      addToCart = const Text(
                                        "Added to Cart",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      );
                                    });
                                    HomeScreen.selectedIndex = 2;
                                    Navigator.pushNamed(context, '/');
                                  }
                                }
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 6),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                primary: Colors.white,
                                backgroundColor: kPrimaryColor,
                              ),
                              child: addToCart,
                            ),
                            TextButton(
                              onPressed: () {
                                HomeScreen.selectedIndex = 2;
                                Navigator.pushNamed(context, '/');
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 6),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                primary: Colors.white,
                                backgroundColor: kPrimaryColor,
                              ),
                              child: const Text(
                                "Buy Now",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      drawer: const NavigationDrawer(),
      drawerEnableOpenDragGesture: false,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: FloatingActionButton(
          child: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          backgroundColor: kPrimaryColor,
          elevation: 15,
        ),
      ),
    );
  }
}

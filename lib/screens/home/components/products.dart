import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/constants.dart';

import '../../../controllers/product_controller.dart';
import '../../../models/product_model.dart';
import '../../product_details/product_details.dart';
import '../home_screen.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: ProductController.topProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(children: [
                buildProduct(snapshot.data![0]),
                const SizedBox(
                  width: 8,
                ),
                buildProduct(snapshot.data![1]),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                buildProduct(snapshot.data![2]),
                const SizedBox(
                  width: 8,
                ),
                buildProduct(snapshot.data![3]),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                buildProduct(snapshot.data![4]),
                const SizedBox(
                  width: 8,
                ),
                buildProduct(snapshot.data![5]),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                buildProduct(snapshot.data![6]),
                const SizedBox(
                  width: 8,
                ),
                buildProduct(snapshot.data![7]),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                buildProduct(snapshot.data![8]),
                const SizedBox(
                  width: 8,
                ),
                buildProduct(snapshot.data![9]),
              ]),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  HomeScreen.selectedIndex = 1;
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
                child: const Text(
                  "Show Category Wise Products",
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(primary: kPrimaryColor),
              )
            ],
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
      },
    );
  }

  Widget buildProduct(Product product) {
    return SizedBox(
      height: 300,
      width: MediaQuery.of(context).size.width / 2.2,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProductDetails(product)));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: product.id,
                  child: product.quantity <= 0
                      ? Badge(
                          shape: BadgeShape.square,
                          badgeContent: const Text("Sold Out",
                              style: TextStyle(color: Colors.white)),
                          badgeColor: kPrimaryColor,
                          animationType: BadgeAnimationType.scale,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10)),
                            child: CachedNetworkImage(
                              imageUrl: product.imgPath,
                              height: 140,
                              progressIndicatorBuilder: (BuildContext context,
                                      String url, DownloadProgress progress) =>
                                  Center(
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: CircularProgressIndicator(
                                      color: kPrimaryColor,
                                      value: progress.progress),
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
                                          fontSize: 12,
                                          overflow: TextOverflow.fade),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                          child: CachedNetworkImage(
                            imageUrl: product.imgPath,
                            height: 140,
                            progressIndicatorBuilder: (BuildContext context,
                                    String url, DownloadProgress progress) =>
                                Center(
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator(
                                    color: kPrimaryColor,
                                    value: progress.progress),
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
                                        fontSize: 12,
                                        overflow: TextOverflow.fade),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  product.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  product.price,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: Text(
                    product.description,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

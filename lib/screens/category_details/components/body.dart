import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/constants.dart';
import 'package:plant_watch/controllers/product_controller.dart';
import 'package:plant_watch/models/product_model.dart';

import '../../product_details/product_details.dart';

class Body extends StatefulWidget {
  const Body(this.category, {Key? key}) : super(key: key);
  final String category;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
        stream: ProductController.findProduct(widget.category),
        builder: (context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasData) {
            return GridView(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 300),
              children: snapshot.data!.map(buildProduct).toList(),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const Center(
                child: CircularProgressIndicator(color: kPrimaryColor));
          }
        });
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

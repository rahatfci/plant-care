import 'package:flutter/material.dart';
import 'package:plant_watch/constants.dart';

import '../../../controllers/product_controller.dart';
import '../../../models/product_model.dart';
import '../../product_details/product_details.dart';

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
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/categories'),
                child: const Text("Show Category Wise Products"),
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
      height: 280,
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
              children: [
                Hero(
                  tag: product.id,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    child: Image.network(
                      product.imgPath,
                      height: 140,
                      width: MediaQuery.of(context).size.width / 2.5,
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
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  product.price,
                  style: const TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
      stream: ProductController.allProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: 200,
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 160),
              children: snapshot.data!.map(buildProduct).toList(),
            ),
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
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProductDetails(product)));
      },
      child: Column(
        children: [
          Hero(
            tag: product.id,
            child: Image.network(
              product.imgPath,
              height: 100,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            product.name,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          )
        ],
      ),
    );
  }
}

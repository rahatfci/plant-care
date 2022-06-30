import 'package:flutter/material.dart';
import 'package:plant_watch/constants.dart';
import 'package:plant_watch/controllers/product_controller.dart';
import 'package:plant_watch/models/product_model.dart';

import 'build_tile.dart';

class Body extends StatelessWidget {
  const Body(this.category, {Key? key}) : super(key: key);
  final String category;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
        stream: ProductController.findProduct(category),
        builder: (context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data!.length,
              padding: const EdgeInsets.all(15),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 110),
              itemBuilder: (context, i) {
                return buildTile(snapshot.data![i]);
              },
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const Center(
                child: CircularProgressIndicator(color: kPrimaryColor));
          }
        });
  }
}

import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../controllers/category_controller.dart';
import '../../../models/category_model.dart';
import 'build_tile.dart';

class CategoryBody extends StatelessWidget {
  const CategoryBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Category>>(
      stream: CategoryController.allCategory(),
      builder: (context, snapshot) {
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
              return buildTile(snapshot.data![i].name,
                  snapshot.data![i].imgPath, context, snapshot.data![i].color);
            },
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
}

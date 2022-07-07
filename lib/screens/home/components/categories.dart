import 'package:flutter/material.dart';
import 'package:plant_watch/constants.dart';
import 'package:plant_watch/screens/category_details/category_details_screen.dart';

import '../../../controllers/category_controller.dart';
import '../../../models/category_model.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Category>>(
      stream: CategoryController.allCategory(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: 95,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data!.map(buildCategory).toList(),
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

  Widget buildCategory(Category category) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CategoryDetailsScreen(category.name))),
      child: Padding(
        padding: const EdgeInsets.only(
          right: 15,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: [
              Image.network(
                category.imgPath,
                height: 60,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                color: const Color(0xffcdcdcd),
                child: Text(
                  category.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

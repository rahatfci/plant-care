import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/constants.dart';
import 'package:plant_watch/screens/category_details/category_details_screen.dart';

Widget buildTile(String text, String image, BuildContext context, int color) {
  return GestureDetector(
    onTap: () => Navigator.push(context,
        MaterialPageRoute(builder: (context) => CategoryDetailsScreen(text))),
    child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(color).withOpacity(1)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: CachedNetworkImageProvider(image,
                          errorListener: () => const Text(
                                "Something went wrong",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 8),
                              )),
                      backgroundColor: kPrimaryColor,
                    )
                  ],
                ),
                Text(text,
                    style: const TextStyle(
                        color: Color(0xff000000),
                        fontSize: 16,
                        fontWeight: FontWeight.bold))
              ]),
        )),
  );
}

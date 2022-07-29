import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/screens/carousel_details.dart';

import '../../../constants.dart';
import '../../../controllers/carousel_controller.dart';
import '../../../models/carousel_model.dart';

class Carousel extends StatelessWidget {
  const Carousel({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CarouselCustom>>(
        stream: CarouselControllerCustom.allCarousel(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) =>
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CarouselDetails(snapshot.data![itemIndex]))),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 3.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: kPrimaryColor.withOpacity(.5),
                          //borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data![itemIndex].imgPath,
                            fit: BoxFit.fill,
                            progressIndicatorBuilder: (BuildContext context,
                                    String url, DownloadProgress progress) =>
                                Center(
                              child: SizedBox(
                                height: 50,
                                width: 50,
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
                    ),
                options: CarouselOptions(height: 180, aspectRatio: 15 / 9));
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const Center(
              child: SizedBox(
                width: 50,
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              ),
            );
          }
        });
  }
}

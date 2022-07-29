import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/constants.dart';
import 'package:plant_watch/screens/home/components/tips_details.dart';

import '../../../controllers/tips_controller.dart';
import '../../../models/tips_model.dart';

class Tips extends StatefulWidget {
  const Tips({Key? key}) : super(key: key);

  @override
  State<Tips> createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: StreamBuilder<List<Tip>>(
          stream: TipsController.topTip(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GestureDetector(
                onTap: () async =>
                    await tipsDetails(context, snapshot.data![0]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.lightbulb,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.6,
                        child: Column(
                          children: [
                            Text(
                              snapshot.data![0].title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            SizedBox(
                              height: 60,
                              child: Text(
                                snapshot.data![0].description,
                                style: const TextStyle(
                                    color: Colors.white,
                                    overflow: TextOverflow.fade,
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data![0].imgPath,
                            height: 60,
                            fit: BoxFit.fill,
                            progressIndicatorBuilder: (BuildContext context,
                                    String url, DownloadProgress progress) =>
                                Center(
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                    color: kPrimaryColor,
                                    value: progress.progress),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 3, right: 3),
                              color: Colors.white,
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.error,
                                    color: kPrimaryColor,
                                  ),
                                  Text(
                                    "Image",
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
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
          }),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/models/tips_model.dart';

import '../../../constants.dart';

Future tipsDetails(BuildContext context, Tip tip) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          contentPadding:
              const EdgeInsets.only(bottom: 5, left: 15, right: 15, top: 15),
          title: Center(
              child: Text(tip.title,
                  style: const TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CachedNetworkImage(
                imageUrl: tip.imgPath,
                progressIndicatorBuilder: (BuildContext context, String url,
                        DownloadProgress progress) =>
                    Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
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
                      height: 3,
                    ),
                    Expanded(
                      child: Text(
                        error.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 10, overflow: TextOverflow.fade),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 2,
                color: kPrimaryColor,
              ),
              Center(
                  child: Text(
                tip.description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              )),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("Ok"),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        );
      });
}

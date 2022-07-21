import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/models/user_model.dart';
import 'package:plant_watch/screens/settings/components/build_tile.dart';
import 'package:plant_watch/screens/settings/components/edit_profile.dart';

import '../../../constants.dart';
import '../../../controllers/user_controller.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({Key? key}) : super(key: key);
  static String imageName = "Select Image";
  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.hasData) {
              User user = snapshot.data!;
              return FutureBuilder<UserCustom>(
                future: UserController.loggedUser(user.uid),
                builder: (context, AsyncSnapshot<UserCustom> snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Center(
                              child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CachedNetworkImage(
                              height: 100,
                              width: 100,
                              fit: BoxFit.fill,
                              imageUrl:
                                  FirebaseAuth.instance.currentUser!.photoURL!,
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
                                          fontSize: 10,
                                          overflow: TextOverflow.fade),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                          const SizedBox(height: 5),
                          Text(
                            user.displayName!,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            user.email!,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          GridView(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    mainAxisExtent: 110),
                            children: [
                              buildTile(
                                  "Total Order", 0xffdc9ba8, Icons.shopping_bag,
                                  count: snapshot.data!.totalOrder),
                              buildTile(
                                  "Total Saved", 0xff92b2a7, Icons.local_offer,
                                  count: snapshot.data!.totalSaved),
                              GestureDetector(
                                  onTap: () async {
                                    SettingsBody.imageName = "Select Image";
                                    await editProfile(context, snapshot.data!);
                                  },
                                  child: buildTile(
                                      "Edit Profile", 0xff63a3a8, Icons.edit)),
                              GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, '/support'),
                                child: buildTile("Help & Support", 0xffefbea3,
                                    Icons.support),
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    );
                  }
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
    );
  }
}

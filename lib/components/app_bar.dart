import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/screens/home/home_screen.dart';

import '../authentication/auth.dart';
import '../constants.dart';

Future<bool> isAdmin() async {
  return await (FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((value) {
    return value.data()!['userType'] == 'admin' ? true : false;
  }));
}

AppBar buildAppBar(BuildContext context, String title, IconData icon,
    GlobalKey<ScaffoldState> scaffoldKey) {
  void toggleDrawer() {
    if (scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.openEndDrawer();
    } else {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  return AppBar(
    leading: FutureBuilder<bool>(
        future: isAdmin(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!
                ? IconButton(
                    onPressed: toggleDrawer,
                    icon: const Icon(
                      Icons.menu,
                      size: 30,
                    ))
                : Icon(
                    icon,
                    size: 30,
                  );
          } else {
            return const SizedBox.shrink();
          }
        }),
    backgroundColor: kPrimaryColor,
    title: Text(
      title,
      style: const TextStyle(
          color: Colors.white, fontSize: 20, fontFamily: 'Poppins'),
    ),
    actions: <Widget>[
      IconButton(
        enableFeedback: false,
        icon: const Icon(
          Icons.public,
          size: 30,
        ),
        onPressed: () {
          HomeScreen.selectedIndex = 0;
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        },
      ),
      IconButton(
          icon: const Icon(
            Icons.logout,
            size: 30,
          ),
          onPressed: () async {
            await signOut(context);
          }),
    ],
  );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/screens/home/home_screen.dart';

import '../constants.dart';

AppBar buildAppBar(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
  void toggleDrawer() {
    if (scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.openEndDrawer();
    } else {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  return AppBar(
    backgroundColor: kPrimaryColor,
    leading: IconButton(
      onPressed: toggleDrawer,
      icon: const Icon(
        Icons.menu,
        size: 40,
      ),
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/launcher_icon.png',
          height: 40,
        ),
        const SizedBox(
          width: 10,
        ),
        const Text(
          "Plant Care",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: 'Poppins'),
        ),
      ],
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
      const SizedBox(
        width: 25,
      )
    ],
  );
}

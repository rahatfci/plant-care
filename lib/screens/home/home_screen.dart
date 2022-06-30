import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/screens/home/components/body.dart';

import '../../components/app_bar.dart';
import '../../components/bottom_nav.dart';
import '../../components/nav_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final User? user = FirebaseAuth.instance.currentUser;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar:
          buildAppBar(context, "Home", Icons.dashboard_outlined, scaffoldKey),
      body: const Body(),
      bottomNavigationBar: const MyBottomNavBar(),
      drawer: const NavigationDrawer(),
      drawerEnableOpenDragGesture: false,
    );
  }
}
